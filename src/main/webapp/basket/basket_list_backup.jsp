<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dto.BasketDTO"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.BasketDAO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--장바구니  목록 페이지 : 회원id와 상품pNo을 참조해 장바구니에 담은 상품 정보를 가져와 보여주는 JSP문서 --%>
<%-- [쇼핑계속하기] 클릭시 메인페이지로 이동  --%>
<%-- [주문하기]클릭시 권한에 따라 다른 페이지로 이동 
            - 비로그인 회원에게는 로그인/회원가입 페이지로 이동 
            - 로그인 회원에게는 주문 결제 페이지로 이동 (선택한 상품을 주문하시겠습니까? 라는 메세지 알림창 - 확인누르면 jumun_list 로 이동
            취소를 누르면 현재 페이지에 머무르기 ) --%>

<%--로그인 사용자와 관리자만 사용 가능 --%>
<%@include file="/security/login_url.jspf"%>
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
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<style type="text/css">
.titleArea h1 {
	margin: 0 0 30px;
	text-align: center;
}

.removeBtn {
	text-align: center;
}

.removeBtn .textAndBtn {
	margin-right: 631px;
}

.removeBtn #removeAllBtn {
	background-color: rgb(207, 207, 207);
	cursor: pointer;
	color: rgb(13, 13, 13);
	width: 125px;
	height: 35px;
	padding: 6px 12px;
}

.removeBtn #removeAllBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}

.basket_btn {
	margin: 0 auto;
	width: 400px;
	height: 50px;
	font-size: 1.2em;
	cursor: pointer;
	padding: 12px 0;
	text-align: center;
	margin-top: 10px;
}

.basket_btn .submitAllBtn {
	font-weight: bold;
	color: rgb(13, 13, 13);
	background-color: rgb(171, 195, 159);
	padding: 11px 27px 11px;
	border: none;
}

.basket_btn .submitAllBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}

table {
	margin: 5px auto;
	border: 0.5px solid rgb(207, 207, 207);
	border-collapse: collapse;
	width: 900px;
}

th {
	height: 40px;
	border: 0.5px solid rgb(207, 207, 207);
	text-align: center;
}

td {
	height: 40px;
	border: 0.5px solid rgb(207, 207, 207);
	text-align: center;
}

.price .count {
	display: inline-block;
	position: relative;
	vertical-align: top;
}

.count #down .downBtn {
	position: static
}

.cartTable table {
	font-size: 13px;
}

.cartTable table input {
	text-align: center;
}

.name {
	cursor: pointer;
}

.name:hover {
	border-bottom: 1px solid rgb(207, 207, 207)
}

.name, .price, .total {
	border: none;
	font-size: 15px;
}

.name, .price, .total:focus {
	outline: none;
}

.removeBtn #removeSelectBtn {
	background-color: rgb(207, 207, 207);
	cursor: pointer;
	color: rgb(13, 13, 13);
	padding: 6px 12px;
}

.removeBtn #removeSelectBtn:hover {
	background-color: rgb(13, 13, 13);
	border: 1px solid rgb(207, 207, 207);
	color: rgb(207, 207, 207);
}



.empty {
	text-align: center;
}

/* cart만 고정 */
body {
	width: 100;
	margin: 0 auto;
	height: 800px;
}

#width {
	width: 1000px;
	margin: 0 auto;
	text-align: left;
}

#selectedTotal {
	font-size: 15px;
	border: none;
	padding-left: 4px;
	line-height: 20px;
	cursor: text;
}
.titleArea {
    color: #333;
    font-size: 32px;
    font-weight: 500;
    padding: 0 0 40px;
}
.titleArea span {
    color: #f22;
    font-size: 28px;
    font-weight: bold;
}
.basket_List{
    overflow: hidden;
    height: 40px;
    line-height: 40px;
    border-top: 1px solid #333;
    text-align: center;
}
.basket_List > table {
    width: 100%;
    border-collapse: collapse;
}
.textAndBtn {
    color: #f22;
    border: 1px solid #f22;
    padding: 5px 7px;
}
#total {
    color: #f22;
    text-align: center;
    border-right: 1px solid #eee;
}
#shopingGo {
    color: #B11116;
    width: 220px;
    display: inline-block;
    text-align: center;
    padding: 10px 0;
    font-size: 18px;
    cursor: pointer;
    border: 1px solid #B11116;
}
#orderGo {
    background-color: #B11116;
    color: #fff;
    width: 220px;
    display: inline-block;
    text-align: center;
    padding: 10px 0;
    font-size: 18px;
    cursor: pointer;
}
.cartNotice{
	font-size: 15px;
}
.basket {
    width: 500px;
    margin: 0 auto;
    padding-top: 60px;
}




</style>


<%--  => 주문하기 페이지 submit--%>
<form id="basketForm" class="basketTable" method="post" 
	action="<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=jumun_list">  
	
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
			<td class = "basketCheck">
			<input type="checkbox" name = "checkNo" value = "<%=basket.getbNo()%>" class = "check" checked="checked">
			</td>
			
			<td>			
			<%--상품 이미지 --%>                                                                   
			<%-- 이미지 링크, 상세페이지 링크 걸어주기 --%>
			<td class="productImg" id ="productImg">
				<a href="#상품상세페이지">
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="100">
				</a>
			</td> 
			
			
			<%--상품 이름 (버튼타입) – 상품명 누르면 링크 타고 상세페이지로 들어가도록(a태그 사용)) --%>                     
			<%--상세페이지 링크 --%>
			<td>
				<input type="button"  id="name" class="name" name="name" value="<%=product.getpName()%>">			
			</td> 
			
			<%-- 가격--%>
			<td><input type = "text" id="price" class="price" name="price"
				value="<%=product.getpPrice()%>" readonly="readonly">원
			</td> 		
			
			<%-- 수량 (증가/감소)--%>
			<td id = "quantity" class="quantity">
				<span class="count count-box"> 			
				<%--감소버튼 --%>
				
				<%-- 보여지는 수량 숫자 --%>
				<input type="text" class="countInput"  id="count" name="<%=basket.getbNo() %>" value="<%=basket.getbNum() %>개"
				readonly="readonly" style="width: 20px; border: none;">
	
				<%--증가버튼 --%>
				</span>
			</td> 

			
			
			<%-- 배송비--%>
			<td>무료</td> 		
			
				
			<%-- 상품가격 --%>
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
		<button type="button" id = "shopingGo" onclick= "location.href = '<%=request.getContextPath() %>/index.jsp?workspace=main&work=main_page'" >쇼핑 계속하기</button>
		<button type="submit" id= "orderGo">주문하기</button>
		</div>
	
	
		
</div>
</form>
<br> 
	

<%--자바스크립트 --%>
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
	
	//계산된 금액을 표시 
	$("#total").val(total);
	$("#selectedTotal").val(total);
	
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




























