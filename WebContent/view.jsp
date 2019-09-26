<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="comm.Comm" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="java.util.ArrayList" %>

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
	//==========게시물조회==========
		//세션관련 오류 처리
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		//게시판 페이지가 1인지 검사
		int pageNumber = 1;
		if (request.getParameter("pageNumber") != null) {
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		//게시판관련 오류 처리
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbs.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs = new BbsDAO().getBbs(bbsID);
		
		if (!(bbs.getUserID().equals(userID))) {								
			if(bbs.getUserID().equals("admin") || "admin".equals(userID)) {		
				
			}
			else{
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('관리자와 작성자만 확인할 수 있습니다.')");
				script.println("location.href = 'bbs.jsp'");
				script.println("</script>");
			}
		}
		else{
			
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
		<div class="row">
			<table class="table table-striped">
				<thead>
					<tr>
						<th colspan="3">게시글</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="width: 20%;">글제목</td>
						<td colspan="2"><%= bbs.getBbsTitle() != null ? bbs.getBbsTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") : null %></td>
					</tr>
					<tr>
						<td>작성자</td>
						<td colspan="2"><%= bbs.getUserID() %></td>
					</tr>
					<tr>
						<td>작성일자</td>
						<td colspan="2"><%= bbs.getBbsDate().substring(0,11) + bbs.getBbsDate().substring(11,13)+ ":" + bbs.getBbsDate().substring(14,16) %></td>						
					</tr>
					<tr>
						<td>내용</td>
						<td colspan="2" style="min-height: 200px; text-align: left"><%= bbs.getBbsContent() != null ? bbs.getBbsContent().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") : null %></td>
					</tr>					
				</tbody>
			</table>
				
			<table class="table table-striped">
				<thead>
					<tr>
						<!-- <th>번호</th> -->
						<th>작성자</th>
						<th>댓글</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<%
					//조회중인 게시물에서 댓글 리스트 출력
						CommDAO commDAO = new CommDAO();
						ArrayList<Comm> list = commDAO.getList(pageNumber);
						for(int i = 0; i < list.size(); i++) {
							if(bbsID == list.get(i).getBbsID()) {
					%>
					<tr>
						<!-- <td><%= list.get(i).getCommID() %></td> -->
						<td><%= list.get(i).getUserID() %></td>
						<td>
							<a href="comm_view.jsp?bbsID=<%=bbs.getBbsID() %>&commID=<%= list.get(i).getCommID() %>" style="color: white"><%= list.get(i).getCommTitle().replaceAll(" ","&nbsp;").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\n","<br>") %></a>
						</td>						
						<td><%= list.get(i).getCommDate().substring(0,11) + list.get(i).getCommDate().substring(11,13)+ ":" + list.get(i).getCommDate().substring(14,16) %></td>
					</tr>
					<%
							}
						}
					%>
				</tbody>
			</table>
			<%
				//조회중인 게시물에서 댓글 페이지 처리
				if(pageNumber != 1) {
			%>
				<a href="view.jsp?bbsID=<%= bbs.getBbsID() %>&pageNumber=<%= pageNumber - 1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				} if(commDAO.nextPage(pageNumber + 1)) {
			%>
				<a href="view.jsp?bbsID=<%= bbs.getBbsID() %>&pageNumber=<%= pageNumber + 1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>			
			
			<a href="bbs.jsp" class="btn btn-primary">글목록</a>
			<%
				//세션 == 게시물작성자 -> 게시글 수정,삭제 가능
				if(userID != null && userID.equals(bbs.getUserID())) {
			%>
					<a href="update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>
					<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">삭제</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<a href="comment.jsp?bbsID=<%=bbs.getBbsID() %>" class="btn btn-primary pull-right" style="margin-right: 4px">댓글쓰기</a>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="js/bootstrap.js"></script>
</body>
</html>