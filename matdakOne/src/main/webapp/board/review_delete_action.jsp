<%@page import="com.matdak.dao.ReviewDAO"%>
<%@page import="com.matdak.dto.ReviewDTO"%>
<%@page import="com.matdak.dao.NoticeDAO"%>
<%@page import="com.matdak.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 글번호를 전달받아 REVIEW 테이블의 게시글에서 해당 글번호의 게시글에 대한 STATUS 
컬럼값을 [0]으로 변경하여 삭제 처리하고 게시글목록 출력페이지(review.jsp)로 이동하는
URL 주소를 클라이언트에게 전달하는 JSP 문서 - 값 전달 없음 --%>
<%-- => 로그인 사용자 중 게시글 작성자이거나 관리자인 경우에만 요청 가능한 JSP 문서 --%>
<%-- 비로그인 사용자가 JSP 문서를 요청한 경우 에러페이지로 이동하여 응답 처리 --%>
<%@include file="/security/login_check.jspf" %>

<%
if(request.getParameter("rCode")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	int rCode = Integer.parseInt(request.getParameter("rCode"));

	ReviewDTO review = ReviewDAO.getDAO().selectReview(rCode);
	//System.out.println(review);

	//비정상적인 요청 시 에러페이지로 이동
	if(review==null || review.getrStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	if(!loginHewon.gethId().equals(review.getrId()) && loginHewon.gethStatus()!=9){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	review.setrStatus(0); //0:삭제글 1:일반글 2:비밀글
	/*
	if(review.getrStatus()==1){
		System.out.println("그대로");
	} else if(review.getrStatus()==0){
		System.out.println("0 변경완료");
	} else {
		System.out.println("문제있음");
	}*/
	ReviewDAO.getDAO().updateReview(review);

	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review';");
	out.println("</script>");
%>	