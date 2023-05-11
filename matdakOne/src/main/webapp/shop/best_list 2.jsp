<%@page import="com.matdak.dao.BestDAO"%>
<%@page import="com.matdak.dto.BestDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="com.matdak.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- BEST 테이블에 저장된 상품을 검색하여 상품 목록을 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => [이미지]를 클릭한 경우 상품 상세 출력페이지(product_BEST_detail)로 이동 - 상품번호 전달 --%>

<%
	//BEST 테이블에 저장된 모든 상품을 검색
	List<BestDTO> bestList=BestDAO.getDAO().selectBestList();
%>


<link rel="stylesheet" type="text/css" href="shop/best_list.css">

<div>
    <div style="width:940px; margin:0 auto; padding:30px 0 150px;">
        <table class="best_table">
            <colgroup>
                <col width="300">
                <col width="300">
                <col width="300">
            </colgroup>

			<tbody>
			<!-- 1행 -->
			<tr>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best1.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1000"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_1.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 큐브 고추</div> 
						<div class="best_item_price">24,100<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best2.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1001"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_2.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 스테이크 오리지널</div> 
						<div class="best_item_price">20,790<span>원</span></div>
					</div>
				</td>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best3.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1002"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_3.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">한입 소스 닭가슴살 짜장</div> 
						<div class="best_item_price">21,300<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			
			
			<!-- 2행 -->
			<tr>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best4.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1003"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_4.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 볼 스파이시</div> 
						<div class="best_item_price">23,000<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best5.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1004"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_7.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">스팀 닭가슴살 혼합</div> 
						<div class="best_item_price">21,900<span>원</span></div>
					</div>
				</td>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best6.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=1005"> 
							<img
							src="<%=request.getContextPath()%>/product_image/1_6.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">소프트 닭가슴살 고추</div> 
						<div class="best_item_price">17,500<span>원</span></div>
					</div>
				</td>
			</tr>
			
			
			
			
			<!-- 3행 -->
			<tr>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best7.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=5003"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_7.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼 쉐이크 혼합</div> 
						<div class="best_item_price">25,500<span>원</span></div>
					</div>
				</td>
				<td class="td_center">
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best8.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=5004"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_5.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 고백칩 오리지널</div> 
						<div class="best_item_price">13,600<span>원</span></div>
					</div>
				</td>
				<td>
					<!-- best no -->
					<div class="best_no_area">
						<img src="shop/best/best9.jpg">
					</div> 
					<!-- best 상품이미지 --> 
					<div class="best1">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_BEST_detail&BtNo=5005"> 
							<img
							src="<%=request.getContextPath()%>/product_image/5_6.jpg" width="300" height="300">
						</a>
					</div> 
					<!-- best 상품명&가격 -->
					<div class="best_item_info">
						<div class="best_item_name">닭가슴살 한끼 크로크무슈 오리지널</div> 
						<div class="best_item_price">18,600<span>원</span></div>
					</div>
				</td>
			</tr>
			</tbody>
		</table>
		<%-- for문 끝난 다음에 초기화 --%>
		<div style="clear: both;"></div>
    </div>  
</div>

