<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="xyz.itwill.dao.BasketDAO"%>
<%@page import="xyz.itwill.dto.BasketDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%--주문&결제 페이지 --%>

<style type="text/css">
html, h1, h2, h3, h4, h5, h6, form, fieldset, img {
    margin: 0;
    padding: 0;
    border: 0;
}
#payBtn{
	background-color: #B11116;
	color: #fff;
	width: 220px;
	display: inline-block;
	text-align: center;
	padding: 10px 0;
	font-size: 18px;
	cursor: pointer;
}
.payBtnBox {
    width: 200px;
    margin: 0 auto;
    padding-top: 60px;
    padding-bottom: 100px;
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
input{
	outline: none;
	border: 0 solid black;
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
.price{
	text-align: right;
}
.total{
	text-align: right;
}
.deliveryfee{
	font-size: 12px;
}
th{
  border="0" ;
  cellpadding="0";
   cellspacing="0";
}
.error{
	color : red;
	position : relative;
	font-size : 11px;
	display: none;
}
.orderTitle{
	padding: 20px;
}
.payTitle{
		padding: 20px;
}
.payBox {
    padding: 34px 20px;
    border-bottom: 1px solid #ddd;
}
.agreeTitle {
    width: 131px;
    text-align: left;
    font-weight: normal;
    font-size: 18px;
    vertical-align: top;
    padding-top: 5px;
}
.agreeTable {
    width: 100%;
    border-collapse: collapse;
}
.agree{
    border: 1px solid #eee;
}
.deliveryBox {
    color: #333;
    font-size: 20px;
    padding: 0 0 10px 20px;
    padding-top: 80px;
    border-bottom: 1px solid #333;
}
#selectedTotal{
	color: red;
	font-size: 19px;
}
.total{
	color: red;
}
.orderInfo_table{
	font-size: 17px;
}
.delivery_table td {
    padding: 8px 0;
}
.error {
    width: 200px;
    height: 43px;
    padding-left: 11px;
    box-sizing: border-box;
    font-size: 14px;
    font-style: bold;
}
td{
	font-size: 17px;
	font-style: normal;
}




</style>







<%--로그인 사용자와 관리자만 사용 가능 --%>
<%@include file="/security/login_check.jspf"%>

<%
  //주문 목록 불러오기 
    List<BasketDTO> basketList = BasketDAO.getDAO().selectBasketList(loginHewon.gethId());
    List<ProductDTO> productList = new ArrayList<ProductDTO>();
    List<Integer>qtyList = new ArrayList<Integer>();
    int totalList = 0;
  
    for (BasketDTO basket : basketList) {
      int pNo = basket.getbPno();
      ProductDTO product = ProductDAO.getDAO().selectProduct(pNo);
      productList.add(product);
      qtyList.add(basket.getbNum());
      totalList += product.getpPrice() * basket.getbNum();
    }
%>

  <div class = "titleArea">주문하기</div>

  <form id = "orderForm" class = "orderForm" method = "post" 
  action = "<%=request.getContextPath()%>/index.jsp?workgroup=basket&work=basket_submit_action">
  <%--결제하기 submit 이동 --%>

  <div class="orderList">
    <table>
      <tr>
        <th colspan="5">상품정보</th>
        <th>상품금액</th>
      </tr>

    <%-- 반복처리 --%>
    <%
      for(int i=0;i<productList.size();i++){
    %>
    <tr>
    
      <%-- 상품 이미지 --%>
      <td class = "productImg" name = "productImg">
        <a href="#">
          <img src="<%=request.getContextPath()%>/product_image/<%=productList.get(i).getpImg()%>" width="150">
        </a>
      </td>

      <%-- 상품이름 --%>
      <td>
        <input type="text" id = "name<%=i%>" class="name" name = "Jname"
        value="<%=productList.get(i).getpName()%>"> 
      </td>

      <%-- 가격 --%>
        <td>
          <input id="price<%=i%>" class="price" name="price"
          value="<%=productList.get(i).getpPrice()%>원"
          readonly ="readonly">
 
        </td>

        <%-- 수량 --%> 
        <td id = "quantity<%=i%>" class = "quantity">
          <input type="text" class="countInput" id="quantity<%=i%>" 
          name="countInput" value="<%=qtyList.get(i)%>"
          readonly ="readonly" style="width: 20px; border: none;">개
  
        </td>

        <%-- 배송비 --%>
        <td class = "deliveryfee">무료</td>

        <%-- 상품금액 --%>
        <td>
          <input id = "total-<%=i%>" class = "total"
          value="<%=(productList.get(i).getpPrice() * qtyList.get(i))%>원"
          name="total" readonly ="readonly">
        </td>
        
    </tr>
    <% } %>
    </table>

    <%-- 총 주문금액 --%>
    <div class = "orderBox">
      <table>
        <tr>
          <td colspan="5">총 주문금액</td>
          <td>
          <input id = "selectedTotal" name = "selectedTotal" readonly = "readonly" value="<%=totalList%>">원
          </td>
        </tr>
      </table>
    </div>
  </table>  


    <%-- 주문자 정보 --%>
    <div>
      <div class = "orderTitle">주문자 정보</div>
        <div class = "orderInfo">
          <table class = "orderInfo_table">
            <tbody>
              <tr>
                <td>이름</td>
                <td><%=loginHewon.gethName()%></td>
              </tr>

              <tr>
                <td>핸드폰번호</td>
                <td>
                <input type="tel" readonly = "readonly" value = "<%=loginHewon.gethPhone()%>">
                </td>
              </tr>

            </tbody>
          </table>
        </div>
    </div>


    <%-- 배송정보 --%>
    <div class="deliveryBox">
      <div class = "deliveryTitle">배송정보</div>
        <div class = "deliveryInfo">
          <fieldset>
          <table class ="cc">
            <tr>
              <td >이름</td>
              <td>
                <input type="text" id="name" name = "name" maxlength="10" required = "required" value = "<%=loginHewon.gethName()%>">  
                <span id="nameMsg" class="error">이름을 입력해 주세요.</span>
              </td>
            </tr>

            <tr>
              <td>핸드폰번호</td>
              <td>
                <input  type="tel" id="phone" name = "phone" required = "required" value="<%=loginHewon.gethPhone()%>"> 
                <div id="mobileMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
              </td>
            </tr>

            <tr>
              <td>주소</td>
              
              
              <%-- 우편번호 --%>
              <td>
              <input type="text" name="zipcode" id="zipcode" size="7" readonly="readonly" placeholder="우편번호">
              <button type="button" id = "postSearch">우편번호</button>
              <span id="zipcodeMsg" class="error">우편번호를 입력해 주세요.</span>
              </td>
            </tr>

            <%-- 기본주소 --%>
            <tr>
              <td>
              <span id="address1Msg" class="error">기본주소를 입력해 주세요.</span>
              <input type="text" name="address1" id="address1" size="50" readonly="readonly" placeholder="기본주소">
 
           
            </td>
             </tr>

            <%-- 상세주소--%>
            <tr>
              <td>
              <div id="address2Msg" class="error">상세주소를 입력해 주세요.</div>
              <input type="text" name="address2" id="address2" size="50" placeholder="상세주소">
            
            </td>
            </tr>


          <%-- 배송메세지 --%>
          <tr>
          <td class = "deliveryMemo">
            <select name="memo" id="memo" class="orderMessageDelivery" style="margin-bottom:16px;" onchange="selectMemo(this.value);">
              <option id="od_meno" value="">배송메세지를 선택해주세요.</option>
              <option value="1">♬ 와요 와요 와요 와~ 올때 안전한 배송!</option>
              <option value="2">♬ 시간을 달려서~ 빠른 배송해주세요</option>
              <option value="3">♬ 매일 울리는 벨벨벨~ 오늘은 경비실에 맡겨주세요</option>
              <option value="4">♬ 어디야 집이야~ 아뇨. 집앞에 놔주세요</option>
              <option value="5">♬ 얼굴 찌푸리지 말아요~ 경비실에 맡겨주세요.</option>
              <option value="6">♬ 낯선 낯선 택배의 낯선 향기에~ 미리 연락부탁해요.</option>
              <option value="7">♬ 택배 말할 것 같으면~ 부재 시 집앞에 두세요</option>
              <option value="8">♬ Sign을 보내 signal 보내 부재 시 연락줘요</option>
              <option value="9">기타</option>
            </select>
          </td>

          </table>
        </fieldset>                                                              
        </div>
    </div>


    
     <%-- 결제정보 --%>
    <div class = "payBox">
    	   <div class = "payTitle">결제정보</div>
      <table class="payBox_table">
        <tr>
          <td>결제수단</td>
          <td>
            <label for="noCard">무통장입금</label>
            <input type="radio" id = "noCard" name = "paymethod" class ="check" value="무통장입금">
          </td>
  
          <td>
            <label for = "liveAccount">실시간계좌이체</label>
            <input type="radio" id = "liveAccount" name = "paymethod" class ="check" value="실시간계좌이체">
          </td>
  
          <td>
            <label for = "card">신용/체크카드</label>
            <input type="radio" id = "card" name = "paymethod" class ="check" value ="신용/체크카드">
          </td>
  
          <td>
            <label for = "phonePay">휴대폰결제</label>
            <input type="radio" id = "phonePay" name="paymethod" class ="check" value="휴대폰결제">
          </td>
        </tr>
      </table>


    <%--약관동의 --%>
    <div class = "agreementBox">
      <table class="agree_table">
        <tbody>
          <tr>
            <th class = "agreeTitle">약관동의</th>
            <td>
              <table class = "agreeTable">

                <tr>
                  <td>
                    <input type="checkbox" id = "agreeAll" class = "agreeAll">
                  
                  이용약관에 모두 동의합니다.</td>
                </tr>
                
                <tr>
                  <td>
                  <input type="checkbox" id = "agreeInfo" name="agree" class = "agree">
                  개인정보 제3자 제공 동의
                </td>
                </tr>

                <tr>
                  <td>
                  <input type="checkbox" id = "agreePay" name = "agree" class = "agree">
                  결제대행서비스 이용 동의
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </tbody>
      </table>
    </div>
  </div>


    <%-- 결제하기 버튼 --%>
    <div class="payBtnBox">
      <input type="submit" id="payBtn" class = "payBtn" value = "결제하기">
    </div>



</div>
</form>




<script type="text/javascript">


//유효성 검사 (이름, 전화번호, 주소)
	$(".error").css("display","none");
$("#orderForm").submit(function() {
	var submitResult=true;
	
	
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	if($("#mobile").val()=="") {
		$("#mobileMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#zipcode").val()=="") {
		$("#zipcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#address1").val()=="") {
		$("#address1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#address2").val()=="") {
		$("#address2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});
  

	//결제하기 버튼 클릭  (수정)
	
		$("#orderForm").submit(function() {
			var submitResult=true;
			
		
		//결제수단 미선택시 
		if($(".check").filter(":checked").length!=1){
		    confirm("결제수단을 선택해주세요.");
			submitResult=false;
		}
		  //약관동의 미선택시
		if($(".agree").filter(":checked").length!=2){
		  confirm("약관에 모두 동의해주세요.");
			submitResult=false;
		  
		}
		  
		return submitResult;

	});
	
		//체크박스 체크 해제시 
		$(".agree").change(function () {
			let isAllChecked = true;
			
			if($(this).is(":checked")){ //체크박스 체크시 
			$(".agree").each(function (i,element) { //체크박스 전체 체크 여부 검사 
				if(!$(element).is(":checked")){ //체크 박스 중 하나가 체크되지 않을 경우 전체선택 버튼 미체크
					isAllChecked = false;
					return false;	
				}
			});
			
			if(isAllChecked){
				$("#agreeAll").prop("checked",true);
			}
			}else { //체크박스 체크 해체시
				$("#agreeAll").prop("checked", false);

			}
		});




  //약관동의 전체 선택 기능
  if($("#agreeAll").change(function () {
      if($(this).is(":checked")){
      $(".agree").prop("checked",true); 
        }else {
        $(".agree").prop("checked",false);  
        }
  }));
  






  //다음 우편번호 서비스 연결 

</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {
  new daum.Postcode({
  oncomplete: function(data) {
  $("#zipcode").val(data.zonecode);
  $("#address1").val(data.address);
  }
  }).open();
});
</script>





