<%@page import="com.matdak.dao.HewonDAO"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%-- 회원변경 처리 --%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	String hId=request.getParameter("hId");
	String hPw=request.getParameter("hPw");
	
	if(hPw==null || hPw.equals("")) hPw=loginHewon.gethPw();
	else hPw=Utility.encrypt(hPw);
	
	String hName=request.getParameter("hName");
	String hEmail=request.getParameter("hEmail");
	String hPhone=request.getParameter("phone1")+"-"+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	String hPostcode=request.getParameter("postcode");
	String hAddr=request.getParameter("addr1")+"%%%%%"+request.getParameter("addr2");
	
	Hewon hewon=new Hewon();
	hewon.sethId(hId);
	hewon.sethPw(hPw);
	hewon.sethName(hName);
	hewon.sethEmail(hEmail);
	hewon.sethPhone(hPhone);
	hewon.sethPostcode(hPostcode);
	hewon.sethAddr(hAddr);
	HewonDAO.getDAO().updateHewon(hewon);
	
	session.setAttribute("loginHewon", HewonDAO.getDAO().selectHewonByhId(hId));
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=mypage&work=mypage_hewon';");
	out.println("</script>");
%>