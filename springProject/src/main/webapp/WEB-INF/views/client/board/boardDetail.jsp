<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%-- <%@ taglib prefix="jsp" uri="" %> --%>

	<script>
			let buttonCheck = 0; // 수정버튼과 삭제버튼을 구별하기 위한 변수
			
		$(function(){
			$("#pwdChk").css("visibility", "hidden");
			
			/* 수정 버튼 클릭 시 처리 이벤트 */
			$("#updateFormBtn").click(function () {
				$("#pwdChk").css("visibility", "visible");
				$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
				buttonCheck = 1;
			});
			
			/* 삭제 버튼 클릭 시 처리 이벤트 */
			/* $("#boardDeleteBtn").click(function () {
				$("#pwdChk").css("visibility", "visible");
				$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
				buttonCheck = 2;
			}); */
			
			/* 삭제 버튼 클릭시 댓글 확인 후 처리 이벤트 */
			$("#boardDeleteBtn").click(function () {
				$.ajax({
					url : "/board/replyCnt",
					type : "post",
					data : "b_num="+$("#b_num").val(),
					dataType : "text",
					error : function(){
						alert('시스템 오류. 관리자에게 문의하세요.');
					},
					success : function(resultData){
						if(resultData === "0"){ // === 값과 자료형이 일치했을때, 
							$("#pwdChk").css("visibility", "visible");
							$("#msg").text("작성시 입력한 비밀번호를 입력해 주세요.").css("color","#000099");
							buttonCheck = 2;
						} else {
							alert('댓글 존재시 게시물 작성할 수가 없습니다. \n댓글 삭제 후 다시 확인해 주세요.');
							return;
						}
					}
				});
			});
			
			/* 비밀번호 입력 양식 enter 제거 */
			$("#b_pwd").bind("keydown", function(event){
				if(event.keyCode === 13){ 	// 0 == "0" => 값비교(true) 0 === "0" ==> 값과 자료형 비교(false)
					event.preventDefault();
				}
			});
				
			/* 비밀번호 확인 버튼 클릭 시 처리 이벤트 */
			$("#pwdBtn").click(function () {
				boardPwdConfirm();
			});
			
			/* 글쓰기 버튼 클릭 시 처리 이벤트 */
			$('#insertFormBtn').click(function () {
				location.href = "/board/writeForm";
			});
			
			/* 목록 버튼 클릭 시 처리 이벤트 */
			$("#boardListBtn").click(function () {
				location.href = "/board/boardList";
			});
			
		});
			
	
		/* 비밀번호 확인 버튼 클릭시 실질적인 처리 함수 */
		function boardPwdConfirm() {
			//if (!chkData("#b_num","비밀번호를")) return;
			if(!formCheck('#b_pwd','#msg','비밀번호를')) return;
			else {
				$.ajax({
					url : "/board/pwdConfirm", // 전송 url
					type : "post",					// 전송 시 method 방식
					data : $("#f_pwd").serialize(), // 폼전체 데이터 전송
					dataType : "text",
					error :  function () {			// 실행시 오류가 발행하였을 경우 
						alert('시스템 오류입니다. 관리자에게 문의 하세요.');
					}, 								// 정상적으로 실행이 되었을 경우
					success : function (resultData) {
						let goUrl = "";				// 이동할 경로를 저장할 변수
						if(resultData == "실패"){ //일치하지 않는 경우
							$("#msg").text("작성시 입력한 비밀번호가 일치하지 않습니다.").css("color","red");
							$("#b_pwd").select();
							
						}else if (resultData == "성공") { // 일치할 경우
							$("#msg").text("");
						
							if(buttonCheck == 1){ // 수정버튼 클릭
								goUrl = "/board/updateForm";
								$("#f_data").attr("action",goUrl);
								$("#f_data").submit();
								
							} else if (buttonCheck == 2) { // 삭제버튼 클릭
								if(confirm("정말 삭제하시겠습니까?")){
									goUrl = "/board/boardDelete";
									$("#f_data").attr("action",goUrl);
									$("#f_data").submit();
								}
							}
						}
					}
				});
			}
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<form id="f_data" name="f_data" method="post">
				<input type="hidden" name="b_num" value="${detail.b_num}">
				<input type="hidden" name="b_file" value="${detail.b_file}">
				<input type="hidden" name="b_thumb" value="${detail.b_thumb}">
			</form>
			
			<%-- ======================= 비밀번호 확인 버튼 및 버튼 추가 시작 ======================= --%>
			<div id="boardPwdBut" class="row text-center">
				<div id="pwdChk" class="authArea col-md-8 text-left">
					<form name="f_pwd" id="f_pwd" class="form-inline">
						<input type="hidden" id="b_num" name="b_num" value="${detail.b_num}">
						<label for="b_pwd" id="l_pwd">비밀번호 : </label>
						<input type="password" class="form-control" id="b_pwd" name="b_pwd">
						
						<button type="button" id="pwdBtn" class="btn btn-default">확인</button>
						<span id="msg"></span>
					</form>
				</div>
				<div class="btnArea col-md-4 text-right">
					<input type="button" value="글수정" id="updateFormBtn" class="btn btn-success"/>
					<input type="button" value="글삭제" id="boardDeleteBtn" class="btn btn-success"/>
					<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success"/>
					<input type="button" value="목록" id="boardListBtn" class="btn btn-success"/>
				</div>
			</div>
			<%-- ======================= 비밀번호 확인 버튼 및 버튼 추가 종료 ======================= --%>
			
			<%-- ======================= 상제 정보 보여주기 시작 ======================= --%>
			<div class="contentTB text-center">
				<table class="table table-boardered">
					<tbody>
						<tr>
							<td class="col-md-3">작성자</td>
							<td class="col-md-3 text-left">${detail.b_name } (조회수 : ${detail.readcnt})</td>
							<td class="col-md-3">작성일</td>
							<td class="col-md-3 text-left">${detail.b_date }</td>
						</tr>
						<tr>
							<td class="col-md-4">글제목</td>
							<td colspan="3" class="col-md-8 text-left">${detail.b_title }</td>
						<tr>
						<tr>
							<td class="col-md-4">글내용</td>
							<td colspan="3" class="col-md-8 text-left">${detail.b_content }</td>
						<tr>
						<c:if test="${not empty detail.b_file}">
						<tr>
							<td class="col-md-4">이미지</td>
							<td colspan="3" class="col-md-8 text-left">
								<img src="/uploadStorage/board/${detail.b_file }"/>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			<%-- ======================= 상제 정보 보여주기 종료 ======================= --%>
			<jsp:include page="reply.jsp" />
		</div>
	</body>
</html>
