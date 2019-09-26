<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.util.regex.Pattern" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<jsp:setProperty name="user" property="userNum" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나를지켜줘</title>
</head>
<body>
	<%
	//==========회원가입동작==========
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
		if (user.getUserID() == null || user.getUserPassword() == null || user.getUserName() == null || user.getUserGender() == null || user.getUserEmail() == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");			
		}
		else {
			//패스워드 관련 정규화 선언
			Pattern pwPattern = Pattern.compile("^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$");
			Matcher matcher1 = pwPattern.matcher(user.getUserPassword());
			
			//이메일 관련 정규화 선언
			Pattern emailPattern = Pattern.compile("^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$");
			Matcher matcher2 = emailPattern.matcher(user.getUserEmail());
			
			//패스워드 관련 정규화 체크
			if (matcher1.matches() == false) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('8~20자 영문+숫자+특수문자를 사용하세요.')");
				script.println("history.back()");
				script.println("</script>");	
			}
			//이메일 관련 정규화 체크
			else if (matcher2.matches() == false) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('잘못된 이메일 형식입니다.')");
				script.println("history.back()");
				script.println("</script>");	
			}			
			else {
			//회원가입관련 오류 처리
				UserDAO userDAO = new UserDAO();
				int result = userDAO.join(user);
				
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('이미 존재하는 아이디입니다.')");
					script.println("history.back()");
					script.println("</script>");				
				}
	
				else {
					session.setAttribute("userID",user.getUserID());
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'main.jsp'");
					script.println("</script>");			
				}
			}
		}
	%>
</body>
</html>