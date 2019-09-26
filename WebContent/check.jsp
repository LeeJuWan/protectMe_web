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
	//==========자기점검코너==========
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
				<li class="active"><a href="check.jsp">자기점검코너</a></li>
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
				<h1>자기점검코너</h1>				
				<br /><p>나의 성희롱,성폭력 인지력 테스트
				<br />(출처 : 한국대학성평등상담소협의회, 2013 추계워크샵 자료집)</p>
				<p id="checkstring">1. 성추행 사건이 발생했을 경우, 노출이 심한 옷을 입은 상대방도 책임이 있다고 생각한다.</p>
					<select id='select1' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />
				<p id="checkstring">2. 나의 제안에 상대방이 침묵했다는 것은 나의 제의를 받아들인다는 의미라고 생각한다.</p>
					<select id='select2' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />			
				<p id="checkstring">3. 나는 스킨십이나 성적인 접촉을 하기 전에 상대방에게 동의를 구하는 것이 찌질하다고 생각한다.<br /></p>
					<select id='select3' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />				
				<p id="checkstring">4. 나의 성적 제의에 상대방이 ‘싫다’라고 말할 때, 속으론 좋으면서 튕귄다고 생각한다.</p>
					<select id='select4' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />				
				<p id="checkstring">5. 혼자 있는 내 자취방에 상대방이 흔쾌히 들어왔다는 것은 성적 관계를 허락한 것이므로 성적 행동에 합의가 된 것이라고 생각한다.</p>
					<select id='select5' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />			
				<p id="checkstring">6. 친밀한 사이에서는 동의를 구하지 않아도 가벼운 스킨십은 가능하다고 생각한다.</p>
					<select id='select6' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />
				<p id="checkstring">7. 둘이서 함께 찍은 가벼운 스킨십 사진은 상대방의 동의없이도 내 블로그에 올려도 된다고 생각한다.</p>
					<select id='select7' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />
				<p id="checkstring">8. 나는 동영상의 야한장면을 실천에 옮기고 싶다는 환상을 갖고 있다.</p>
					<select id='select8' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />
				<p id="checkstring">9. 상대방의 외모나 몸매에 대해 친구들과 말하는 것은 나의 자유다.</p>
					<select id='select9' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />									
				<p id="checkstring">10. 성적 농담으로 화기애애해지면 우리 중에 몇몇 불편한 사람이 있어도 팀워크면에서는 괜찮다고 생각한다.</p>
					<select id='select10' onChange="setValues1();">
						<option value="" selected="selected">점수</option>
						<option value="1">그렇다</option>
						<option value="0">아니다</option>
					</select><br /><br />												
				<p><button class="btn btn-primary btn-pull" onclick="getValues1();">결과확인</button></p>
				<script>
				//위 질문들을 처리하기 위한 과정
					var xx1 = 0;
				//설문조사 선택사항 데이터 수집 -> 합계
				    function setValues1(){
				    	var x1 = document.getElementById("select1").value;
				    	var x2 = document.getElementById("select2").value;
				    	var x3 = document.getElementById("select3").value;
				    	var x4 = document.getElementById("select4").value;
				    	var x5 = document.getElementById("select5").value;
				    	var x6 = document.getElementById("select6").value;
				    	var x7 = document.getElementById("select7").value;
				    	var x8 = document.getElementById("select8").value;
				    	var x9 = document.getElementById("select9").value;
				    	var x10 = document.getElementById("select10").value;
				    	xx1 = Number(x1)+Number(x2)+Number(x3)+Number(x4)+Number(x5)+Number(x6)+Number(x7)+Number(x8)+Number(x9)+Number(x10);				    	
				    }
				//설문조사 결과 출력
				    function getValues1(){
				    	if (xx1<1) {
				    		alert("당신은 충분한 성교육을 받고 있습니다.");
				    	} else if (xx1>=1 && xx1<4){
				    		alert("2% 아쉽습니다. 조금 더 노력하세요.");				    		
				    	} else if (xx1>=4 && xx1<7){
				    		alert("의식개선이 필요합니다.");				    		
				    	} else if (xx1>=7){
				    		alert("주기적인 성교육이 필요합니다.");				    		
				    	}
				    }
				</script>
				
				<br /><br /><br /><p>성적 의사결정능력
				<br />(출처: 한국여성민우회 가족과 성 상담소)</p>
				<p id="checkstring">1. 좋아하다가 싫어지는 감정이 생길 수 있다는 걸 인정하고 받아들일 수 있다.</p>
					<select id='select11' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />				
				<p id="checkstring">2. 나는 성적 욕망이나 지식에 대해 상대에게 이야기할 수 있다.</p>
					<select id='select12' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">3. 상대에게 화났을 때, 고마울 때 등의 감정을 표현할 수 있다.</p>
					<select id='select13' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />									
				<p id="checkstring">4. 상대가 어떻게 반응할지 걱정되더라도 감정을 감추거나 왜곡하지 않는다.</p>
					<select id='select14' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">5. 상대의 일방적인 요구에 대해 ‘부당함’을 이야기 할 수 있다.</p>	
					<select id='select15' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />																					
				<p id="checkstring">6. 나는 원하지만 상대가 싫다고 하면 여러 번 반복해서 강요하지 않고 상대의 의사를 존중한다.</p>
					<select id='select16' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />				
				<p id="checkstring">7. 나는 여전히 좋아하는데, 상대는 좋아하지 않는다며 헤어지려할 때, 억지로 붙잡지 않는다.</p>
					<select id='select17' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />			
				<p id="checkstring">8. 나는 나의 성적인 욕망에 대해 그대로 인정한다.</p>
					<select id='select18' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">9. 나는 나에게 맞는 피임법에 대해 알고 있다.</p>
					<select id='select19' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />								
				<p id="checkstring">10. 성적 욕망이 생기면 함께 나눌 상대가 없어도 나름대로 해소할 수 있는 방법을 알고 있다.</p>
					<select id='select20' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />				
				<p id="checkstring">11. 성관계 의사 없이도 상대와 여행을 함께 할 수 있다.</p>
					<select id='select21' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />			
				<p id="checkstring">12. 내 감정과 느낌이 소중한 만큼 상대의 상태를 충분히 고려하고 배려할 수 있다.</p>
					<select id='select22' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">13. 상대의 감정을 통제하기 위해 내 감정을 과장하거나 왜곡되게 표현하지 않는다.</p>
					<select id='select23' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />	
				<p id="checkstring">14. 합의된 신체적인 접촉(예, 키스)을 하는 중에 내 맘대로 다른 행동을 저지르는 행위는 하지 않는다.</p>
					<select id='select24' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />																			
				<p id="checkstring">15. 상대의 신체적 접촉에 대한 제안을 내가 원하지 않을 경우엔 거절할 수 있다.</p>
					<select id='select25' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">16. 연애하고 싶은 사람이 생길 때, 상대에게 제안해 볼 수 있다.</p>
					<select id='select26' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">17. 나는 사람을 사귈 때 ‘이 사람은 내꺼다’라는 생각을 우선하지 않는다.</p>
					<select id='select27' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />
				<p id="checkstring">18. 내가 고백했을 때, 상대가 나에 대해 관심이 없다고 말해도 자존심이 상하긴 하지만 받아들일 수 있다.</p>
					<select id='select28' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />														
				<p id="checkstring">19. 상대가 취해서 정신이 없을 때를 기회로 내가 평소에 원했던 접촉을 시도하는 일은 하지 않는다.</p>
					<select id='select29' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />					
				<p id="checkstring">20. 성적으로 끌리는 대상이 있으면, 그 사람이 생각하고 판단할 수 있는 상황에서 성관계를 제안할 수 있다.</p>
					<select id='select30' onChange="setValues2();">
						<option value="" selected="selected">점수</option>
						<option value="1">전혀 그렇지 않다</option>
						<option value="2">다소 그렇지 않다</option>
						<option value="3">중간</option>
						<option value="4">다소 그렇다</option>
						<option value="5">매우 그렇다</option>
					</select><br /><br />		
				<p><button class="btn btn-primary btn-pull" onclick="getValues2();">결과확인</button></p>
				
				<script>
				//위 질문들을 처리하기 위한 과정
					var xx2 = 0;
				//설문조사 선택사항 데이터 수집 -> 합계
				    function setValues2(){
				    	var x1 = document.getElementById("select11").value;
				    	var x2 = document.getElementById("select12").value;
				    	var x3 = document.getElementById("select13").value;
				    	var x4 = document.getElementById("select14").value;
				    	var x5 = document.getElementById("select15").value;
				    	var x6 = document.getElementById("select16").value;
				    	var x7 = document.getElementById("select17").value;
				    	var x8 = document.getElementById("select18").value;
				    	var x9 = document.getElementById("select19").value;
				    	var x10 = document.getElementById("select20").value;
				    	var x11 = document.getElementById("select21").value;
				    	var x12 = document.getElementById("select22").value;
				    	var x13 = document.getElementById("select23").value;
				    	var x14 = document.getElementById("select24").value;
				    	var x15 = document.getElementById("select25").value;
				    	var x16 = document.getElementById("select26").value;
				    	var x17 = document.getElementById("select27").value;
				    	var x18 = document.getElementById("select28").value;
				    	var x19 = document.getElementById("select29").value;
				    	var x20 = document.getElementById("select30").value;
				    	xx2 = Number(x1)+Number(x2)+Number(x3)+Number(x4)+Number(x5)+Number(x6)+Number(x7)+Number(x8)+Number(x9)+Number(x10)+Number(x11)+Number(x12)+Number(x13)+Number(x14)+Number(x15)+Number(x16)+Number(x17)+Number(x18)+Number(x19)+Number(x20);				    	
				    }
				//설문조사 결과 출력
				    function getValues2(){
				    	if (xx2<=80) {
				    		alert("자신의 감정과 욕구에 대해 잘 알지 못하고 주장하지 못하고 있습니다. 지금과 같은 상태라면 성적인 가해자나 피해자가 될 가능성이 있어요. 노력하세요.");
				    	} else if (xx2>80 && xx2<=92) {
				    		alert("노력하지만, 상황에 따라 변화가 있네요. 자신의 감정과 욕구를 잘 파악하고 상대를 배려하는 감수성이 더 필요합니다.");	
				    	} else if (xx2>92) {
				    		alert("자신의 감정이나 욕구에 대해 잘 알고 있으며, 상대의 감정과 욕구를 이해하려고 노력하는군요.");
				    	}	
				    }
				</script>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>