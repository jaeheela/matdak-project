<%@page import="com.matdak.dto.HewonDTO"%>
<%@page import="com.matdak.dao.HewonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body><%
String id= request.getParameter("id");
	if(id == null||id.trim().equals("")){
		response.sendRedirect("product_detail.jsp");
		return;
	}
	HewonDTO hewon=HewonDAO.getDAO().selectHewon(id);
	//id를 통해 selectHewon 메소드실행
	//SQL문에서 Product table join
	//정보값 반환받음.
	
	//hewon정보값에 request.pno값을 저장한다.
	
	//id를 통해 selectHewon2 메소드실행 
	//SQL문에서 Product table join 후 pno가 존재할 시 모든 데이터 출력.
	//정보값 반환.
%>
</body>
</html>