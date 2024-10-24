<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html class="wf-publicsans-n3-active wf-publicsans-n4-active wf-publicsans-n5-active wf-publicsans-n6-active wf-publicsans-n7-active wf-fontawesome5solid-n4-active wf-fontawesome5regular-n4-active wf-simplelineicons-n4-active wf-fontawesome5brands-n4-active wf-active sidebar-color">
<head>
  <title>관리자 : 크루전 관리</title>
  <!-- Fonts and icons -->
  <script src="../../assets/js/plugin/webfont/webfont.min.js"></script>
  <script src="https://kit.fontawesome.com/7f7b0ec58f.js" crossorigin="anonymous"></script>

  <!-- CSS Files -->
  <link rel="stylesheet" href="../../assets/css/bootstrap.min.css" />
  <link rel="stylesheet" href="../../assets/css/plugins.min.css" />
  <link rel="stylesheet" href="../../assets/css/kaiadmin.css" />

  <!--   Core JS Files   -->
  <script src="../../assets/js/core/jquery-3.7.1.min.js"></script>
  <script src="../../assets/js/core/bootstrap.min.js"></script>

  <!-- template Js File -->
  <script src="../../assets/js/kaiadmin.min.js"></script>

  <%-- pagination Js File --%>
  <script src="../../js/pagination.js"></script>

  <%-- ajax Js File--%>
  <script src="../../js/crewManagementAjax.js"></script>

</head>
<body class="user-select-none">
<mytag:admin_gnb member_id="Controller 데이터 입력할 예정"></mytag:admin_gnb>

<div class="main-panel p-2 overflow-x-hidden">
  <div class="nav-toggle position-absolute top-0 start-0">
    <button class="sidenav-toggler btn btn-icon btn-round btn-white h-100 w-25">
      <i class="fa fa-align-left"></i>
    </button>
  </div>

  <div class="col-md-12 align-content-center">
    <h1 class="text-center mt-5 mb-4">크루전 관리</h1>
  </div>

  <!-- FIXME 검색 코드 시작 -->
  <!--TODO action 명 변경해야함-->
  <form action="" method="GET" class="row mb-3" id="member-search-form">
    <div class="row mb-3">
      <div class="d-flex justify-content-between align-items-center">
        <div class="col-md-2 ms-auto">
          <select class="form-select form-control" id="member-select" name="search_keyword">
            <option value="NUM" selected>크루전 번호</option>
            <option value="MEMBERNAME" >암벽장 이름</option>
            <option value="MEMBERID" >경기 날짜</option>
            <option value="DATE" >크루전 생성일</option>
          </select>
        </div>
        <div class="col-md-7">
          <input type="text" class="form-control" name="search_content" placeholder="검색어를 입력해주세요">
        </div>
        <div class="me-auto">
          <button class="btn btn-primary btn-border" type="submit">검색</button>
        </div>
      </div>
    </div>
  </form><!-- 검색 코드 종료 -->

  <!-- FIXME 크루전 리스트 코드 시작 -->
  <div class="row text-center d-flex justify-content-center">
    <div class="col-md-10">
      <table class="table caption-top" id="member-table">
        <thead>
        <tr>
          <th scope="col" class="col-md-1">크루전 번호</th>
          <th scope="col" class="col-md-3">암벽장 이름</th>
          <th scope="col" class="col-md-3">경기 날짜</th>
          <th scope="col" class="col-md-3">크루전 생성일</th>
          <th scope="col" class="col-md-2">결과</th>
        </tr>
        </thead>
        <tbody id="member-tbody">
        <c:if test="${empty datas}" var="crew">
          <tr>
            <td colspan="5">현재 크루가 없습니다.</td>
          </tr>
        </c:if>
        <c:if test="${not empty datas}">
          <c:forEach items="${datas}" var="data">
            <tr class="battle-table-tr">
              <th scope="row" class="battle_num">${data.battle_num}</th>
              <td><a class="submenu text-dark gym_name" href="crewManagementDetail.jsp?battle_num=${data.battle_num}">${data.gym_name}</a></td>
              <td class="battle_game_date">${data.battle_game_date}</td>
              <td class="battle_registration_date">${data.battle_registration_date}</td>
              <input type="hidden" class="battle_isGame" value="${isGame}"/>
              <td class="td_btn"> </td>
            </tr>
          </c:forEach>
        </c:if>
        </tbody>
      </table>
    </div>
  </div><!-- 크루전 리스트 코드 종료 -->

  <!-- FIXME 페이지네이션 코드 시작 -->
  <div id="pageNation" class="row justify-content-center">
    <div class="row pt-5">
      <div class="col-md-12 d-flex justify-content-center ">
        <nav aria-label="Page navigation">
          <input type="hidden" id="totalCount" value="${total}">
          <input type="hidden" id="currentPage" value="${page}">
          <ul id="pagination" class="pagination justify-content-center align-items-center">

          </ul>
        </nav>
      </div>
    </div>
  </div>
  <!-- 페이지네이션 리스트 코드 종료 -->
</div>

