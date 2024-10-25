<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html class="wf-publicsans-n3-active wf-publicsans-n4-active wf-publicsans-n5-active wf-publicsans-n6-active wf-publicsans-n7-active wf-fontawesome5solid-n4-active wf-fontawesome5regular-n4-active wf-simplelineicons-n4-active wf-fontawesome5brands-n4-active wf-active sidebar-color">
<head>
  <title>관리자 : 메인</title>
  <!-- Fonts and icons -->
  <script src="../../assets/js/plugin/webfont/webfont.min.js"></script>
  <script src="https://kit.fontawesome.com/7f7b0ec58f.js" crossorigin="anonymous"></script>

  <!-- CSS Files -->
  <link rel="stylesheet" href="../../assets/css/bootstrap.min.css" />
  <link rel="stylesheet" href="../../assets/css/plugins.min.css" />
  <link rel="stylesheet" href="../../assets/css/kaiadmin.css" />

  <!--   Core JS Files   -->
  <script src="../../assets/js/core/jquery-3.7.1.min.js"></script>
  <script src="../../assets/js/core/popper.min.js"></script>
  <script src="../../assets/js/core/bootstrap.min.js"></script>
  <script src="../../assets/js/plugin/jquery-scrollbar/jquery.scrollbar.min.js"></script>

  <!-- template Js File -->
  <script src="../../assets/js/kaiadmin.min.js"></script>

  <!-- Chart Js CDN -->
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

</head>
<body class="user-select-none">
<mytag:admin_gnb member_id="Controller 데이터 입력할 예정"></mytag:admin_gnb>

<div class="main-panel p-2 overflow-x-hidden">
  <div class="nav-toggle position-absolute top-0 start-0">
    <button class="sidenav-toggler btn btn-icon btn-round btn-white h-100 w-25">
      <i class="fa fa-align-left"></i>
    </button>
  </div>

  <!-- FIXME 메인 대시보드 데이터 정보 코드 시작 -->
  <div class="dashboard row text-center d-flex justify-content-center">
    <!-- cards 생성 공간 -->
  </div><!-- 메인 대시보드 데이터 정보 코드 종료 -->
  <hr/>
  <!-- FIXME 대시보드 표 시작 -->
  <div class="row text-center d-flex justify-content-center" id="chart_div">
    <div class="row">
      <div class="col-md-5" id="chart_div_left">

      </div>
      <div class="col-md-7" id="chart_div_right">

      </div>
    </div>
  </div><!-- 대시보드 표 종료 -->
  <hr>
  <!-- FIXME 최신글 5개 코드 시작 -->
  <div class="row text-center" id="board-div">
    <div class="col-md-12 d-flex justify-content-between align-items-center">
      <h2 class="ms-auto">최신글 5개 </h2>
      <div class="badge badge-info ms-auto"><a href="#" > 더보기 <span class="btn-label"><i class="fas fa-plus"></i></span></a></div>
    </div>
    <div class="accordion" id="board-accordion">

      <c:if test="${empty datas}">
      <div class="accordion-item">
        <h2 class="accordion-header" id="board_aria_labelledby">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#aria_controls" aria-expanded="true" aria-controls="aria_controls">
            최근글이 없습니다.
          </button>
        </h2>
      </div>
    </c:if>
    <c:if test="${not empty datas}">
      <c:forEach items="${datas}" var="data" varStatus="status">
        <div class="accordion-item">
          <h2 class="accordion-header" id="board_aria_labelledby${status}">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#board_aria_controls${status}" aria-expanded="true" aria-controls="board_aria_controls${status}">
              data.board_title
            </button>
          </h2>
          <div id="board_aria_controls${status}" class="accordion-collapse collapse" aria-labelledby="board_aria_labelledby${status}" data-bs-parent="#board_data_bs_parent${status}">
            <div class="accordion-body">
              data.board_content
            </div>
          </div>
        </div>
      </c:forEach>
    </c:if>

    </div>
  </div>
  <!-- 최신글 5개 코드 종료 -->
  <hr>
  <!-- FIXME 최근 경기 5개 코드 시작 -->
  <div class="row text-center" id="gym-div">
    <div class="col-md-12 d-flex justify-content-between align-items-center">
      <h2 class="ms-auto">최근경기 5개 </h2>
      <div class="badge badge-info ms-auto"><a href="#">더보기 <span class="btn-label"><i class="fas fa-plus"></i></span></a></div>
    </div>
    <div class="accordion" id="gym-accordion">

      <c:if test="${empty datas}">
      <div class="accordion-item">
        <h2 class="accordion-header" id="gym_aria_labelledby">
          <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#aria_controls" aria-expanded="true" aria-controls="aria_controls">
            최근경기가 없습니다.
          </button>
        </h2>
      </div>
    </c:if>
    <c:if test="${not empty datas}">
      <c:forEach items="${datas}" var="data" varStatus="status">
        <div class="accordion-item">
          <h2 class="accordion-header" id="gym_aria_labelledby${status}">
            <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#gym_aria_controls${status}" aria-expanded="true" aria-controls="gym_aria_controls${status}">
              data.board_title
            </button>
          </h2>
          <div id="gym_aria_controls${status}" class="accordion-collapse collapse" aria-labelledby="gym_aria_labelledby${status}" data-bs-parent="#gym_data_bs_parent${status}">
            <div class="accordion-body">
              data.board_content
            </div>
          </div>
        </div>
      </c:forEach>
    </c:if>

    </div>
  </div>
  <!-- 최근 경기 5개 코드 종료 -->
