package com.coma.app.view.mypage;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.coma.app.biz.board.BoardDTO;
import com.coma.app.biz.board.BoardService;
import com.coma.app.biz.member.MemberDTO;
import com.coma.app.biz.member.MemberService;
import com.coma.app.biz.reservation.ReservationDTO;
import com.coma.app.biz.reservation.ReservationService;
import com.coma.app.view.annotation.LoginCheck;
import com.coma.app.view.function.ProfileUpload;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpSession;

//1022 완
@Controller
public class MyPageController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private ReservationService reservationService;
	@Autowired
	private ServletContext servletContext;
	@Autowired
	private HttpSession session;

	//----------페이지이동--------------
	@GetMapping("/myPage.do")
	public String myPage() {
		return "views/myPage";
	}
	@GetMapping("/editMyPage.do")
	public String editMyPage() {
		return "views/editMyPage";
	}
	//-------------------------------

	//MypagePageAction
	@LoginCheck
	@PostMapping("/myPage.do")
	public String myPage(MemberDTO memberDTO, BoardDTO boardDTO,ReservationDTO reservationDTO, Model model) {
		// 로그인된 사용자의 마이 페이지 처리

		// 예시로 로그인한 사용자 정보를 가져와서 모델에 추가
		String member_id = (String) session.getAttribute("MEMBER_ID");


		System.out.println("MyPage 로그인 정보 로그 : "+member_id);
		//------------------------------------------------------------------
		//내 정보 불러오는 코드 시작
		//사용자 정보 이름, 전화번호, 아이디, 프로필 이미지, 권한 전달
		memberDTO.setMember_id(member_id);
		memberDTO.setMember_condition("MEMBER_SEARCH_ID");
		memberDTO = this.memberService.selectOneSearchId(memberDTO);

		//회원가입할때 무언가 문제가 발생하여 이미지가 설정되지 못했다면
		//기본 default 이미지로 설정해야한다.
		String filename = memberDTO != null ? memberDTO.getMember_profile() : "default.jpg";

		//현재 웹 프로젝트의 경로를 반환받고 프로젝트 경로를 반환 받아옵니다.
		memberDTO.setMember_profile("/profile_img/" + filename);
		//내 정보 불러오는 코드 종료
		//------------------------------------------------------------------

		//------------------------------------------------------------------
		//관리자 권한이 있다면 신규 등록한 아이디 출력 시작
		if(memberDTO.getMember_role().equals("T")) {
			//사용자 정보 이름, 전화번호, 아이디, 프로필 이미지, 권한 전달
			memberDTO.setMember_condition("MEMBER_ALL_NEW");
			List<MemberDTO> member_list = this.memberService.selectAllNew(memberDTO);
			//FIXME VIEW 값 확인
			model.addAttribute("member_list", member_list);
		}
		//관리자 권한이 있다면 신규 등록한 아이디 출력 종료
		//------------------------------------------------------------------

		//사용자가 입력한 글 목록 출력 후 전달 시작
		//boardDTO.setBoard_writer_id(login); 모델에 mypage에서 쓸 컨디션 추가 부탁해야함
		boardDTO.setModel_board_searchKeyword(member_id);
		//이후 구현 예정
		System.err.println("MyPageController 로그 페이지 네이션 하드코딩 해둔 상태");
		boardDTO.setModel_board_min_num(0);//페이지 네이션 하드코딩했음
		boardDTO.setModel_board_max_num(300);//페이지 네이션 하드코딩했음
		//사용자가 입력한 글 목록 출력 후 전달 종료
		//------------------------------------------------------------------
		// 내 게시글 불러오는 코드 시작
		boardDTO.setModel_board_condition("BOARD_ALL_SEARCH_MATCH_ID");
		List<BoardDTO> boardList = this.boardService.selectAll(boardDTO);

		// 내 게시글 불러오는 코드 종료
		//------------------------------------------------------------------
		//내 예약정보 불러오는 코드 시작	
		//model에 reservation 테이블 정보를 요청
		//로그인 정보를 전달하기 위해 DTO에 추가
		reservationDTO.setModel_reservation_member_id(member_id);
		//요청해서 받을 값 (예약 PK번호 / 예약 암벽장 PK 번호 / 예약 암벽장 이름 / 예약 가격 / 암벽장 예약 날짜)
		List<ReservationDTO> model_Reservation_Datas = this.reservationService.selectAll(reservationDTO);
		//내 예약정보 불러오는 코드 종료
		//------------------------------------------------------------------
		//사용자 정보를 MEMBERDATA에 담아서 View로 전달			
		//내 게시글 정보를 BOARD에 담아서 View로 전달
		//내 예약 정보를 model_reservation_datas 에 담아서 View로 전달

		
		model.addAttribute("MEMBERDATA", memberDTO);
		model.addAttribute("BOARD", boardList);
		//FIXME V에서 앞에 model 빼야지 작동함
		model.addAttribute("reservation_datas", model_Reservation_Datas);

		return "views/myPage";
	}


	// DeleteMemberAction
	@LoginCheck
	@PostMapping("/deleteMember.do")
	public String deleteMember(MemberDTO memberDTO, Model model) {
		//기본으로 넘어가야하는 페이지 와 redirect 여부를 설정
		String path = "views/info";
		//로그인 정보가 있는지 확인해주고
		// 예시로 로그인한 사용자 정보를 가져와서 모델에 추가
		String member_id = (String) session.getAttribute("MEMBER_ID");

		//사용자 아이디를 DTO에 등록
		memberDTO.setMember_id(member_id);
		System.out.println("MyPageController deleteMember 로그 : "+member_id);

		//탈퇴전 사용자의 프로필이미지를 가져오기 위해 아이디 하나 검색하는 컨디션을 추가합니다.
		memberDTO.setMember_condition("MEMBER_SEARCH_ID");
		//탈퇴전 사용자의 프로필이미지를 가져와 줍니다.
		memberDTO = this.memberService.selectOneSearchId(memberDTO);
		//delete 를 성공하지 못했다면 Mypage로 보냅니다.
		boolean flag = this.memberService.delete(memberDTO);
		if(flag) {//멤버 삭제에 성공했다면 logout 페이지로 넘어갑니다.

			//탈퇴전 사용자의 프로필이미지를 변수에 추가해줍니다.
			String member_profile = memberDTO.getMember_profile();
			//사용자의 프로필이미지가 default 이미지가 아니라면 실행합니다.
			if(!member_profile.substring(0,member_profile.lastIndexOf(".")).equals("default")) {
				//받아온 프로필이미지를 삭제하기 위해 서버 주소를 추가해줍니다.
				String user_img_path = servletContext.getRealPath("/profile_img/" + member_profile);
				//파일 위치 확인용 로그
				System.out.println(user_img_path);
				//내 PC에 파일을 확인해줍니다.
				File file = new File(user_img_path);
				//파일이 있다면
				if(file.isFile()) {
					//삭제해줍니다.
					boolean flag_profile = file.delete();
					//삭제 확인용 로그
					System.out.println("프로필 삭제 여부 : "+flag_profile);
				}
			}
			System.err.println("회원탈퇴 성공 로그");
			model.addAttribute("msg", "회원 탈퇴 성공!");
			model.addAttribute("path", "main.do");
		}
		else {
			System.err.println("회원탈퇴 실패 로그");
			model.addAttribute("msg", "회원 탈퇴 실패...");
			model.addAttribute("path", "myPage.do");
		}
		return path;
	}


	//DeleteReservationAction
	@PostMapping("/deleteRerservation.do")
	public String deleteReservation(ReservationDTO reservationDTO, Model model) {	
		boolean flag =  this.reservationService.delete(reservationDTO);
		model.addAttribute("msg", "예약 취소 완료");
		if (!flag) {
			model.addAttribute("msg","예약 취소 실패");
		}
		model.addAttribute("path", "myPage.do");
		return "views/info";
	}

	@LoginCheck
	@PostMapping("/changeMember.do")
	public String changeMember(@RequestParam("photoUpload") MultipartFile photoUpload, 
			HttpSession session, Model model, MemberDTO memberDTO,
			ProfileUpload profileUpload) {

		String member_id = (String) session.getAttribute("MEMBER_ID");

		// 바꿀 사용자 아이디를 입력해줍니다.
		memberDTO.setMember_id(member_id);

		// 프로필 이미지 업로드 처리
		String filename = profileUpload.upload(photoUpload, session); // profileUpload 주입된 인스턴스 사용

		// uploadfile이 null이 아니라면 DB의 프로필 이미지를 변경합니다.
		if (!filename.isEmpty()) {
			System.out.println("uploadfile not null 로그 : " + filename);
			memberDTO.setMember_profile(filename); // 저장한 프로필 이미지로 변경합니다.
			memberDTO.setMember_condition("MEMBER_UPDATE_ALL");
		} else {
			System.out.println("uploadfile null 로그");
			memberDTO.setMember_condition("MEMBER_UPDATE_WITHOUT_PROFILE");
		}

		System.out.println("프로필 이미지 저장 로그: " + memberDTO); // 프로필 이미지 저장 로그
		System.err.println("filename 로그" + filename); 

		// 사용자 정보를 DB에 업데이트 요청
		boolean flag = this.memberService.updateWithoutProfile(memberDTO);

		if (!flag) {
			session.setAttribute("CHANGE_CHECK", flag);
		}

		return "views/myPage"; 
	}


	//ChangeMemberPageAction.do
	@LoginCheck
	@PostMapping("/changeMember.do")
	public String changeMember(MemberDTO memberDTO, Model model) {
		String member_id = (String) session.getAttribute("MEMBER_ID");
		//사용자 아이디를 model에 전달하고
		memberDTO.setMember_id(member_id);
		memberDTO.setMember_condition("MEMBER_SEARCH_ID");
		//전달해준 사용자 정보를 받아와 줍니다.
		memberDTO = this.memberService.selectOneSearchId(memberDTO);

		String profile = memberDTO.getMember_profile() != null ? memberDTO.getMember_profile() : "default.png";
		memberDTO.setMember_profile("/profile_img/" + profile);
		model.addAttribute("data", memberDTO);

		return "views/editmyPage"; 
	}


}
