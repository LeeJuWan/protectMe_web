<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userCnt" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나를지켜줘</title>
</head>
<body>
	<%
	//==========로그인동작==========
		//세션관련 오류 처리	
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID != null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");			
		}
		//로그인관련 오류 처리
		UserDAO userDAO = new UserDAO();
		
		int result = userDAO.login(user.getUserID(), user.getUserPassword());
		
		int count = userDAO.getCount(user.getUserID());
		
		if(count >= 5){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호를 5회 이상 틀려 중지된 계정입니다.')");
			//current time을 변수로 받아서
			script.println("history.back()");
			script.println("</script>");	
		}
		else {
			if (result == 1) {
				session.setAttribute("userID",user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
			else if (result == 0) {
				count = count+1;
				userDAO.count(user.getUserID());
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('비밀번호를 " + count + "회 틀렸습니다.')");
				script.println("history.back()");
				script.println("</script>");		
			}
			else if (result == -1) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('존재하지 않는 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
			else if (result == -2) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('데이터베이스 오류가 발생했습니다.')");
				script.println("history.back()");
				script.println("</script>");
			}
		}
	%>
</body>
</html>