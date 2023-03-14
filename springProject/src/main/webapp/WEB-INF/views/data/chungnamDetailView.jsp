<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
<%-- <%@ taglib prefix="jsp" uri="" %> --%>

	<script>
		$(function(){
		
		});
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
