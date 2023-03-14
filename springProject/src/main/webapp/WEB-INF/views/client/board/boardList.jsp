<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
	<script>
		$(function(){
			
			/*검색 후 검색 대상과 검색 단어 출력 */
			let word = "<c:out value='${boardVO.keyword}' />";
			let value= "";
			
			if(word != "") {
				$('#keyword').val("<c:out value='${boardVO.keyword}' />");
				$('#search').val("<c:out value='${boardVO.search}' />");
				
				if($('#search').val() != 'b_content') {
					
					// :contains()는 특정 텍스트를 포함한 요소 반환
					if($('#search').val() == 'b_title') value = "list tr td.goDetail";
					else if ($('#search').val() == 'b_name') value = "#list tr td.name";
					console.log($(value + ":contains('" + word + "')").html());
					$(value + ":contains('" + word + "')").each(function(){
						let regex = new RegExp(word, 'gi');
						$(this).html($(this).html().replace(regex,"<span class='required'>" + word + "</span>"));
					});
				
				}
			}
			
			/* 입력 양식 enter 제거 */
			$('#keyword').bind("keydown", function (event) {
				if(event.keyCode == 13){
					event.preventDefault();
				}
			});
			
			/* 검색 대상이 변경될 때마다 처리 이벤트 */
			$("#search").change(function() {
				if( $("#search").val() == "all" ) {
					$("#keyword").val("전체 데이터 조회합니다.");
				} else if( $("#search").val() != "all" ){
					$("#keyword").val("");
					$("#keyword").focus();
				}
			
			});
			
			/* 검색 버튼 클릭시 처리 이벤트 */
			$("#searchData").click(function() {
				if($("#search").val() != "all") { // 제목, 내용, 작성자 선택시 검색어 유효성 체크 
					if(!chkData("#keyword", "검색어를")) return;
				}
				/* $("#pageNum").val(1); */
				goPage();
			});
			
			/* 글쓰기 버튼 클릭 시 처리 이벤트 */
			$("#insertFormBtn").click(function () {
				location.href="/board/writeForm";
			});
			
			/* 제목 클릭시 상세 페이지 이동을 위한 처리 이벤트 */
			$(".goDetail").click(function() {
				let b_num = $(this).parents("tr").attr("data-num");
				$("#b_num").val(b_num);
				/* consol.log("글번호 : " + b_num); */
					
				//상세 페이지로 이동하기 위해 form 추가 (id : detailForm)
				$("#detailForm").attr({
					"method":"get",
					"action":"/board/boardDetail"
				});
				$("#detailForm").submit();
			});
		
			$(".paginate_button a").click(function(e) {
				e.preventDefault();
				$("#f_search").find("input[name='pageNum']").val($(this).attr("href"));
				goPage();
			});
		});
		
		/* 검색을 위한 실질적인 처리 함수 */
		function goPage() {
			if($("#search").val() == "all"){
				$("#keyword").val("");
			}
			$("#f_search").attr({
				"method":"get",
				"action":"/board/boardList"
			});
			$("#f_search").submit();
		}
	</script>
	</head>
	<body>
		<div class="contentContainer container">
			<!-- <div class="contentTit page-header"> <h1 class="text-center">게시판 리스트</h1> </div> -->
			
			<%-- ======================= 검색기능 시작 ======================= --%>
			<div id="boardSearch" class="text-right">
				<form id="f_search" name="f_search" class="form-inline">
					<input type="hidden" name="pageNum" value="${pageMaker.cvo.pageNum}">
					<input type="hidden" name="amount" value="${pageMaker.cvo.amount}">
				
					<div class="form-group">
						<label>검색조건</label>
						<select id="search" name="search" class="form-control"> 
							<option value="all">전체</option>
							<option value="b_title">제목</option> 
							<option value="b_content">내용</option>
							<option value="b_name">작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" value="검색어를 입력하세요." class="form-control"/>
						<button type="button" id="searchData" class="btn btn-success">검색</button>
				 	</div>
				</form>
			</div>
			<%-- ======================= 검색기능 종료 ======================= --%>
			
			<form id="detailForm" style="width: ">
				<input type="hidden" id="b_num" name="b_num"/>
			</form>
			
			<%-- ======================= 리스트 시작 ======================= --%>
			<div id="boardList" class="table-height">
				<table class="table table-striped" summary="게시판 리스트">
					<thead>
						<tr>
							<th data-value="b_num" class="order text-center col-md-1">글번호</th>
							<th class="text-center col-md-4">글제목</th>
							<th class="text-center col-md-2">작성자</th>
							<th data-value="b_date" class="order col-md-1">작성일</th>
							<th class="text-center col-md-1">조회수</th>
							<th class="text-center col-md-3">이미지</th>
						</tr>
					</thead>
					<tbody class="table-striped" id="list">
						<!-- 데이터 출력 -->
						<c:choose>
							<c:when test="${not empty boardList}">
								<c:forEach var="board" items="${boardList}" varStatus="status">
									<tr class="text-center" data-num="${board.b_num }">
										<td>${board.b_num }</td>
										<td class="goDetail text-center">
											${board.b_title }
											<c:if test="${board.r_cnt > 0}">
												<span class="reply_count">[${board.r_cnt}]</span>
											</c:if>
										</td>
										<td class="name">${board.b_name }</td>
										<td class="text-left">${board.b_date }</td>
										<td class="text-center">${board.readcnt}</td>
										<td>
											<c:if test="${not empty board.b_thumb }">
												<img style="width: 100px; height: 100px;" src="/uploadStorage/board/${board.b_file}"/>
												<%-- <img style="width: 100px; height: 100px;" src="/uploadStorage/board/thumbnail/${board.b_thumb}"/> --%>
											</c:if>
											<c:if test="${empty board.b_thumb }">
												<img style="width: 100px; height: 100px;" src="/resources/images/common/istockphoto.jpg"/>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
								<tr>
									<td colspan="6" class="tac text-center">등록된 게시글이 존재하지 않습니다.</td>
								</tr>
							</c:otherwise>
						</c:choose>
					</tbody>
				</table>
			</div>
			<%-- ======================= 리스트 종료 ======================= --%>
			<%-- ============== 페이징 출력 시작 =========== --%>
			<div class="text-center">
				<ul class="pagination">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous">
							<a href="${pageMaker.startPage -1}">Previous</a>
						</li> 
					</c:if>
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button ${pageMaker.cvo.pageNum == num ? 'active':''}"> 
						<a href="${num}">${num}</a>
						</li>
					</c:forEach>
					<c:if test="${pageMaker.next}">
					<li class="paginate_button next">
						<a href="${pageMaker.endPage +1 }">Next</a> 
					</li>
					</c:if> 
				</ul>
			</div>
			<%-- ============== 페이징 출력 종료 ============= --%>
			
			<%-- ======================= 글쓰기 버튼 출력 시작 ======================= --%>
			<div class="contentBtn text-right">
				<input type="button" value="글쓰기" id="insertFormBtn" class="btn btn-success">
			</div>
			<%-- ======================= 글쓰기 버튼 출력 종료 ======================= --%>
			
		</div>
	</body>
</html>
