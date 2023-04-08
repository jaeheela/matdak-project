<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보를 전달받아 hewon 테이블에 저장된 회원정보를 변경하고 내정보 출력페이지(hewon_mypage.jsp)로
이동하기 위한 URL 주소 전달하는 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//전달값을 반환받아 저장
	String id=request.getParameter("id");
	String pw=request.getParameter("pw");
	if(pw==null || pw.equals("")) {//비밀번호 전달값이 없는 경우
		//로그인 사용자의 비밀번호를 변수에 저장 - 기존 비밀번호 유지
		pw=loginHewon.gethPw();
	} else {//비밀번호 전달값이 있는 경우
		//새로운 비밀번호를 암호화 처리하여 변수에 저장 - 비밀번호 변경
		pw=Utility.encrypt(pw);
	}
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone1")+"-"
		+request.getParameter("phone2")+"-"+request.getParameter("phone3");
	String postcode=request.getParameter("postcode");
	String addr1=request.getParameter("addr1");
	String addr2=request.getParameter("addr2");
	
	//hewonDTO 객체를 생성하여 전달값으로 필드값 변경
	HewonDTO hewon=new HewonDTO();
	hewon.sethId(id);
	hewon.sethPw(pw);
	hewon.sethName(name);
	hewon.sethEmail(email);
	hewon.sethPhone(phone);
	hewon.sethPostcode(postcode);
	hewon.sethAddr1(addr1);
	hewon.sethAddr2(addr2);
	//회원정보를 전달받아 hewon 테이블에 저장된 회원정보를 변경하는 DAO 클래스의 메소드 호출
	HewonDAO.getDAO().updateHewon(hewon);
	
	//세션에 저장된 권한 관련 정보(회원정보) 변경
	session.setAttribute("loginHewon", HewonDAO.getDAO().selectHewon(id));
	
	//클라이언트에게 URL 주소 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=mypage&work=mypage_hewon';");
	out.println("</script>");
%>