<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dto.BasketDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.BasketDAO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf"%>
<%@include file="/resources/css_basket_list.jspf"%>
<%
	//BASKET 테이블에 저장된 장바구니 목록을 검색하여 반환하는 DAO 클래스의 메소드 호출
	List<BasketDTO> basketList =  BasketDAO.getDAO().selectBasketList(loginHewon.gethId());
	List<ProductDTO> productList = new ArrayList<ProductDTO>();
	int totalSum = 0;
	int totalList=0;
	
	for (BasketDTO basket : basketList) {
	  int pNo = basket.getbPno();
	  ProductDTO product = ProductDAO.getDAO().selectProduct(pNo);
	  productList.add(product);
	  totalSum = product.getpPrice() * basket.getbNum();
	}
	
%>
<%--  => 주문하기 페이지 submit--%>
<form id="basketForm" class="basketTable" method="post" action="<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=jumun_list">  
	
	<div class="basket-titleArea titleArea">
		장바구니 <span>(<%=basketList.size()%>)</span>
	</div>
		
	<%--장바구니 본문 시작 --%>
	<div class="basket-List">
		<table>
			<tr>
				<th><input type="checkbox" id="allCheck" name="allcheck" checked = "checked"></th>
				<th colspan="6">상품정보</th>
				<th>상품금액</th>
			</tr>
		
		<%--장바구니 상품 list --%>
		<% if(basketList.isEmpty()) { %>
			<tr>		
				<td colspan="3"><br>장바구니에 담긴 물건이 없습니다.</td>
			</tr>	
		<%} else { %>
				<%for(BasketDTO basket: basketList) {%>
					<% ProductDTO product=ProductDAO.getDAO().selectProduct(basket.getbPno()); %>
					<tr>		
						<td class = "basketCheck"><input type="checkbox" name = "checkNo" value = "<%=basket.getbNo()%>" class = "check" checked="checked"></td>
						<td class="productImg" id ="productImg"><a href="#상품상세페이지"><img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="100"></a></td> 		
						<td><input type="button" id="name" class="name" name="name" value="<%=product.getpName()%>"></td> 
						<td><input type = "text" id="price" class="price" name="price" value="<%=product.getpPrice()%>" readonly="readonly">원</td> 		
						<td id = "quantity" class="quantity">
							<span class="count count-box"><input type="text" class="countInput"  id="count" name="<%=basket.getbNo() %>" value="<%=basket.getbNum() %>개" readonly="readonly" style="width: 20px; border: none;"></span>
						</td> 
						<td>무료</td> 		
						<td><input id="total" class="total" name="total" readonly="readonly" value= "<%=product.getpPrice() * basket.getbNum()%>">원</td>
					</tr>
					
				<% } %>
		<% } %>
		</table>
		
		<%-- 결제 예상금액 박스 --%>
		<div class="orderBox">
			<table>
				<tr>
					<td colspan="5">결제 예상금액</td>
					<td><input id="selectedTotal" readonly="readonly" value="">원
					</td>
				</tr>
			</table>
		</div>
		<br> 
		<%-- 선택 삭제 버튼 --%>
		<div class="removeBtn">
			<button type="button" id="removeSelectBtn" class="textAndBtn">선택 삭제</button>
			<div><span class="cartNotice">장바구니에 담긴 상품은 최대 15일까지 보관됩니다.</span></div>
			<%-- 선택된 체크박스 없을 경우 메세지 --%>
			<div id="message" style="color: red;"></div>
		</div>
		<%-- 하단에 주문하기 & 쇼핑 계속하기 버튼 --%>
		<div class = "basketBtn" style="text-align: center; padding-top: 20px;">
			<button type="button" id = "shopingGo" onclick= "location.href = '<%=request.getContextPath() %>/index.jsp?workgroup=main&work=main_page'" >쇼핑 계속하기</button>
			<button type="submit" id= "orderGo">주문하기</button>
		</div>		
	</div>
</form>
<script type="text/javascript">
//결제 예상금액 
$(document).ready(function(){
    var total = 0;
    $(".total").each(function() {
      	total += Number($(this).val());
    });
 
    $("#selectedTotal").val(total);
});

//체크박스 체크 해제시 
$(".check").change(function () {
	let total =0;
	let price = $("#total").val();
	let isAllChecked = true;
	
	if($(this).is(":checked")){ //체크박스 체크시 
		total+=price;
	$(".check").each(function (i,element) { //체크박스 전체 체크 여부 검사 
		if(!$(element).is(":checked")){ //체크 박스 중 하나가 체크되지 않을 경우 전체선택 버튼 미체크
			isAllChecked = false;
			return false;	
		}
	});
	
	if(isAllChecked){
		$("#allCheck").prop("checked",true);
	}
	}else { //체크박스 체크 해체시
		$("#allCheck").prop("checked", false);
	total-=price;
	}
});
	
//
$("#basketForm").submit(function() {
	var submitResult=true;
	
	if($(".check").filter(":checked").length==0){
		confirm("주문할 상품이 없습니다.");
		submitResult=false;
	}
	
	return submitResult;
});

//전체선택
$("#allCheck").change(function() {
	if($(this).is(":checked")){//allCheck라는 태그가 선택되었다면
		$(".check").prop("checked",true);	
		 var total = 0;
		    $(".total").each(function() {
		      	total += Number($(this).val());
		    })
		$("#selectedTotal").val(total);
	}else {
		$(".check").prop("checked",false); //전체 해제 버튼 선택시 
		$("#selectedTotal").val(0);
		$("#orderGo").click(function () {
			//여기 모르겠음 
		})
	}
});
      
//선택 삭제
$("#removeSelectBtn").click(function() {
	
	if($(".check").filter(":checked").length==0){ //체크박스중에 선택된 태그가 하나도없다면
   		$("#message").text("선택된 상품이 하나도 없습니다");
 	return;
	}
	if(!confirm("선택하신 상품을 삭제하시갰습니까?")){
		return;
	}
	//선택된 회원이 있는 경우 해당 form 을 basket_remove_action.jsp로 이동하여 처리 
	$("#basketForm").attr("action", "<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=basket_remove_action");
	$("#basketForm").attr("method", "post");
	$("#basketForm").submit();

});
</script>