<!-- FIXME modal 코드 시작-->
<!-- TODO action 명 변경 해야함 -->
<form action="" method="POST" id="modal-form">
  <div class="modal fade" id="modal" tabindex="-1" aria-labelledby="gym-modal-title" aria-hidden="true">
    <div class="modal-dialog">
      <div class="modal-content rounded-4">
        <div class="modal-header d-flex justify-content-center rounded-top-4">
          <p class="h2 modal-title ms-auto">크루전 결과 등록</p>
          <button type="button" class="btn btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body flex-fill bg-light" id="">
          <div class="row text-center d-flex justify-content-center">
            <div class="row">
              <label for="gym-name" id="gym-modal-title" class="col-sm-2 col-form-label">암벽장</label>
              <div class="col-sm-10">
                <input type="text" class="form-control-plaintext" id="gym-name" placeholder="ex)더클라이밍" value="" readonly>
                <input type="hidden" id="gym-num" value="">
              </div>
            </div>
            <div class="row">
              <label for="gym-game-date" class="col-sm-2 col-form-label">경기일</label>
              <div class="col-sm-10">
                <input type="text" class="form-control-plaintext" id="gym-game-date" placeholder="ex)2024-10-06" value="" readonly>
              </div>
            </div>
            <div class="row">
              <label for="winner-crew" class="col-sm-2 col-form-label">승리크루</label>
              <div class="col-sm-10">
                <select class="form-select" id="winner-crew" name="winner-crew">
                  <option>승리크루</option>
                  <!-- 비동기로 데이터를 받을 예정 -->
                </select>
              </div>
            </div>
            <div class="row">
              <label for="mvp" class="col-sm-2 col-form-label">MVP</label>
              <div class="col-sm-10" id="mvp-div">
                <div class="row">
                  <div class="col-md-6">
                    <select class="form-select" id="mvp-crew" name="mvp_crew">
                      <option>MVP CREW</option>
                      <!-- 비동기로 데이터를 받을 예정 -->
                    </select>
                  </div>
                  <div class="col-md-6">
                    <select class="form-select" id="mvp" name="mvp">
                      <option>MVP</option>
                      <!-- 비동기로 데이터를 받을 예정 -->
                    </select>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger" data-bs-dismiss="modal">취소</button>
          <button type="button" class="btn btn-primary">등록</button>
        </div>
      </div>
    </div>
  </div>
</form><!-- modal HTML 코드 종료-->

<%-- FIXME modal Js 시작 --%>
<script>
  let modal = $('#modal'); //모달 태그 선택
  let winner_crew_select = $('#winner-crew'); //승리 크루 select 태그 선택
  let mvp_crew_select = $('#mvp-crew'); //mvp 크루 select 태그 선택
  let mvp_select = $('#mvp'); // mvp select 태그 선택
  //크루전 번호
  let battle_num_text = "";

  $(document).ready(function () {

    //FIXME modal 창 정보 입력 코드 시작
    const table_datas = $('.battle-table-tr');

    table_datas.each(function () {

      //암벽장 이름 태그
      const gym_name = $(this).find('.gym_name');
      //크루전 번호 태그
      const battle_num = $(this).find('.battle_num');
      //크루전 생성일자 태그
      const battle_registration_date = $(this).find('.battle_registration_date');
      //경기 시작일 태그
      const battle_game_date = $(this).find('.battle_game_date');
      //버튼이 생성될 td 태그
      const td_btn = $(this).find('.td_btn');
      //경기 시작일
      const battle_game_date_text = battle_game_date.text();

      //경기 정보 등록 여부
      const battle_isGame = $(this).find('.battle_isGame');

      //날짜 비교하면서 버튼 생성할 함수
      isDate(battle_game_date_text, battle_isGame.val(),td_btn);

      //생성된 버튼 확인해서 모달창 실행
      const button = $(this).find('.btn');

      button.on('click',function () {
        //크루전 생성일자
        const battle_registration_date_text = battle_registration_date.text();
        //암벽장 이름
        const gym_name_text = gym_name.text();
        //크루전 번호
        battle_num_text = battle_num.text();

        //암벽장 이름
        console.log('암벽장 이름 : '+gym_name_text);
        //크루전 번호
        console.log('크루전 번호 : '+battle_num_text);
        //크루전 생성일자
        console.log('암벽장 생성일 : '+battle_registration_date_text);
        //경기 시작일
        console.log('암벽장 경기일 : '+battle_game_date_text);

        //modal 데이터 입력
        //암벽장 이름
        $('#gym-name').val(gym_name_text);
        //경기일
        $('#gym-game-date').val(battle_game_date_text);
        //크루전 번호
        $('#gym-num').val(battle_num_text);
      })
    });//modal 창 정보 입력 코드 종료

    //FIXME Date 비교 JS 시작
    function isDate(battle_date, isGame,tdBtn) {
      console.log(isGame);
      var button_end = '<button class="d-inline-block px-4 py-2 border rounded transition bg-info  bg-success h6" >경기 종료</button>';
      var button_before = '<button class="btn btn-danger h6" data-bs-toggle="modal" data-bs-target="#modal">결과 입력 전</button>';
      var button_game_before = '<button class="d-inline-block px-4 py-2 border rounded transition bg-info  bg-warning h6" >경기 시작 전</button>';
      var button_game = '<button class="d-inline-block px-4 py-2 border rounded transition bg-info h6" >경기중</button>';
      if (isGame === 'T'){
        console.log('크루전 종료')
        tdBtn.append(button_end);
      }
      else{
        if (today() > battle_date) {
          console.log('경기 결과 입력전' + battle_date)
          tdBtn.append(button_before);
        }
        else if (today() == battle_date) {
          console.log('크루전 경기중' + battle_date)
          tdBtn.append(button_game);
        }
        else if (today() < battle_date) {
          console.log('크루전 경기 시작전' + battle_date)
          tdBtn.append(button_game_before);
        }
      }
    }// Date 비교 JS 종료

    function today() {
      var date = new Date();
      console.log('today log : ['+date+']')
      return date.getFullYear() + '-' + ('0' + (date.getMonth() + 1)).slice(-2)  + '-' + ('0' + date.getDate()).slice(-2);
    }

  })
</script><!-- modal JS 종료-->


<!-- modal 코드 종료-->

</body>
</html>