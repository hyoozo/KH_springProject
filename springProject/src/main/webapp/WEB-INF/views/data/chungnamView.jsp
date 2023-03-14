<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/common.jspf" %>
		<script>
			$(function(){
			
			});
		</script>
	</head>
	<body>
		<h1>충남!</h1>
		<c:forEach var="sb" items="${output}" varStatus="status">
		
		<a>${sb.nm_sub } = </a>
		</c:forEach>
		<h1>충남!</h1>
	</body>
</html>
