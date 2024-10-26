<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="mytag" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>코마 : 게시글확인 </title>

    <!-- Fonts and icons -->
    <script src="assets/js/plugin/webfont/webfont.min.js"></script>
    <script src="https://kit.fontawesome.com/7f7b0ec58f.js"
            crossorigin="anonymous"></script>

    <!-- CSS Files -->
    <link rel="stylesheet" href="assets/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="assets/css/plugins.min.css"/>
    <link rel="stylesheet" href="assets/css/kaiadmin.css"/>

    <style type="text/css">

        figure.image_resized img {
            width: 100%; /* figure의 크기를 유지 */
            height: auto; /* 이미지 비율 유지하기 위함 */
        }
    </style>
</head>
<body>
<mytag:admin_gnb member_id="Controller 데이터 입력할 예정"></mytag:admin_gnb>
<!-- container start -->
<div class="container">
    <div class="page-inner">
        <div class="row py-3">
            <div class="col-12">
                <h1 class="text-center">${BOARD.board_title}</h1>
            </div>
        </div>
        <div class="row border-bottom border-dark pb-3">
            <div class="col-md-1 d-flex justify-content-end align-items-center">
                <div class="avatar avatar-sm">
                    <img src="${member_profile}" alt="profile"
                         class="avatar-img rounded-circle"/>
                </div>
            </div>
            <div class="col-md-11 d-flex align-items-center">
                <p class="mb-0">작성자: ${BOARD.board_writer_id}</p>
            </div>
        </div>
        <div class="row py-5">
            <div class="col-12 d-flex justify-content-center">
                <div class="w-75">
                    <p class="text-start">${BOARD.board_content}</p>
                </div>
            </div>
        </div>
        <div class="row border-top border-dark py-3">
            <form action="reply.do" method="POST">
                <input type="hidden" name="board_id" value="${BOARD.board_num}"/>
                <div class="row">
                    <div class="col-11">
                        <div class="form-group">
                            <input name="reply_content" type="text" class="form-control"
                                   id="comment" placeholder="댓글를 입력해주세요"/>
                        </div>
                    </div>
                    <div class="col-1 d-flex align-items-center">
                        <button type="submit" class="btn btn-secondary">댓글</button>
                    </div>
                </div>
            </form>
        </div>
        <c:forEach var="reply" items="${REPLY}">
        <c:choose>
        <c:when test="${not empty REPLY}">
        <div class="row border-top border-bottom py-3 px-5 comment-item">
            <div class="col-md-2">
                <p>작성자: ${reply.reply_writer_id}</p>
            </div>
            <div class="col-md-9">
                <p class="comment-text">${reply.reply_content}</p>
            </div>
            <div class="col-1">
                <button class="btn btn-icon btn-clean me-0" type="button" id="deleteButton"
                        data-reply-num="${reply.reply_num}" data-board-num="${BOARD.board_num}">
                    삭제
                </button>
            </div>
        </div>
        </c:when>
        </c:choose>
        </c:forEach>

        <!--   Core JS Files   -->
        <script src="assets/js/core/jquery-3.7.1.min.js"></script>
        <script src="assets/js/core/popper.min.js"></script>
        <script src="assets/js/core/bootstrap.min.js"></script>

        <script>
            // DOMContentLoaded 이벤트가 발생하면 콜백 함수를 실행
            // 즉, DOM이 완전히 로드된 후에 이 코드가 실행
            $(document).ready(function () {
                $("#deleteButton").click(function () {
                    sweetAlert_confirm_warning('댓글 삭제', '정말로 삭제하시겠습니까?', '삭제', '취소')
                        .then(function (replyDelete) {
                            if (replyDelete) {
                                // 폼 생성
                                var form = $('<form/>', {
                                    //TODO
                                    action: '컨트롤러가 지정해준 값.do',
                                    method: 'POST',
                                    style: 'display: none;'
                                });
                                var boardNum = $(this).data("boardNum");
                                var replyNum = $(this).data("replyNum");

                                console.log("boardNum =[" + boardNum + "]");
                                console.log("replyNum =[" + replyNum + "]");
                                form.append($('<input/>', {type: 'hidden', name: 'board_num', value: boardNum}));
                                form.append($('<input/>', {type: 'hidden', name: 'reply_num', value: replyNum}));
                            }

                            console.log("폼 HTML = [" + form.html() + "]"); // 폼 내부의 HTML 내용 출력
                            form.appendTo('body').submit(); // 폼을 body에 추가하여 제출
                            // sweetAlert_success('삭제가 완료되었습니다', ' ');
                            //TODO 컨트롤러가 인포페이지로 이동해줄것
                        });
                });
            });
        </script>
</body>
</html>