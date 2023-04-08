<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 MEMBER 테이블에 저장된
회원정보의 회원상태를 변경하여 탈퇴 처리하고 로그아웃 처리페이지(member_logout_action.jsp)로 
이동하는 URL 주소를 전달하는 JSP 문서 --%>
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
	String pw=Utility.encrypt(request.getParameter("pw"));
	
	//전달된 비밀번호가 로그인 사용자의 비밀번호와 같지 않은 경우 비밀번호 입력페이지
	//(password_confirm.jsp)로 이동
	if(!pw.equals(loginHewon.gethPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=password_confirm&action=remove';");
		out.println("</script>");
		return;
	}
	
	//아이디와 회원상태를 전달받아 MEMBER 태이블에 저장된 해당 아이디의 회원정보에서 회원상태를
	//변경하는 DAO 클래스의 메소드 호출 - 탈퇴회원으로 변경 처리
	HewonDAO.getDAO().updateStatus(loginHewon.gethId(), 0);
	
	//클라이언트에게 URL 주소 전달
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=hewon_logout_action';");
	out.println("</script>");
%>   