<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page trimDirectiveWhitespaces="true" %>
<!-- header시작 -->
<div class="container-fluid">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed"
			data-toggle="collapse" data-target="#navbar" aria-expanded="false"
			aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span> 
			<span class="icon-bar"></span>
		</button>
		<div class="inline navbar-brand text-center">My Project [관리자 페이지 - 
			<c:if test="${not empty adminLogin }">
				${adminLogin.a_name }<small>관리자님 반갑습니다.</small>
				<a href ="/admin/logout" class="btn btn-primary btn-sm active" role="button">로그아웃</a>
			</c:if>
			<c:if test="${empty adminLogin }">	
				<script type="text/javascript">
					location.href="/admin/login";
				</script>
			</c:if>
			]
		</div>
	</div>
	
	<!-- 추후 필요 시 주석 해제
	<div id="navbar" class="navbar-collapse collapse">
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#">Dashboard</a></li>
			<li><a href="#">Settings</a></li>
			<li><a href="#">Profile</a></li>
			<li><a href="#">Help</a></li>
		</ul>
		<form class="navbar-form navbar-right">
			<input type="text" class="form-control" placeholder="Search...">
		</form>
	</div> -->
</div>
<!-- header 끝 -->