<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그아웃 처리 후 로그인정보 입력페이지(hewon_login.jsp)로 이동하기 위한 URL 주소를 전달하는 JSP 문서 --%>    
<%
	//로그아웃 처리 - 세션에 저장된 권한 관련 정보 제거하거나 세션을 언바인딩 처리
	//session.removeAttribute("loginhewon");
	session.invalidate();
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=hewon_login';");
	out.println("</script>");
%>	