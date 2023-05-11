<%@page import="com.matdak.dao.MoonDAO"%>
<%@page import="com.matdak.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>
<%
if(request.getParameter("mCode")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	int mCode = Integer.parseInt(request.getParameter("mCode"));
	
	MoonDTO moon = MoonDAO.getDAO().selectMoon(mCode);

	
	if(moon==null || moon.getmStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	if(!loginHewon.gethId().equals(moon.getmId()) && loginHewon.gethStatus()!=9){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	MoonDAO.getDAO().updatemStatus(mCode, 0);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=moon';");
	out.println("</script>");
%>