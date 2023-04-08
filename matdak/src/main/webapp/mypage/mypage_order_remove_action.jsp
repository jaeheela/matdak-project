<%@page import="xyz.itwill.dto.JumunDTO"%>
<%@page import="xyz.itwill.dao.JumunDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자와 비밀번호가 같은 경우 000 테이블에 저장된 주문을 삭제하고 마이페이지(mypage_main.jsp)로 이동 --%>
<%@include file="/security/login_check.jspf"%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//500 에러
	String passwd=Utility.encrypt(request.getParameter("hPw"));
	
	if(!passwd.equals(loginHewon.gethPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=mypage&work=mypage_password_confirm&action=remove';");
		out.println("</script>");
		return;
	}
	
	String jid = loginHewon.gethId();
	JumunDTO jumun = JumunDAO.getDAO().selectJumun(jid);
	int jno = jumun.getjNo();
	
	//아이디와 주문상태를 전달받아 JUMUN 테이블에 저장된 해당 아이디의 주문내역에서 
	//회원주문내역을 삭제하거나 주문상태를 변경하는 DAO 클래스의 메소드 호출
	JumunDAO.getDAO().updatejStatus(jno, 1);

	
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=shop&work=mypage_main';");
	out.println("</script>");
%>
