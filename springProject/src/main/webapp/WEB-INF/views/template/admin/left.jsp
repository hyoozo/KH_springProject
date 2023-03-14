<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="uri" value='${requestScope["javax.servlet.forward.request_uri"]}'/>

<!-- left 시작 -->
<ul class="nav nav-sidebar">
	<li class="active">
		<a href="#">관리자 메뉴
			 <span class="sr-only">(current)</span>
		</a>
	</li>
	<li
		<c:if test="${fn:containsIgnoreCase(uri, '/admin/board')}">
			class="active"
		</c:if>
	   >
		<a href="/admin/board/boardList">게시판 관리</a>
	</li>
	<li
		<c:if test="${fn:containsIgnoreCase(uri, '/admin/member')}">
			class="active"
		</c:if>
	   >
		<a href="/admin/member/memberList">회원 관리</a>
	</li>
</ul>
<ul class="nav nav-sidebar">
	<li><a href="">Nav item</a></li>
	<li><a href="">Nav item again</a></li>
	<li><a href="">One more nav</a></li>
	<li><a href="">Another nav item</a></li>
	<li><a href="">More navigation</a></li>
</ul>
<ul class="nav nav-sidebar">
	<li><a href="">Nav item again</a></li>
	<li><a href="">One more nav</a></li>
	<li><a href="">Another nav item</a></li>
</ul>
<!-- left 종료 -->