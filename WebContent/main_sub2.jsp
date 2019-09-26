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
	//==========성폭력의개념==========
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
				<h1>성폭력에 대한 이해</h1>
				<p><br />성폭력은 상대방의 ‘성적 자기결정권’을 침해하는 행위입니다. 
					<br />현대 사회를 살아가는 개인들에게는 저마다 자신이 선호하는 성적인 삶의 방향을
					<br />스스로 선택하고 친밀한 관계 맺기의 상대, 시기, 방식 등을 자율적으로 결정할 수 있는 권리가 있는데
					<br />이를 ‘성적 자기결정권’ 또는 ‘성적 자율권’이라고 부르며
					<br />이 권리는 헌법이 보장하는 인격권과 행복추구권의 연장선에 놓여 있는 기본적인 권리입니다.
					<br />상대방이 원하지 않는 성적인 말이나 행동으로 고통을 주는 것은 성적 자율권을 침해하는 폭력에 해당됩니다.
					<br />
					<br />성폭력 가해자와 피해자의 관계를 살펴볼 때, 신체적 능력, 혹은 사회적, 경제적 위치 등에서 우위에 있는 사람이  
					<br />가해자인 경우가 많기 때문에 가해자보다 약자인 피해자가 저항하는 것은 결코 쉬운 일이 아닙니다.
					<br />
					<br />직접적인 신체 접촉이 없는 행위일지라도 상대방으로 하여금 성폭력에 대한 막연한 불안감이나 
					<br />공포감을 조성할 뿐만 아니라 그것으로 인한 행동제약을 유발시키는 것도 간접적인 성폭력이 될 수 있습니다.</p>
					<p id="substring">ex) 특정 성에게 모욕감을 주는 성적인 농담을 반복하는 것, 외설적인 글이나 그림을 이메일로 보내는 것, 집요하게 전화를 걸거나 따라다니면서 괴롭히는 스토킹 등</p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>