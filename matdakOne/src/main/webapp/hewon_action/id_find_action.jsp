<%@page import="com.matdak.entity.Hewon"%>
<%@page import="com.matdak.dao.HewonDAO"%>
<%@page import="org.apache.catalina.connector.OutputBuffer"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원 아이디 및 비밀번호 찾기 처리 --%>    
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	String hEmail=request.getParameter("hEmail");
    String hName=request.getParameter("hName");
	Hewon hewon=HewonDAO.getDAO().selectHewonByhEmailhName(hEmail, hName);

	if(hewon==null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('회원정보가 맞지않습니다.')");
		out.println("location.href='"+request.getContextPath()+"/hewon/id_find.jsp';");
		out.println("</script>");		
		return;	
	}
%>
<body>
<h1>회원정보</h1>
<p>아이디 : <%=hewon.gethId() %></p>
</body>
</html>