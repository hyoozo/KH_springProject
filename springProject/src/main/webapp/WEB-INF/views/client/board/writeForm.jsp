<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf"%>

<script type="text/javascript">
	$(function(){
		// 작성하기 버튼 눌렀을때,
		$("#boardInsertBtn").click(function(){
			// 유효성 검사하기,
			if(!chkData("#b_name", "작성자 이름을 ")) return;
			 else if(!chkData("#b_title", "제목을 "))return;
			 else if(!chkData("#b_content", "내용을 "))return;
			 else if(!chkData("#b_pwd", "비밀번호를 "))return;
			 //else if (!chkData("#file", "업로드할 이미지 파일을")) return;
			 else {
				 //consol.log("?????")
				 if($("#file").val() != "") { //업로드할 이미지 파일이 존재한다면
					 // 확장자가 png, jpg, gif외 파일을 업로드 할 수 없습니다. 또는 gif, png, jpg 파일만 업로 할 수 있습니다. 라고 유효성 체크
					 if(!chkFile($("#file"))) return;
				 }
				 
				// 유효성 검사 이상없을때 실행되는,
				$("#f_writeForm").attr({
					"method":"post",
					"enctype":"multipart/form-data", // enctype 속성의 기본값은  "application/x-www-form-urlcencoded". POST 방식 폼 전송에 기본 값으로 사용
					"action":"/board/boardInsert"
				});
				$("#f_writeForm").submit();
			}
		});
		
		// 취소하기 버튼 눌렀을때,
		$("#boardCancelBtn").click(function(){
			$("#f_writeForm").each(function () {
				this.reset();
			});
		});

		// 목록가기 버튼 눌렀을때,
		$("#boardListBtn").click(function(){
			history.back();
		});
		
	});
</script>
</head>
<body>
	<div class="contentContainer container">
		<div class="contentTB text-center">
			<form id="f_writeForm" name="f_writeForm" class="form-horizontal">
				<table class="table table-bordered">
					<colgroup>
						<col width="20%"/>
						<col width="80%"/>
					</colgroup>
					<tbody>
						<tr>
							<td>작성자</td>
							<td class="text-left">
								<input type="text" name="b_name" id="b_name" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td>글제목</td>
							<td class="text-left">
								<input type="text" name="b_title" id="b_title" class="form-control"/>
							</td>
						</tr>
						<tr>
							<td>글내용</td>
							<td class="text-left">
								<textarea rows="8" name="b_content" id="b_content" class="form-control"></textarea>	
							</td>
						</tr>
						<tr>
							<td>파일업로드</td>
							<td class="text-left">
								<input type="file" name="file" id="file"/>
							</td>
						</tr>
						<tr>
							<td>비밀번호</td>
							<td class="text-left"><input type="password" name="b_pwd" id="b_pwd" class="form-control"/></td>
						</tr>
						
					</tbody>
				</table>
			
				<div class="text-right">
					<button type="button" class="btn btn-success" id="boardInsertBtn">저장</button>
					<button type="button" class="btn btn-success" id="boardCancelBtn">취소</button>
					<button type="button" class="btn btn-success" id="boardListBtn">목록</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>
