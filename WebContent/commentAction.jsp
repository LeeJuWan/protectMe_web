<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="comm.CommDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="comm" class="comm.Comm" scope="page" />
<jsp:setProperty name="comm" property="commTitle" />
<jsp:setProperty name="comm" property="commContent" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나를지켜줘</title>
</head>
<body>
	<%
	//==========댓글작성동작==========
		String userID = null;
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
		//세션관련 오류 처리
		if(session.getAttribute("userID") != null) {
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = 'login.jsp'");
			script.println("</script>");			
		} else {
			//댓글관련 오류 처리
			if (comm.getCommTitle() == null || comm.getCommContent() == null) {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력이 안 된 사항이 있습니다.')");
				script.println("history.back()");
				script.println("</script>");			
			} else {
				CommDAO commDAO = new CommDAO();
				int result = commDAO.write(comm.getCommTitle() != null ? comm.getCommTitle() : null , userID, comm.getCommContent() != null ? comm.getCommContent() : null, bbsID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>");				
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'view.jsp?bbsID="+bbsID+"'");
					script.println("</script>");			
				}
			}
		}
	%>
</body>
</html>