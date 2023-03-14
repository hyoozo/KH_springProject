<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page trimDirectiveWhitespaces="true" %>

<c:set var="clientUri" value='${requestScope["javax.servlet.forward.request_uri"]}'/>
<div class="container">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
			<span class="sr-only">Toggle navigation</span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
			<span class="icon-bar"></span>
		</button>
		<a class="navbar-brand" href="/">My Project</a>
	</div>
	<div id="navbar" class="collapse navbar-collapse">
	
		<ul class="nav navbar-nav">
			<li><a href="/">Home</a></li>
			<li <c:if test="${fn:containsIgnoreCase(clientUri, '/board')}"> class="active"</c:if>>
				<a href="/board/boardList">게시판</a>
			</li>
			
			<li class="dropdown <c:if test="${fn:containsIgnoreCase(clientUri, '/data')}">active</c:if>">
        		<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"> 공공데이터
          			<span class="caret"></span>
          		</a>
          		
				<ul class="dropdown-menu" role="menu">
					<li><a href="/data/chungnamView">충남 관광 명소</a></li>
	  				<li><a href="/data/animalDaejeonView">대전 유기동물 공고</a></li>
				  	<!-- <li><a href="#">Something else here</a></li>
						<li class="divider"></li>
						<li class="dropdown-header">Nav header</li>
						<li><a href="#">Separated link</a></li>
						<li><a href="#">One more separated link</a></li> -->
				</ul>
			</li>
		</ul>
		
	</div>
    <!--/.nav-collapse -->
</div>