<%@page import="xyz.itwill.dao.JumunDAO"%>
<%@page import="xyz.itwill.dto.JumunDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--로그인회원과 관리자만 권한 --%>
<%@include file="/security/login_check.jspf"%>

<%
	//아이디를 전달받아 주문정보를 검색해 반환하는 dao 메소드 호출 
	String jid = loginHewon.gethId();
	JumunDTO jumun = JumunDAO.getDAO().selectJumun(jid);
%>

<style type = "text/css">
.orderinquiry_title {
    color: #333;
    font-size: 32px;
    font-weight: 500;
    padding: 0 0 10px;
    border-bottom: 1px solid #e6e6e6;
}
.orderComplete {
    text-align: center;
    padding-top: 80px;
}
.orderComplete_th {
    font-size: 30px;
    font-weight: bold;
}
.orderComplete_th span {
    color: #f22;
    font-size: 30px;
    font-weight: bold;
}
.orderComplete_notice {
    font-size: 15px;
    padding-top: 12px;
}
.content_title {
    color: #333;
    font-size: 20px;
    padding: 0 0 10px 20px;
    font-weight: bold;
    padding-top: 80px;
    border-bottom: 1px solid #333;
}
.order_summaryInfo_area {
    padding: 14px 20px;
    border-bottom: 1px solid #eee;
}
ul {
    padding-left: 0;
    margin: 0;
}
.order_summaryInfo li {
    float: left;
    width: 30%;
}
tbody {
    display: table-row-group;
    vertical-align: middle;
    border-color: inherit;
}
tr {
    display: table-row;
    vertical-align: inherit;
    border-color: inherit;
}
.summaryInfo_table th {
    color: #999;
    font-size: 17px;
    font-weight: normal;
    text-align: left;
}
.summaryInfo_table td {
    color: #333;
    padding: 5px 0;
    font-size: 16px;
}
.orderinquiryview_bottom_area {
    text-align: center;
    width: 455px;
    margin: 0 auto;
    padding-top: 80px;
}
ul {
    padding-left: 0;
    margin: 0;
}
.orderinquiryview_bottom li {
    float: left;
}
.orderinquiryview_bottom li {
    float: left;
}
a:link, a:visited {
    text-decoration: none;
}
ul {
    display: block;
    list-style-type: disc;
    margin-block-start: 1em;
    margin-block-end: 1em;
    margin-inline-start: 0px;
    margin-inline-end: 0px;
    padding-inline-start: 40px;
}
.orderinquiryshoping_go {
    width: 220px;
    height: 50px;
    line-height: 50px;
    font-size: 20px;
    color: #B11116;
    border: 1px solid #B11116;
    background-color: #fff;
    cursor: pointer;
}
li {
    list-style-type: none;
}

.orderinquiryList_go {
    width: 220px;
    height: 50px;
    line-height: 50px;
    font-size: 20px;
    color: #fff;
    background-color: #B11116;
    cursor: pointer;
    position: relative;
    left: 250px;
    bottom: 50px;

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
#orderCheck {
    background-color: #B11116;
    color: #fff;
    width: 220px;
    display: inline-block;
    text-align: center;
    padding: 10px 0;
    font-size: 18px;
    cursor: pointer;
}




</style>    
    
    
    
    
    
<%--결제 완료 후 페이지 --%>


<div id="orderinquiryview_wrap">

	<div class="order_content_box">

		<!-- 주문완료 title -->
		<div class="orderinquiry_title">주문완료</div>
		
		<!-- 주문완료 확인 -->
		<div class="orderComplete">
			<div class="orderComplete_th">감사합니다. <span>주문이 완료</span>되었습니다.</div>
			<div class="orderComplete_notice">주문하신 상품정보는 마이페이지에서 다시 확인이 가능합니다.</div>
		</div>
	
	
		
		
		<!-- 주문요약정보 -->
		<div>
			<div class="content_title">주문요약정보</div>
			<div class="order_summaryInfo_area">
				<ul class="order_summaryInfo">
					
						<table class="summaryInfo_table">
							<colgroup>
								<col width="35%">
								<col width="65%">
							</colgroup>
							<tr>
								<th scope="row">주문번호</th>
								<td>&nbsp;&nbsp;<%=jumun.getjNo() %></td>
							</tr>
							<tr>
								<th scope="row">주문자명</th>
								<td>&nbsp;&nbsp;<%=loginHewon.gethName()%></td>
							</tr>
							
							<tr>
								<th scope="row">상품금액</th>
								<td>&nbsp;&nbsp;<%=jumun.getjTp() %>원</td>
							</tr>
							<tr>
								<th scope="row">배송비</th>
								<td>&nbsp;&nbsp;무료</td>
							</tr>
				
							
														
						</table>
				</ul>
			</div>
		</div>
		
		
		<!-- 하단 버튼 -->
		<div class="orderinquiryview_bottom_area">
			<button type="button" id = "shopingGo" onclick= "location.href = '<%=request.getContextPath() %>/index.jsp?workgroup=main&work=main_page'" >쇼핑 계속하기</button>
			<button type="submit" id= "orderCheck" onclick= "location.href = '<%=request.getContextPath() %>/index.jsp?workgroup=mypage&work=mypage_main'" >구매내역 확인</button>				
							
		</div>
	</div>



    </div>
 
