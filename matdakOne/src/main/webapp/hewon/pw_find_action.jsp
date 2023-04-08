<%@page import="java.awt.Window"%>
<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
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
String id=request.getParameter("id");
String name=request.getParameter("name");

	HewonDTO hewon=AdminDAO.getDAO().selectHewonPw(email, id, name);
if(hewon==null) {
	out.println("<script type='text/javascript'>");
	out.println("alert('회원정보가 맞지않습니다.')");
	out.println("location.href='"+request.getContextPath()+"/hewon/pw_find.jsp';");
	out.println("</script>");
	return;	
}

String pw=Utility.newPassWordTwo();
String pw2=Utility.encrypt(pw);
hewon.sethPw(pw2);

HewonDAO.getDAO().updateHewon(hewon);
	
	
%>
	<h1>회원정보</h1>
	<p>임시 비밀번호 :<%=pw %></p>
</body>
</html>