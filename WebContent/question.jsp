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
	//==========자주묻는질문==========
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
				<li class="active"><a href="question.jsp">자주묻는질문</a></li>
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
				<h1>자주묻는질문</h1>
				<br />
				<p>Q : 음담패설이나 농담으로 나를 제외한 모두가 웃고 즐겼다면 성희롱이 아닌가요?</p>
				<p id="questionstring">A : 나 혼자만 불쾌감을 느낀 경우에도 성희롱이 성립될 수 있습니다.</p>
				<br />
				<p>Q : 짧은 치마에 대해 지적하는 것은 성희롱인가요?</p>
				<p id="questionstring">A : 성희롱이 성립되지 않는 경우 - 관리자의 직무와 관련된 지시와 요구는 문제가 되지 않습니다.
					<br />성희롱이 성립되는 경우 - 외모나 복장의 지적 방식이 성적 불쾌감을 유발하는 경우 성희롱에 해당됩니다.</p>
				<br />
				<p>Q : 칭찬하는 의미에서 여성에게 “섹시하다”라고 말했다면 성희롱인가요?</p>
				<p  id="questionstring">A : 어떤 의도였는지의 여부보다 그 말이 때와 장소, 관계에 따라 다르게 받아들여진다는 점을 주의해야 합니다.</p>
				<br />
				<p>Q : 야한 농담을 해도 아무 소리 없이 듣고만 있다가 이후에 문제 제기해도 성희롱인가요?</p>
				<p id="questionstring">A :  야한 농담이 행해졌던 당시 정황상 상대의 의사를 존중하는 바탕에서 이루어진 것인지의 여부가 중요합니다. 
					<br />특히 행위자의 지위가 높고 피해자의 지위가 낮을수록 거부감을 표현하기 어렵다는 것을 주의해야 합니다.</p>
				<br />
				<p>Q : 남성들끼리만 야한 농담을 하고 있었는데, 이를 여성이 들었다면 성희롱인가요?</p>
				<p id="questionstring">A : 일회성이 아니라 일상적으로 성적 언행들이 반복된다면 문제가 될 수 있습니다.
					<br /> 이는 다른 여성들에게 지속적으로 불쾌감을 줄 수 있고 생활에 현저히 악영향을 미칠 수 있기 때문입니다.</p>
				<br />
				<p>Q : 과도한 노출이 있을 때 어쩔 수 없이 쳐다본 경우도 성희롱에 해당하나요?</p>
				<p id="questionstring">A : 쳐다본다는 자체만으로는 성희롱 문제는 아닙니다. 
					<br /> 다만, 특정 신체부위를 빤히 쳐다본다든지, 전신을 아래위로 훑어본다든지, 
					<br /> 당사자가 불쾌감을 표현했는데도 반복적으로 쳐다본다든지, ‘음흉한 눈빛’을 반복적이거나 
					<br /> 상대방의 외모에 대한 성적 평가를 하는 언행을 함께 사용하는 행위 등은 성희롱이 될 수 있습니다.</p>
				<br />
				<p>Q : 여자가 격려차 ‘동생 같다’며, 남자의 엉덩이를 친 것도 성희롱인가요?</p>
				<p id="questionstring">A : 일방적으로 행하는 성적 언동은 그 대상이 남녀를 불문합니다.
					<br /> 때로 남성에게 가벼운 장난이 아니라 모욕이 될 수도 있습니다.</p>
				<br />
				<p>Q : 설명을 위해 여성의 팔이나 어깨를 만진 행위도 성희롱이 될 수 있나요?</p>
				<p id="questionstring">A : 신체의 어느 부위에 접촉이든 상대방의 의사가 중요합니다 . 
					<br /> 즉 ‘상대방이 원하지 않는’ 행위였다면 성희롱이 될 수 있습니다.</p>
				<br />
				<p>Q : ‘아들 같다, 딸 같다’며, 어깨안마를 해달라고 하거나 흰머리를 뽑게 하는 것도 성희롱인가요?</p>
				<p id="questionstring">A : 문제의 행위들이 ‘친밀감의 표현’ 이었는지 여부는 행위자가 아니라 피해자의 시각에서 이루어집니다.    
					<br /> 따라서 상대가 ‘원하지 않는 행위’ 였고 불쾌감이 느꼈다면 성희롱이 성립됩니다.</p>
				<br />
				<p>Q : 성희롱을 하려고 한 의도 없이 이뤄진 행위도 성희롱이 될 수 있나요?</p>
				<p id="questionstring">A : 성희롱 여부의 판단은 피해자가 어떻게 느끼고 어떤 영향을 받았는가를 존중하여 이루어집니다.</p>
				<br />
				<p>Q : 피해자가 거부의사를 명확히 표현하지 않은 경우에도 성희롱이 성립될 수 있나요?</p>
				<p id="questionstring">A : 거부의사 표현이나 성희롱에 대한 문제제기를 했을 경우
					<br /> 불이익을 감수해야 하는 두려움 등으로 적극적으로 의사 표현하지 못하는 경우가 대다수입니다.
					<br /> 따라서 피해자의 거부의사 표현 여부는 전혀 판단의 기준이 되지 못합니다.</p>
				<br />
				<p>Q : 단 한 번의 행위로도 성희롱이 성립될 수 있나요?</p>
				<p id="questionstring">A : 단 한 번의 성적 언동이라도 피해자가 성적 굴욕감을 느꼈거나
					<br /> 성적 요구를 거부하였다는 이유로 불이익을 받았다면 성희롱이 성립됩니다.</p>
				
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>