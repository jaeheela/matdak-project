<%@page import="com.matdak.dao.HewonDAO"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%-- 회원삭제 처리 --%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	String hPw=Utility.encrypt(request.getParameter("hPw"));
	
	if(!hPw.equals(loginHewon.gethPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=password_confirm&action=remove';");
		out.println("</script>");
		return;
	}

	HewonDAO.getDAO().updatehStatus(loginHewon.gethId(), 0);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon_action&work=hewon_logout_action';");
	out.println("</script>");
%>   