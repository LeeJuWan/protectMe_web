<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>나를지켜줘</title>
</head>
<body>
	<%
	//==========메인==========
		//세션이 유지되는지 검사
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
	%>
	<nav class="navbar navbar-default">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main.jsp">나를지켜줘</a>
		</div>
		<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="clinic.jsp">성범죄 상담소</a></li>
				<li><a href="population.jsp">성범죄 인구수</a></li>
				<li><a href="bbs.jsp">온라인 상담</a></li>
				<li><a href="question.jsp">자주묻는질문</a></li>
				<li><a href="check.jsp">자기점검코너</a></li>
				<li><a href="law.jsp">법률개정안내</a></li>	
				<%
				if("admin".equals(userID)) {
				%>
				<li><a href="admin.jsp">관리자페이지</a></li>	
				<%
					}
				%>							
			</ul>
			<%
				//세션이 없다면 -> 로그인, 회원가입 가능
				if(userID == null) {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>
			</ul>
			<%		
				//세션이 있다면 -> 로그아웃, 회원탈퇴 가능
				} else {
			%>
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li><a href="logoutAction.jsp">로그아웃</a></li>
						<li><a onclick="return confirm('정말로 탈퇴하시겠습니까?')" href="removeAction.jsp">회원탈퇴</a></li>
					</ul>
				</li>
			</ul>			
			<%
				}
			%>
		</div>
	</nav>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>나를지켜줘</h1>
				<p>성범죄 예방 서비스 <br />(배포 : b255fish)</p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>성희롱의 개념</h1>
				<p>성희롱이란 업무, 고용, 그 밖의 관계에서 지위를 이용하거나 업무 등과 관련하여
					<br />성적(性的) 언동(言動) 등으로 상대방에게 성적 굴욕감이나 혐오감을 느끼게 하거나, 
					<br />성적 언동 또는 그 밖의 요구 등에 따르지 아니하였다는 이유로 불이익을 주는 것을 말합니다. </p>
					<p id="substring"> (출처: 여성발전기본법 제3조 제4호, 국가인권위원회법 제2조 제3호, 남녀고용평등과 일·가정 양립 지원에 관한 법률 제2조 제2호)</p>
				<p><a class="btn btn-primary btn-pull" href="main_sub1.jsp" role="button">성적인 언동의 예시</a></p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>성폭력의 개념</h1>
				<p>상대방의 의사에 반(反)하여 가하는 모든 신체적, 언어적, 정신적 폭력을 포괄하는 광범위한 개념입니다.
					<br />법률에서 주로 강간, 강제추행 등의 의미 (폭행이나 협박을 수반한 성적 행위)하며,
					<br />최근에는 상대방의 의사를 무시한 채 행위를 한 경우 폭행이 없어도 강간, 강체추행으로 인정되기도 합니다.</p>
					<p id="substring"> (출처: 성폭력방지 및 피해자보호 등에 관한 법률 제2조, 성폭력범죄의 처벌 등에 관한 특례법 제2조, 형법 제297조, 제298조, 제299조, 제300조, 제301조, 제303조)</p>
				<p><a class="btn btn-primary btn-pull" href="main_sub2.jsp" role="button">성폭력에 대한 이해</a></p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>