</div>
</body>

<%-- FIXME Html 생성 JavaScript 코드 시작 --%>
<script>
  //웹 문서가 모두 로드된 후 실행
  $(document).ready(function() {
    //----------------------------------------------------------------------
    // json 형식으로 데이터를 저장
    const card_data = [
      {title: "사용자", text: "1294"},
      {title: "암벽장", text: "20"},
      {title: "예약", text: "30"},
      {title: "게시판", text: "576"},
      {title: "크루전", text: "51"},
    ];

    //상당 Html 코드 생성 함수 TODO 내용 변경할 DTO 생기면 변경해야함
    function bootstrap_card_html(card) {
      return '<div class="col-sm-6 col-md-2">' +
              '<div class="card card-stats card-round">' +
              '<div class="card-body">' +
              '<div class="row align-items-center">' +
              '<div class="numbers">' +
              '<p class="card-title">' + card.title + '</p>' +
              '<h4 class="card-text">' + card.text + '</h4>' +
              '</div></div></div></div></div>';
    }
    //생성된 Html 코드 추가
    $(".dashboard").append(card_data.map(bootstrap_card_html).join(''));
    //----------------------------------------------------------------------
    function bootstrap_card_html_chart(id, title, canvas_id, card_body_style) {
      return '<div class="card flex-fill" id="'+id+'">'+
              '<div class="card-header">'+
              '<h3>'+title+'</h3>'+
              '</div>'+
              '<div class="card-body text-center d-flex justify-content-center" style="height: '+card_body_style+'px;">'+
              '<canvas id="'+canvas_id+'">'+
              '</canvas></div></div>';
    }
    $("#chart_div_left").append(bootstrap_card_html_chart('member_chart_div', '월별 가입자','member_chart',250));
    $("#chart_div_left").append(bootstrap_card_html_chart('reservation_chart_div', '월별 예약', 'reservation_chart',250));
    $("#chart_div_right").append(bootstrap_card_html_chart('gym_chart_div', '암벽장', 'gym_chart',600));
    //----------------------------------------------------------------------
});
</script>
<%-- Html 생성 JavaScript 코드 종료 --%>

<%-- FIXME Chart 생성 JavaScript 코드 시작 --%>
<script type="importmap">
  {
      "imports": {
          "chartConfig": "./js/chartConfig.js",
          "chartJs": "./js/chart.js"
      }
  }
</script>
<script>
//TODO Chart_Data 바꾸면됨
  //----------------------------
  //가입자 chart 데이터
  const member_Chart_Data = [
    {tile: '월', text: '10'},
    {tile: '화', text: '15'},
    {tile: '수', text: '100'},
    {tile: '목', text: '7'},
    {tile: '금', text: '4'},
    {tile: '토', text: '1'},
    {tile: '일', text: '5'},
  ];
  //가입자 데이터 제목
  const member_Chart_Data_title = member_Chart_Data.map(data => data.tile);
  //가입자 데이터 내용
  const member_Chart_Data_text = member_Chart_Data.map(data => data.text);
  //----------------------------
  //----------------------------
  //예약자 chart 데이터
  const registration_Chart_Data = [
    {tile: '월', text: '10'},
    {tile: '화', text: '15'},
    {tile: '수', text: '100'},
    {tile: '목', text: '7'},
    {tile: '금', text: '4'},
    {tile: '토', text: '1'},
    {tile: '일', text: '5'},
  ];
  //예약자 데이터 제목
  const registration_Chart_Data_title = registration_Chart_Data.map(data => data.tile);
  //예약자 데이터 내용
  const registration_Chart_Data_text = registration_Chart_Data.map(data => data.text);
  //----------------------------
  //----------------------------
  //암벽장 chart 데이터
  const gym_Chart_Data = [
    {tile: '월', text: '10'},
    {tile: '화', text: '15'},
    {tile: '수', text: '100'},
    {tile: '목', text: '7'},
    {tile: '금', text: '4'},
    {tile: '토', text: '1'},
    {tile: '일', text: '5'},
  ];
  //암벽장 데이터 제목
  const gym_Chart_Data_title = member_Chart_Data.map(data => data.tile);
  //암벽장 데이터 내용
  const gym_Chart_Data_text = member_Chart_Data.map(data => data.text);
  //----------------------------

</script>
<script type="module" src="../../js/chart.js"></script>
<%-- Chart 생성 JavaScript 코드 종료 --%>

</html>
