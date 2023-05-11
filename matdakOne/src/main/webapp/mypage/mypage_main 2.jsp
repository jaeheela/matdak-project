<%@page import="com.matdak.entity.Jumun"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.matdak.dao.CartDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/resources/mypage/mypage_main.css">

<!-- 마이페이지 - 구매내역 -->
<%-- 회원정보(회원 아이디)를 전달받아 테이블에 저장된 해당 아이디로 구매한 제품정보를 검색 - List --%>
<%-- => 만약 구매한 제품정보가 없다면 메세지 출력 --%>

<%@include file="/security/login_url.jspf"%>

<%
List<JumunDTO> jumunList = JumunDAO.getDAO().selectJumunList(loginHewon.gethId());
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mat Dak</title>
</head>
<body>
	<!-- 마이페이지 상단 head -->
	<div id="mypage_wrap">
		<!-- 마이페이지 title -->
		<div class="mypage_title">마이페이지</div>
		
		<!-- 마이페이지 닉네임 -->
		<div class="mypage_head">
			<%-- <div class="mypage_head_id"><%=loginMember.gethId() %></div> --%>
			<div class="mypage_head_id"><%=loginHewon.gethId()%></div>
		</div>
	</div>
	
	<!-- 마이페이지 tablist -->
	<div class="mypage_head_list">
		<ul>
			<li class="head_list_chk">
				<a href=""><img src="mypage/mypage_list1.png" alt="구매내역"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="index.jsp?workgroup=mypage&work=mypage_hewon"><img src="mypage/mypage_list9.png" alt="회원관리"></a>
			</li>
		</ul>
	</div>
	
<script type="text/javascript">
//마이페이지 첫 li css속성을 다른 li들을 클릭하면 똑같이 사용할 수 있도록 만들기
$(".mypage_head_list ul li").click(function(){
	$(".mypage_head_list ul li").removeClass("head_list_chk");
	$(this).addClass("head_list_chk");
});
</script>

<div id="mypage_buy_list_wrap">
	<div class="buy_list_wrap">
	
		<!-- buy_list_tab -->
		<div class="buy_list_tab">
			<span class="all_buy_list select_tab">전체구매내역</span>
		</div>
		
		<%
			if(jumunList.isEmpty()) {
		%>
			<div style="text-align: center; margin: 50px 0 0 0; font-weight: 530;">구매내역이 존재하지 않습니다.
		<%
		} else {
		%>
			<%
			for(Jumun jumun:jumunList) {
			%>
			<!-- buy_list content -->
			<div class="buy_list_wrapper">
				<div class="buy_list_box">
					<table>
					
						<colgroup>
							<col width="150px">
							<col width="700px">
						</colgroup>
						
						<tbody>
						<tr class="buy_list_title">
							<td class="buy_list_left_top">
								<span style="font-weight: 500; font-size: 17px;"> 주문날짜 </span>
							</td>
							<td style="text-indent: 20px;">
								<span style="color: #999; font-weight: 500; font-size: 16px;">주문번호 </span> 
							</td>
						</tr>
						<tr class="buy_list_content_box">
							<td class="buy_list_left" style="border-top: 1px solid #eee; border-left: 1px solid #eee;">
								<div class="buy_list_pay">
									<span style="font-size: 16px;"> 총 주문금액 </span>
									<div class="buy_total_pay">
										<span style="font-weight: 550; font-size: 21px; display: inline-block; padding-top: 10px;"><%=DecimalFormat.getInstance().format(jumun.getjTp()) %></span>
										<span style="font-weight: 300; font-size: 18px;">원</span>
									</div>
								</div>
							</td>
							<td class="buy_list_info_area" style="border: 1px solid #eee;">
								<div>
									<div class="buy_goods_info">
										<div class="product_info">
											<div class="buy_list_img">
												<a href="<%=request.getContextPath() %>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=jumun.getjPpno() %>">
													<img src="<%=request.getContextPath()%>/product_image/<%=jumun.getjPimg()%>" width="90" height="90" style="margin-left: 10px;" id="">
												</a>
											</div>
											<!-- 상품상세정보 -->
											<div class="buy_list_info">
												<div style="padding-left: 10px; padding-bottom: 7px;">
													<a href="index.jsp?workgroup=shop&work=product_detail"
														class="product_title" style="font-size: 16px;"><%=jumun.getjPname() %></a>
												</div>
												<div class="product_title2">
													<table>
														<colgroup>
															<col width="369px">
															<col width="120px">
															<col width="110px">
														</colgroup>
														<tbody>
															<tr>
																<td class="title"></td>
																<td class="product_add_price"><span><%=DecimalFormat.getInstance().format(jumun.getjPprice()) %></span>원</td>
																<td class="product_add_amount"><span><%=jumun.getjNum() %></span>개</td>
															</tr>
														</tbody>
													</table>
												</div>
											</div>
										</div>
										<div class="product_delivery" style="padding: 0 0 0 10px;">
											<span class="product_img" style="width: 15px;"> <img
												src="https://masitdak.com/img/mypage/buy_delivery1.png" style="padding: 0;"></span>
											<span class="product_deli1"> <span
												class="product_deli1" style="font-size: 16px;"> 주문완료 </span>
											</span>
										</div>
									</div>
									<div class="product_delivery_modify" style="padding: 15px 15px 10px 10px;">
										<span class="delivery_img"> 
											<img src="delivery_car.png" alt="">
										</span> 
										<span style="padding: 5px 0; font-size: 16px;"> [<%=jumun.getjPostcode()%>] <%=jumun.getjOaddr1() %> <%=jumun.getjOaddr2() %> </span>
									</div>
								</div>
							</td>
						</tr>
						</tbody>
					</table>
				</div>
			</div>
			<% } %>
		<% } %>
		</div>	
	</div>
</div>
</html>