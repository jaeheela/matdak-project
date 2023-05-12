<%@page import="xyz.itwill.dao.MoonDAO"%>
<%@page import="xyz.itwill.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- MOON 테이블에 게시물 50개 저장하는 JSP 문서 - 테스트 프로그램--%> 

<%
	MoonDTO moon = new MoonDTO();
	for(int i=1; i<=30; i++){
		int mCode=MoonDAO.getDAO().selectNextNum();	
		moon.setmCode(mCode);
		moon.setmId("zero01");
		moon.setmRef(mCode);
		moon.setmTitle("문의합니다!!!!!!"+i);
		moon.setmContent("문의사항 내용입니다!!!");
		moon.setmStatus(1); //일반글 
		MoonDAO.getDAO().insertMoon(moon);
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
</head>
<body>
	<h1>30개의 테스트 공지사항 게시글이 삽입 되었습니다.</h1>
</body>
</html>