<%@page import="com.matdak.dao.CartDAO"%>
<%@page import="com.matdak.dto.BasketDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 장바구니에 상품 추가하는 기능을 하는 페이지 --%>
<%-- 장바구니 데이터 베이스에 저장 (번호, 수량) => basket_list에서 DAO 호출  --%>

<%-- 비정상적인 요청에 대한 응답 처리 --%>
<%@include file="/security/login_check.jspf" %>

<%
//비정상적인 요청에 대한 처리 
	    if(request.getMethod().equals("GET")){
	    out.println("<script type='text/javascript'>");
	    out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
	    out.println("</script>");
	    return; 
  }

	   //전달값을 반환받아 저장 (상품 번호, 수량)
	   int bNum=Integer.parseInt(request.getParameter("result"));   //수량정보 product 테이블에 없음 
	   int bPno=Integer.parseInt(request.getParameter("pNo"));
	   //아이디 저장 
	   String id = loginHewon.gethId();
	   
	   //System.out.println("bNum ="+bNum);
	   //System.out.println("bPno ="+bPno);

	   
  
	   //BASKETDTO 객체를 생성하여 변수값으로 필드값 변경
		BasketDTO basket = new BasketDTO();
	    basket.setbId(id);
		basket.setbPno(bPno);
		basket.setbNum(bNum);
		
	
		//basket 객체를 전달받아 BOARD 테이블에 삽입하는 DAO 클래스의 메소드 호출
		CartDAO.getDAO().insertBasket(basket);
		
		
		
		//페이지 이동
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=basket&work=basket_list';");  // 장바구니 목록 페이지로 이동
		out.println("</script>");
%>

