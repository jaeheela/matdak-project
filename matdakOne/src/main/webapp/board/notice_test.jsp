<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- NOTICE 테이블에 게시물 30개 저장하는 JSP 문서 - 테스트 프로그램--%> 

<%
	NoticeDTO notice = new NoticeDTO();
	for(int i=1; i<=30; i++){
		int nCode=NoticeDAO.getDAO().selectNextNum();	
		notice.setnCode(nCode);
		notice.setnId("zero00");
		notice.setnTitle("아주 아주 중요한 공지사항 제목입니다."+i);
		notice.setnContent("공지사항 콘텐츠입니다! 이곳에는 공지사항이 세부 내용이 작성됩니다.");
		notice.setnStatus(1); //일반글 
		notice.setnImage(i+".jpg");
		NoticeDAO.getDAO().insertNotice(notice);
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