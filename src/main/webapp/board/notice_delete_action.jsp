<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 관리자인 경우 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%

	if(request.getParameter("nCode")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	int nCode = Integer.parseInt(request.getParameter("nCode"));

	NoticeDTO notice = NoticeDAO.getDAO().selectNotice(nCode);
	
	if(notice==null || notice.getnStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	
	if(!loginHewon.gethId().equals(notice.getnId()) && loginHewon.gethStatus()!=9){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	NoticeDAO.getDAO().updatenStatus(nCode, 0);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=notice';");
	out.println("</script>");
	
%>	