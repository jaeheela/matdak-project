<%@page import="com.matdak.dao.JumunDAO"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.matdak.dto.JumunDTO"%>
<%@page import="java.util.Date"%>
<%@page import="com.matdak.dao.CartDAO"%>
<%@page import="com.matdak.dto.BasketDTO"%>
<%@page import="com.matdak.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- 주문 페이지에 정보를 전달하는 jsp --%>
<%-- 주문 데이터 베이스에 저장 => jumunDAO 의 insertjumun 메소드 호출 --%>
    
<%--로그인 사용자와 관리자만 사용 가능 --%>
<%@include file="/security/login_check.jspf"%>

<%
//비정상적인 요청 
	if(request.getMethod().equals("GET")){
	   out.println("<script type='text/javascript'>");
	   out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
	   out.println("</script>");
	   return;		
  }

	
	
	//아이디 저장 
	String id = loginHewon.gethId();
	
	
	//장바구니 정보 저장 
	List<BasketDTO> basketList =  CartDAO.getDAO().selectBasketList(loginHewon.gethId());
	List<Product> productList = new ArrayList<Product>();
	List<Integer>qtyList = new ArrayList<Integer>();
	int totalSum = 0;

	

	//form 데이터에서 전달값을 반환받아 저장
	//상품명, 주문번호
	String jJname = request.getParameter("name");  //이름 
	String jPhone = request.getParameter("phone"); //핸드폰 번호
	String jPostcode = request.getParameter("zipcode"); //우편번호
	String jOaddr1 = request.getParameter("address1");  //기본주소
	String jOaddr2 = request.getParameter("address2");  //상세주소
	String jOmesg = request.getParameter("memo");        //베송메세지
	String jOpay = request.getParameter("paymethod");   //결제수단
	int jNum= Integer.parseInt(request.getParameter("countInput"));  //수량  
	int jTp = Integer.parseInt(request.getParameter("selectedTotal"));  //결제금액                 
	//int jBno = Integer.parseInt(request.getParameter("jBno")); 
	int jStatus =0;
	
	//System.out.println(jOmesg);
	
	//jumunDTO 객체를 생성하여 전달값으로 필드값 변경 
	for(BasketDTO basket:basketList){
		 int pNo = basket.getbPno();
		 Product product = ProductDAO.getDAO().selectProduct(pNo);
		 productList.add(product);
		 qtyList.add(basket.getbNum());
		  totalSum = product.getpPrice() * basket.getbNum();
	
	// 식별자, 날짜 제외 
	JumunDTO jumun = new JumunDTO();
	jumun.setjPno(product.getpNo());
	jumun.setjId(basket.getbId());
	jumun.setjNum(basket.getbNum());
	jumun.setjTp(totalSum);
	jumun.setjStatus(jStatus);
	jumun.setjJname(jJname);
	jumun.setjPhone(jPhone);
	jumun.setjPostcode(jPostcode);
	jumun.setjOaddr1(jOaddr1);
	jumun.setjOaddr2(jOaddr2);
	jumun.setjOmesg(jOmesg);
	jumun.setjOpay(jOpay);
	//jumun.setjBno(jBno);
	
	
	//주문정보를 전달받아 JUMUN 테이블에 삽입하는 DAO 클래스의 메소드 호출 
	JumunDAO.getDAO().insertJumun(jumun);
	}
	
	//장바구니에 담긴 물건 모두 삭제
	//BasketDAO.getDAO().deleteBasket(jBno);

	
	//클라이언트에게 URL 주소 전달 
	out.println("<script type='text/javascript'>");
	out.println("location.href='" + request.getContextPath() + "/index.jsp?workgroup=basket&work=jumun_clear'");
	out.println("</script>");
%>


