<%@page import="com.matdak.dao.CartDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- Basket 테이블에 저장된 해당 제품번호의 정보를 삭제하고 basket_list.jsp 로 이동하는 URL주소를 
클라이언트에게 전달하는 JSP 문서--%>
<%-- 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/login_check.jspf"%>

<%
//비정상적인 요청에 대한 응답 처리 
  if(request.getMethod().equals("GET")){
    out.println("<script type='text/javascript'>");
    out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
    out.println("</script>");
    return; 
  }

  //체크박스로 선택되어 전달된 모든 제품 번호를 반환 받아 저장 (name이 같아서 구분 안됨)
  String[] checkNo=request.getParameterValues("checkNo");

	
  //삭제 처리 - DAO 클래스 메소드 호출 
  for(String cbno : checkNo){
	  int bNo = Integer.parseInt(cbno);
    CartDAO.getDAO().deleteBasket(bNo);
  }

  //페이지 이동 
  out.println("<script type='text/javascript'>");
  out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=basket&work=basket_list';");
  out.println("</script>");
%>