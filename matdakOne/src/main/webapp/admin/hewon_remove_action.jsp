<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>   
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	String[] checkId=request.getParameterValues("checkId");
	
	for(String id:checkId) {
		HewonDAO.getDAO().updateStatus(id, 0);
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=hewon_manager';");
	out.println("</script>");
%>