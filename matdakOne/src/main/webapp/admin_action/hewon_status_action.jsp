<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>   
<%
	if(request.getParameter("id")==null || request.getParameter("status")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	String id=request.getParameter("id");
	int status=Integer.parseInt(request.getParameter("status"));
	
	HewonDAO.getDAO().updateStatus(id, status);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=hewon_manager';");
	out.println("</script>");
%>