<%@page import="xyz.itwill.dao.MoonDAO"%>
<%@page import="xyz.itwill.dto.MoonDTO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf"%>
<%

	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}

	//전달값을 반환받아 저장
	int mCode=Integer.parseInt(request.getParameter("mCode"));
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	String mTitle = Utility.escapeTag(request.getParameter("mTitle"));	
	String mContent = Utility.escapeTag(request.getParameter("mContent"));	
	int mStatus = 1;
	if(request.getParameter("mStatus")!=null){
		mStatus = Integer.parseInt(request.getParameter("mStatus"));
	}
	

	//객체에 삽입 처리
	MoonDTO moon = new MoonDTO();
	moon.setmCode(mCode);
	moon.setmTitle(mTitle);
	moon.setmContent(mContent);
	moon.setmStatus(mStatus);
	
	//테이블에 삽입
	MoonDAO.getDAO().updateMoon(moon);

	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=moon_detail"
		+"&mCode="+mCode+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
	out.println("</script>");
%>