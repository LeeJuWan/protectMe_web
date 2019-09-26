<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="bbs.BbsDAO" %>
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
	//==========게시판동작==========
		//게시글 조회 거부 스크립트문
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('관리자와 작성자만 확인할 수 있습니다.')");
		script.println("location.href = 'bbs.jsp'");
		script.println("</script>");
	%>
</body>
</html>