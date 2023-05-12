<%@page import="xyz.itwill.dao.BasketDAO"%>
<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="xyz.itwill.dto.BasketDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	HewonDTO loginHewon  =(HewonDTO)session.getAttribute("loginHewon");

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
	BasketDAO.getDAO().insertBasket(basket);


	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=basket&jumun_list';");
	out.println("</script>");
%>