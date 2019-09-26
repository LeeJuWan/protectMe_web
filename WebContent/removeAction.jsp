<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.UserDAO" %>
<%@ page import="user.User" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="comm.Comm" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:useBean id="bbs" class="bbs.Bbs" scope="page" />
<jsp:setProperty name="bbs" property="userID" />
<jsp:useBean id="comm" class="comm.Comm" scope="page" />
<jsp:setProperty name="comm" property="userID" />


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나를지켜줘</title>
</head>
<body>
	<%
	//==========회원탈퇴동작==========
		//세션이 유지되는지 검사
		String userID = null;
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		
		//회원탈퇴시 모든 정보(회원,게시물,댓글) 삭제하기 위한 선언
		UserDAO userDAO = new UserDAO();
		BbsDAO bbsDAO = new BbsDAO();
		CommDAO commDAO = new CommDAO();
		
		//회원탈퇴시 모든 정보(회원,게시물,댓글) 삭제
		int result = userDAO.remove(userID);
		int result_bbs = bbsDAO.remove_bbs(userID);
		int result_comment = commDAO.remove_comment(userID);
		
		//회원탈퇴관련 오류 처리
		if (result == -1 || result_bbs == -1 || result_comment == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('회원탈퇴에 실패했습니다.')");
			script.println("history.back()");
			script.println("</script>");				
		}
		else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'main.jsp'");
			script.println("</script>");			
		}	
	
		session.invalidate();
	%>
</body>
</html>