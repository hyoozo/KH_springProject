<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<style>
		#item-template{display: none;}
		.inline{display: inline-block;}
	</style>
	<script>
		let message = "작성시 입력한 비밀번호를 입력해 주세요.", btnKind="";

		$(function(){
			
			$("form[name='pwdForm']").hide();
			
			/** 기본 덧글 목록 불러오기 */
			let b_num = ${detail.b_num};
			listAll(b_num);
			
			/** 글입력을 위한 Ajax 연동 처리 */
			//$("#replyInsertBtn").click(funtion(){
			$(document).on("click", "#replyInsertBtn", function(){
				let insertUrl = "/replies/replyInsert";
				
				/* JSON.stringify(): JavaScript 값이나 객체를 JSON 문자열로 변환 */
				let value = JSON.stringify({
					b_num     : b_num,
					r_name    : $("#r_name").val(),
					r_pwd     : $("#r_pwd").val(),
					r_content : $("#r_content").val()
				});
				{}
				$.ajax({
					url        : insertUrl,
					type       : "post",
					headers    : {
						"Content-Type":"application/json"
					},
					dataType   : "text",
					data       : value,
					error      : function(xhr, textStatus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.stauts + "/" + errorThrown + ")");
						//alert("시스템에 문제가 있어 잠시 후 다시 진행해 주세요.");
					},
					beforeSend : function(){
						/* if(!checkForm("#r_name", "작성자를")) return false;
						else if(!checkForm("#r_pwd", "비밀번호를")) return false;
						else if(!checkForm("#r_content", "댓글내용을")) return false; */
						if(!chkData("#r_name", "작성자를")) return false;
						else if(!chkData("#r_pwd", "비밀번호를")) return false;
						else if(!chkData("#r_content", "댓글내용을")) return false;
					},
					success    : function(result){
						if(result == "SUCCESS"){
							alert("댓글 등록이 완료되었습니다.");
							dataReset();
							listAll(b_num);
						}
					}
				});
			});
			
			/** 수정 및 삭제 전 비밀번호 화면 출력을 위한 처리 */
			$(document).on("click", "button[data-btn]", function(){
				dataReset();
				$("form[name='pwdForm']").show();
				
				let $pwdView = $("#pwdForm").clone().removeAttr('id');
				$("form[name='pwdForm']").hide();
				
				let dataArea = $(this).parents("div.panel .panel-heading .panel-title");
				dataArea.append($pwdView);
				btnKind = $(this).attr("data-btn");
			});
			
			/* 비밀번호 체크 화면에서 "취소" 버튼 클릭 처리 */
			$(document).on("click", ".pwdResetBtn", function(){
				formHide();
			});
			
			
			/* 비밀번호 체크 화면에서 "확인" 버튼 클릭 처리 */
			$(document).on("click", ".pwdCheckBtn", function(){
				let panel  = $(this).parents("div.panel")
				let r_num  = panel.attr("data-num");
				let form   = $(this).parents(".inline");
				let pwd    = form.find(".passwd");
				let msg    = form.find(".msg");
				let value  = 0;
				
				if (!formCheck(pwd, msg, "비밀번호를")) return;
				else {
					$.ajax({
						url      : "/replies/pwdConfirm",
						type     : "POST",
						data     : "r_num="+r_num+"&r_pwd="+pwd.val(),
						dataType : "text",
						error    : function(){
							alert('시스템 오류 입니다. 관리자에게 문의하세요.');
						},
						success  : function(resultData){
							console.log("resultData : "+resultData);
							
							if(resultData == 0){				// 일치하지 않는 경우
								msg.addClass("msg_error");
								msg.text("비밀번호가 일치하지 않습니다.");
								pwd.select();
							}else if(resultData == 1){		// 일치할 경우
								if(btnKind=="upBtn"){
									console.log("수정 폼 출력");
									updateForm(r_num, panel);
									formHide();
								}else if (btnKind == "delBtn") {
									console.log("삭제 처리");
									deleteBtn(b_num, r_num);
								}
							
							btnKind = "";
							}
						}
					});
				}
			});
			
			/** 수정 폼 화면 구현 함수 */
			function updateForm(r_num, panel) {
				$("#replyForm .resetBtn").detach();
				
				$("#r_name").val(panel.find(".panel-title .name").html());
				$("#r_name").prop("readonly", true);
				
				let content = panel.find(".panel-body").html();
				content = content.replace(/(<br>|<br\/>|<br\/>)/g, '\r\n');
				$("#r_content").val(content);
				
				$("#replyForm button[type='button']").attr("id","replyUpdateBtn");
				$("#replyForm button[type='button']").attr("data-rnum", r_num);
				$("#replyForm button[type='button']").html("수정");
				
				let resetButton = $("<button type='button' class='btn btn-success resetBtn'>");
				resetButton.html("취소");
				$("#replyForm .sendBtn").after(resetButton);
			}
			
			/* 수정하기 클릭시 동적으로 생성된 "취소" 버튼 이벤트 처리 */
			$(document).on("click",".resetBtn", function(){
				dataReset();
			});
			
			/** 수정을 위한 Ajax 연동 처리 */
			$(document).on("click", "#replyUpdateBtn", function(){
				
			
				let r_num = $(this).attr("data-rnum");
				$.ajax({
					url      : '/replies/'+r_num,
					type     : 'put',
					headers  : {
						"Content-Type":"application/json",
						"X-HTTP-Method-Override":"PUT"
					},
					data     : JSON.stringify({
						r_content : $("#r_content").val(),
						r_pwd     : $("#r_pwd").val()
					}),
					dataType : 'text',
					error    : function(xhr, textStaus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.stauts + "/" + errorThrown + ")");
					},
					beforeSend : function(){
						if(!chkData("#r_content", "댓글내용을")) return false;
					},
					success  : function(result){
						console.log("result : " + result);
						if(result == "SUCCESS"){
							alert("댓글 수정이 완료되었습니다.");
							dataReset();
							listAll(b_num);
						}
					}
				});
			});
			
		});/* 최상위 $종료 */
		
		/** 댓글 목록 보여주는 함수  */
		function listAll(b_num){
			$(".reply").detach(); 	//detach() : 선택한 요소를 DOM 트리에서 삭제.
			
			let url = "/replies/all/" + b_num;
			
			$.getJSON(url, function(data){	//data = [{r_num:1, r_name:"홍길동",{}]
				$(data).each(function(){
					let r_num     = this.r_num;
					let r_name    = this.r_name;
					let r_content = this.r_content;
					let r_date    = this.r_date;
					r_content     = r_content.replace(/(\r\n|\r|\n)/g, "<br/>");
					template(r_num, r_name, r_content, r_date);
				});
			}).fail(function(){
				alert("덧글 목록을 불러오는데 실패하였습니다. 잠시후에 다시 시도해 주세요.");
			});
		}
			
		/** 새료운 글을 화면에 추가하기(보여주기) 위한 함수  */
		function template(r_num, r_name, r_content, r_date){
			let $div = $('#reviewList');
			
			let $element = $('#item-template').clone().removeAttr('id');
			$element.attr("data-num", r_num);
			$element.addClass("reply");
			$element.find('.panel-heading > .panel-title > .name').html(r_name);
			$element.find('.panel-heading > .panel-title > .date').html(" / " + r_date);
			$element.find('.panel-body').html(r_content);
			
			$div.append($element);
		}
		
		/** 입력 폼 초기화  */
		function dataReset() {
			$("#replyForm").each(function(){
				this.reset();
			})
			
			$("#r_name").prop("readonly", false);
			$("#replyForm button[type='button']").removeAttr("data-rnum");
			$("#replyForm button[type='button']").attr("id", "replyInsertBtn");
			$("#replyForm button[type='button'].sendBtn").html("저장");
			$("#replyForm button[type='button'].resetBtn").detach();
		}
		
		/* 비밀번호 화면 초기화 */
		function formHide(){
			$("form[name='pwdForm']").hide();
		}
		
		/** 글 삭제를 위한 Ajax 연동 처리  */
		function deleteBtn(b_num, r_num){
			if(confirm("선택하신 댓글을 삭제하시겠습니까?")){
				$.ajax({
					//url   : '/replies/' + b_num + '/' + r_num,
					url     : '/replies/' + r_num,
					type    : 'delete',   //method - get(조회) / post(입력) / put(수정) / delete(삭제) 존재
					headers : {
						"X-HTTP-Method-Override" : "DELETE"
					},
					dataType : 'text',
					error    : function(xhr, textStaus, errorThrown){
						alert(textStatus + " (HTTP-" + xhr.stauts + "/" + errorThrown + ")");
					},
					success  : function(result){
						console.log("result : " + result);
						if(result == "SUCCESS"){
							alert("댓글 삭제가 완료되었습니다.");
							listAll(b_num);
						}
					}
				});
			}else {
				formHide();
			}
		}
	</script>
	</head>
	<body>
		<div id="replyContainer">
		
			<!-- 댓글 리스트 화면  -->
			<form id="replyForm" name="replyForm">
				<div class="panel pacel-default">
					<table class="table">
						<tbody>
							<tr>
								<td class="col-md-1">작성자</td>	
								<td class="col-md-3 text-left">
									<input type="text" name="r_name" id="r_name" maxlength="5" class="form-control"/>
								</td>
								<td class="col-md-1">비밀   번호</td>	
								<td class="col-md-3 text-left">
									<input type="password" name="r_pwd" id="r_pwd" maxlength="18" class="form-control"/>
								</td>	
								<td class="col-md-4 btnArea">
									<button type="button" id="replyInsertBtn" class="btn btn-success gap sendBtn">저장</button>
								</td>		
							</tr>
							<tr>
								<td class="col-md-1">댓글내용</td>
								<td colspan="4" class="col-md-11 text-left">
									<textarea rows="3" name="r_content" id="r_content" class="form-control"></textarea>
								</td>	
							</tr>
						</tbody>
					</table>
				</div>
			</form>
			
			<!-- 비밀번호 확인 -->
			<form name="pwdForm" id="pwdForm" class="form-inline inline passwdArea">
				<div class="form-group">
					<label for="passwd">비밀번호 : </label>
					<input type="password" name="passwd" class="form-control passwd gap"/>
				</div>
				<button type="button" class="btn btn-default pwdCheckBtn gap">확인</button>
				<button type="button" class="btn btn-default pwdResetBtn gap">취소</button>
				<span class="msg"></span>
			</form>
			
			<!-- 리스트 영역 -->
			<div id="reviewList">
				<div id="item-template" class="panel panel-success">
					<div class="panel-heading">
						<h3 class="panel-title">
							<span class="name"></span>
							<span class="date"></span>
							<button type="button" data-btn="upBtn" class="btn btn-default gap">수정하기</button>
							<button type="button" data-btn="delBtn" class="btn btn-default gap">삭제하기</button>
						</h3>
					</div>
					<div class="panel-body"></div>
				</div>
			</div>
		</div>
	</body>
</html>