<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

<script type="text/javascript">
	$(function(){
		/* 수정 버튼 클릭 시 처리 이벤트*/
		$("#boardUpdateBtn").click(function () {
			
			if(!chkData("#b_title", "제목을")) return;
			else if (!chkData("#b_content", "작성할 내용을")) return;
			else {
				if($("#file").val() != ""){/* 파일이 존재하면 */
					if(!chkFile($("#file"))) return;
				}
				$("#f_updateForm").attr({
					"method":"post",
					"enctype":"multipart/form-data",
					"action":"/board/boardUpdate"
				});
				$("#f_updateForm").submit();
			}
		});
		
		/*취소 버튼 클릭 시 처리 이벤트 */
		$('#boardCancelBtn').click(function () {
			$('#f_updateForm').each(function () {
				this.reset();
			});
		});
		
		/* 목록 버튼 클릭 시 처리 이벤트 */
		$('#boardListBtn').click(function () {
			location.href="/board/boardList";
		});
	});
</script>
</head>
<body>
	<div class="contentContainer container">
		<div class="contentTB text-center">
			<form id="f_updateForm" name="f_updateForm">
				<input type="hidden" id="b_num" name="b_num" value="${update.b_num }">
				<input type="hidden" id="b_file" name="b_file" value="${update.b_file }">
				<input type="hidden" id="b_thumb" name="b_thumb" value="${update.b_thumb }">
			
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td class="col-md-3">글번호</td>
							<td class="text-left col-md-3">${update.b_num }</td>
							<td class="col-md-3">작성일</td>
							<td class="text-left col-md-3">${update.b_date}</td>
						</tr>
						<tr>
							<td>작성자</td>
							<td colspan="3" class="text-left">${update.b_name }</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td colspan="3" class="text-left">
								<input type="text" name="b_title" id="b_title" value="${update.b_title }" class="form-control">
							</td>
						</tr>
						<tr class="table-tr-height"><!-- 일정한 높이를 주기위한 클래스 -->
							<td>내용</td>
							<td colspan="3" class="text-left">
								<textarea rows="8" name="b_content" id="b_content" class="form-control">${update.b_content }</textarea>
							</td>
						</tr>
						<tr class="form-inline">
							<td>비밀번호</td>
							<td colspan="3" class="text-left">
								<input type="password" name="b_pwd" id="b_pwd" class="form-control" maxlength="18">
								<label>수정할 비밀번호를 입력해 주세요.</label>
							</td>
						</tr>
						<tr>
							<td>이미지파일첨부</td>
							<td colspan="3" class="text-left">
								<input type="file" name="file" id="file"><!-- name이 file ** 중요! b_file - X -->
							</td>
						</tr>
					</tbody>
				</table>
			</form>	
		</div>	
		
		<div class="contentbtn text-right">
			<button type="button" class="btn btn-primary" id="boardUpdateBtn">수정</button>
			<button type="button" class="btn btn-primary" id="boardCancelBtn">취소</button>
			<button type="button" class="btn btn-primary" id="boardListBtn">목록</button>
		</div>
	</div>
</body>
</html>
