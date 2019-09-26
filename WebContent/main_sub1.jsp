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
	//==========성희롱의개념==========
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
				<h1>육체적 행위</h1>
				<p>* 입맞춤, 포옹 또는 뒤에서 껴안는 등의 신체적 접촉행위
					<br />* 가슴·엉덩이 등 특정 신체부위를 만지는 행위
					<br />* 안마나 애무를 강요하는 행위</p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>언어적 행위</h1>
				<p>* 음란한 농담을 하거나 음탕하고 상스러운 이야기를 하는 행위
					<br /> &nbsp;&nbsp;(전화통화, 통신매체, 인터넷 매체(카톡, 블로그 등) 포함)
					<br />* 외모에 대한 성적인 비유나 평가를 하는 행위
					<br />* 성적인 사실 관계를 묻거나 성적인 내용의 정보를 의도적으로 퍼뜨리는 행위
					<br />* 성적인 관계를 강요하거나 회유하는 행위
					<br />* 회식자리 등에서 무리하게 옆에 앉혀 술을 따르도록 강요하는 행위</p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="jumbotron">
			<div class="container">
				<h1>시각적 행위</h1>
				<p>* 음란한 사진·그림·낙서·출판물 등을 게시하거나 보여주는 행위
					<br /> &nbsp;&nbsp;(컴퓨터통신이나 팩시밀리 등을 이용하는 경우 포함)
					<br />* 성과 관련된 자신의 특정 신체부위를 고의적으로 노출하거나 만지는 행위</p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>