<%@page import="java.text.DecimalFormat"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="com.matdak.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 상품코드를 전달받아 PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%
//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("pNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';"); 
		out.println("</script>");
		return;
	}
	
	//전달값을 반환받아 저장
	int pNo=Integer.parseInt(request.getParameter("pNo"));
	
	String pageNum=request.getParameter("pageNum");
	String search=request.getParameter("search");
	String keyword=request.getParameter("keyword");
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
	Product product=ProductDAO.getDAO().selectProduct(pNo);
	
	//검색된 상품정보가 없는 경우 - 비정상적인 요청
	if(product==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';"); 
		out.println("</script>");
		return;
	}
%>

<link rel="stylesheet" type="text/css" href="shop/product_detail.css">
<style type="text/css">
</style>

<div id="item_wrap">
	<div class="item_content_box">
		<div>
			<table>
				<tr>
	                <!-- 상품이미지 -->
					<td class="itemImg_area">
						<div><img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="420" height="420"></div>
	                </td>
	                <td class="itemInfo_td">
						<div>
							<div class="itemInfo_td_div_area">
								<div class="orderItem_title"><%=product.getpName() %></div>
								<div class="orderItem_prc">
									<span class="sell_prc">
										<%=DecimalFormat.getInstance().format(product.getpPrice()) %>
										<span class="price_unit">원</span>
									</span>
								</div>
	
								<div class="info">
									<dl>
										<dt>원산지</dt>
										<dd>
											<span class="origin">대한민국</span>
										</dd>
									</dl>
									<dl>
										<dt>배송방법</dt>
										<dd>
											<span class="delivery">3,000원 (20,000원이상 무료배송)</span>
										</dd>
									</dl>
								</div>
	
								<form name="cartForm" id="cartForm" method="post" action="index.jsp?workgroup=basket&work=basket_add_action">
									<input type="hidden" name="pNo" value="<%=product.getpNo()%>"></input>
			 						<div class="qnty-box" style="padding: 90px 0px 0px 0px;">
					 					<div class="qnty-box-result">
					 						<div class="item_select_num" style="display: flex;">
												<button type="button" id="sub" style="border: 0;">
													<img src="shop/item_min.png" alt="빼기" width="30px">
												</button>
												<span class="item_num">
													<input id="result" name="result" value="1" style="width: 40px; height: 30px; font-size: 14px; color: #222; border: 0; text-align: center;" ></input>
				 									<input type="hidden" id="priceResult" name="priceResult" value="<%=product.getpPrice() %>" readonly>
												</span>
												<button type="button" id="add" style="border: 0;">
													<img src="shop/item_plus.png" alt="더하기" width="30px">
												</button>				
				 							</div>
				 							<div class="qnty-box-price"><span style="font-size: 16px; padding: 0 20px 0 0;">총 상품금액</span>
												<input id="totalPrice" name="totalPrice" style="border: none; font-family: 'Tahoma', sans-serif; font-size: 32px; font-weight: bold; width: 225px; text-align: right;" readonly>
												<span class="won" style="font-size: 22px; font-weight: 500; padding-left: 45px;">원</span></input>
											</div>
			 							</div>
			 						</div>
			 						<div class="itemOption_btn" style="padding-top: 40px;">
			 							<span class="itemOption_cart_btn_area">
		 									<button type="submit" class="btn" id="cartBtn" >장바구니</button>
		 								</span>
		 								<span class="itemOption_order_btn_area">
		 									<button type="submit" class="btn_black" id="payBtn">바로구매</button>
										</span>
									</div>
								</form>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td colspan="2" style="padding-top: 80px;"></td>
				</tr>
				<tr style="border-top: 1px solid #ededed; ">
					<td colspan="2">
						<ul class="itemMenu_tap_area" style="float: center; width: 25%; padding: 0px 0px 0px 370px; margin: 40px 0 40px 0;">
							<li class="iteminfo_menu" style="color: #fff; background: #555; border: 1px solid #555; border-right: 0; width: 100%; height: 54px; line-height: 53px; font-size: 15px; text-align: center;">상품정보</li>
						</ul>
						<div id="itemContent_wrap">
							<div id="item_info" class="tabcnt_detail0" style="display: block;">
								<div id="sit_inf_explan">
									<div style="margin: 0px auto; width: 100%; text-align: center;">
										<!-- 상품상세정보 -->
										<img src="<%=request.getContextPath()%>/product_image/<%=product.getpInfo()%>" width="600" height="420"> 
									</div>
								</div>
							</div>
						</div>
					</td>
				</tr>
			</table>
		</div>	
	</div>
</div>

<form method="post" id="menuForm">
	<input type="hidden" name="pNo" value="<%=product.getpNo()%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
</form>

<%--  비로그인 사용자 -> 제품 구매 클릭 -> 로그인 -> 로그인 하면 그 전과 동일한 페이지로 이동 --%>
<form>
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
</form>

<script type="text/javascript">
var qnty=1;
var price=$("#priceResult").val();
$("#totalPrice").val(qnty*price);

$("#result").val(qnty);

$("#add").click(function() {
	qnty++;
	$("#result").val(qnty);
	$("#totalPrice").val(qnty*price);
});

$("#sub").click(function() {
	qnty--;
	if(qnty<1){ // 최소 수량1로 고정
		qnty=1;
    } else{
		$("#result").val(qnty);
		$("#totalPrice").val(qnty*price);
    }
});


</script>

<jsp:include page="/board/review.jsp" />