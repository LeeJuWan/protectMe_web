<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>나를지켜줘</title>
<style type="text/css">
	a, a:hover {
		color: #000000;
		text-decoration: none;
	}
</style>
</head>
<body>
	<%
	//==========게시판조회==========
		//세션이 유지되는지 검사
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		//게시판 페이지가 1인지 검사
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
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
				<li class="active"><a href="bbs.jsp">온라인 상담</a></li>
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
				<h1>온라인 상담</h1>
				<p>성범죄는 남의 일이 아닌 우리 모두의 일입니다.<br />당신의 용기가 세상을 바꿉니다.</p>
			</div>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table class="table table-striped">
				<thead>
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
						//게시판 DB 객체 생성
						BbsDAO bbsDAO = new BbsDAO();
						//게시물이 쌓이면 페이지 처리하는 부분
						ArrayList<Bbs> list = bbsDAO.getList(pageNumber);
						//페이지 처리된 리스트를 읽어오는 부분
						for(int i = 0; i < list.size(); i++) {
							if (!(list.get(i).getUserID().equals(userID))) {								//작성자 != 세션
								if(list.get(i).getUserID().equals("admin") || "admin".equals(userID)) {		//그중에 관리자라면 다 볼수있음
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td>					
							<a href="view.jsp?bbsID=<%=list.get(i).getBbsID() %>" style="color: white"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a>																						
						</td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+ ":" + list.get(i).getBbsDate().substring(14,16) %></td>
					</tr>
							<% } else { //관리자가 아니라면 아무것도 못봄 %>										
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td>					
							<a href="bbsAction.jsp" style="color: white"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a>
						</td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+ ":" + list.get(i).getBbsDate().substring(14,16) %></td>
					</tr>
					<%
							   }
							} else { //작성자 == 세션 --> 자신이 작성한 게시글만 볼 수 있음
					%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td>					
							<a href="view.jsp?bbsID=<%= list.get(i).getBbsID() %>" style="color: white"><%= list.get(i).getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a>																						
						</td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11) + list.get(i).getBbsDate().substring(11,13)+ ":" + list.get(i).getBbsDate().substring(14,16) %></td>
					</tr>					
					<%									
							}
						}
					%>
				</tbody>
			</table>

			<%
				//페이지가 2페이지 이상일 경우 처리
				if(pageNumber != 1) {
			%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(bbsDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="bbs.jsp?pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>