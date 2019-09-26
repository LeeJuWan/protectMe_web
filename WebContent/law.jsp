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
	//==========법률개정안내==========
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
				<li><a href="main.jsp">성범죄 상담소</a></li>
				<li><a href="population.jsp">성범죄 인구수</a></li>
				<li><a href="bbs.jsp">온라인 상담</a></li>
				<li><a href="question.jsp">자주묻는질문</a></li>
				<li><a href="check.jsp">자기점검코너</a></li>
				<li class="active"><a href="law.jsp">법률개정안내</a></li>		
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
				<h1>법률개정안내</h1>
				<P>(출처 : 성폭력 관련 법률 개정 여성가족부, 법무부 공동 보도자료)</P>
				<br />
				<p>1. 1953년 9월 대한민국 형법 제정 이래 60여년 만에 성범죄에 대한 친고죄 조항을 전면 폐지하여, 앞으로 성범죄자의 경우 피해자의 고소 및 합의 여하를 불문하고 처벌되는 무관용 원칙이 적용된다. </p>
				<p id="substring">* 친고죄는 피해자의 고소가 있어야 처벌할 수 있는 범죄로서, 성범죄의 경우 피해자에 대한 무리한 합의 시도로 인한 2차 피해 등 부작용 발생 
					<br />* 이번 개정으로 피해자의 고소가 없거나 고소 후 피해자와 합의하더라도 가해자를 처벌할 수 있게 되어 성범죄에 대한 엄정한 대처가 가능해짐과 동시에 피해자의 2차 피해도 방지할 수 있게 됨 </p>
				<br />
				<p>2. 강간죄의 대상을 ‘부녀’에서 ‘사람’으로 개정하여 성인 남성에 대한 강간죄도 처벌할 수 있게 된다. 
				 	<br />※ 남자 아동·청소년은 이미 아동 청소년 성보호에 관한 법률상 강간죄로 처벌 </p>
				<p id="substring">* 성인 대상 성범죄의 객체가 ‘부녀’로만 한정되어 있어 ‘남성’에 대한 강간 등 성적 자기결정권 침해 행위에 대해서는 그에 상응하는 처벌 규정이 없었음 
					<br />* 이에 성인 대상 강간죄 등 성폭력범죄의 객체를 ‘부녀’에서 ‘사람’으로 확대함으로써 남성도 성폭력범죄의 피해자로 포함하여 보호 </p>
				<br />
				<p>3. 성적 욕망을 만족시킬 목적으로 공중화장실, 대중목욕탕 등에 침입하는 경우도 성폭력범죄로 처벌된다.</p>
				<p id="substring">* 자기의 성적 욕망을 만족시킬 목적으로 공중화장실, 공중목욕탕 등에 침입하거나 퇴거 요구에 응하지 아니하는 경우 ‘성적 목적을 위한 공공장소 침입행위’ 로 처벌하는 규정 신설 </p>
				<br />
				<p>4. 아동·청소년이 등장하는 음란물을 소지하는 경우에도 징역형으로 처벌 할 수 있게 된다. 
					<br />※ 단, 과도한 처벌이 될 수 있다는 지적에 따라 ‘아동·청소년이용음란물’의 개념과 ‘소지’의 개념을 명확히 규정</p>
				<p id="substring">* ‘아동·청소년이용 음란물’의 정의를 ‘아동·청소년 또는 아동·청소년으로 명백하게 인식될 수 있는 사람이나 표현물 등’으로 개정하고,
					<br />&nbsp;&nbsp;&nbsp;‘소지’의 개념을 ‘아동·청소년이용음란물임을 알면서 이를 소지한 자’로 개정함으로서 처벌범위를 보다 명확히 함
					<br />* ‘아동청소년이용음란물 소지죄’의 법정형에 징역형 추가 </p>
				<br />
				<p>5. 술을 마시고 성범죄를 범한 경우에도 형의 감경 없이 처벌할 수 있는 범죄의 범위가 확대된다.</p>
				<p id="substring">* 음주 또는 약물로 인한 형의 감경 규정을 대부분의 성폭력범죄에 대하여 배제할 수 있도록 하여, 주취 상태에서의 성폭력 범죄 엄벌</p>
				<br />
				<p>6. 공소시효가 적용되지 않는 범죄를 13세 미만 아동·청소년이나 장애인에 대한 강간·준강간 외 강제추행까지 확대하고, 강간살인죄의 경우 피해자의 연령 및 장애유무와 상관없이 공소시효가 적용되지 않아 성범죄자에 대한 책임을 끝까지 물을 수 있게 된다.</p>
				<br />
				<p>7. 성폭력 예방교육 의무기관에 국가기관, 지자체, 공공기관이 포함되고, 교육 결과 제출을 의무화하였으며, 교육프로그램 개발 및 전문강사 양성 등을 수행하는 ‘성폭력 예방교육 지원기관’이 운영된다</p>
				<p id="substring">* 기관장을 포함한 직원(비정규직 및 파견포함) + 어린이집 원생, 유치원 원생, 초·중·고·대학생(부모)이 모두 의무교육 대상자 → 교수, 직원, 학생, 모두 성폭력 예방교육의 법정 의무교육 대상</p>
				<p><a class="btn btn-primary btn-pull" href="http://www.law.go.kr/%EB%B2%95%EB%A0%B9/%EC%84%B1%ED%8F%AD%EB%A0%A5%EB%B2%94%EC%A3%84%EC%9D%98%EC%B2%98%EB%B2%8C%EB%93%B1%EC%97%90%EA%B4%80%ED%95%9C%ED%8A%B9%EB%A1%80%EB%B2%95" role="button">더 알아보기</a></p>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>