<%@page import="org.apache.catalina.connector.OutputBuffer"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
<% 	
	String email=request.getParameter("email");
    String name=request.getParameter("name");
	HewonDTO hewon=AdminDAO.getDAO().selectHewonId(email, name);

	if(hewon==null) {
		out.println("<script type='text/javascript'>");
		out.println("alert('회원정보가 맞지않습니다.')");
		out.println("location.href='"+request.getContextPath()+"/hewon/id_find.jsp';");
		out.println("</script>");
		
		return;	
	}
	
	String id=hewon.gethId();

%>
	<h1>회원정보</h1>
	<p>아이디 : <%=id %></p>
	
</body>
</html>