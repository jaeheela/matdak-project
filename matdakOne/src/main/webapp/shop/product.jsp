<%@page import="java.text.DecimalFormat"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- PRODUCT 테이블에 저장된 상품을 검색하여 상품 목록을 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 상품 목록을 페이지로 구분 검색하여 응답 처리 - 페이징 처리 --%>
<%-- => [페이지 번호]를 클릭한 경우 상품 목록 출력페이지(product_list)로 이동 - 페이지 번호 전달, 검색대상, 검색단어 전달 --%>
<%-- => [검색]을 클릭한 경우 상품 목록 출력페이지(product_list)로 이동 - 검색대상, 검색단어 전달 --%>
<%-- => [이미지]와 [상품명]을 클릭한 경우 상품 상세 출력페이지(product_detail)로 이동 - 상품번호, 페이지번호, 검색대상, 검색단어 전달 --%>

<%
	String search=request.getParameter("search");
	if(search==null) {
		search="";
	}
	String keyword=request.getParameter("keyword");
	if(keyword==null) {
		keyword="";
	}
	
	//페이징처리
	int pageNum=1; 
	if(request.getParameter("pageNum")!=null) { 
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}	
	//하나의 페이지에 검색되어 출력될 상품의 갯수 설정
	int pageSize=6; 
	int totalProduct=ProductDAO.getDAO().selectProductCount(search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);	
	if(pageNum<=0 || pageNum>totalPage) { //비정상적인 요청 페이지 번호인 경우
		pageNum=1; //첫번째 페이지의 게시글 목록이 검색되어 응답되도록 요청 페이지 번호 변경
	}	
	int startRow=(pageNum-1)*pageSize+1;		
	int endRow=pageNum*pageSize;	
	if(endRow>totalProduct) {
		endRow=totalProduct;
	}
	List<ProductDTO> productList = ProductDAO.getDAO().selectProductList(startRow, endRow, search, keyword);
			
	int printNum=totalProduct-(pageNum-1)*pageSize;
%>

<style type="text/css">
.order_title_con {
    border-bottom: 1px solid #e6e6e6;
}

.order_title_con h2 {
	color: #333;
    font-size: 32px;
    font-weight: 500;
    padding: 0 0 20px;
}

#search {
	display: inline;
	float: right;
	padding: 10px 0 0 5px;
}

option {
	font-size: 13px;
}

.total {
    font-size: 14px;
    padding: 10px 5px 20px;
}

.total strong {
    font-size: 14px;
}

.product-box-list{
	margin: 50px auto; 
	display: flex; 
	flex-wrap: wrap; 
	justify-content: center;
	align-items: center;
}
.product-box{
	position: relative;
	width: 300px;
	height: 350px;
	
}
.product-image{
	position: relative;
}
.product-image img{
	position: relative;
}

.product-name-price {
	padding-top: 15px;
	text-align: center;
}

.product-name {
	font-size: 16px;
    color: #222;
}

.product-price {
	font-size: 20px;
    padding-top: 12px;
}

.product-price span {
	font-size: 18px;
    font-weight: 500;
    color: #222;
}

.product-page-box{
	display: block;
	width: 100%;
	text-align: center;
	margin: 0 auto;
}
</style>

<div class="order_title_con">
	<h2>
		<%if(search.equals("ALL") || search.equals("")){%>
			전체
		<%} else if(search.equals("DAKGASM")){%>
			닭가슴살
		<%} else if(search.equals("ANSIM")){%>
			닭안심살
		<%} else if(search.equals("DOSIRAK")){%>
			도시락
		<%} else if(search.equals("INSTANT")){%>
			즉석/간편식
		<%}else if(search.equals("DESSERT")){%>
			빵/간식
		<%} %>
	</h2>

	<form id="search" method="get" action ="<%=request.getContextPath() %>/index.jsp">
		<input type="hidden" name="workgroup" value="shop">
		<input type="hidden" name="work" value="product">
		<select name="search">
			<option value="ALL" <%if(search.equals("ALL")){ %>selected="selected" <%} %>>&nbsp;전체&nbsp;</option>
			<option value="DAKGASM" <%if(search.equals("DAKGASM")){ %>selected="selected" <%} %>>&nbsp;닭가슴살&nbsp;</option>
			<option value="ANSIM" <%if(search.equals("ANSIM")){ %>selected="selected" <%} %>>&nbsp;닭안심살&nbsp;</option>
			<option value="DOSIRAK" <%if(search.equals("DOSIRAK")){ %>selected="selected" <%} %>>&nbsp;도시락&nbsp;</option>
			<option value="INSTANT" <%if(search.equals("INSTANT")){ %>selected="selected" <%} %>>&nbsp;즉석/간편식&nbsp;</option>
			<option value="DESSERT" <%if(search.equals("DESSERT")){ %>selected="selected" <%} %>>&nbsp;빵/간식&nbsp;</option>
		</select>
		<input type="text" class="search_input" name="keyword" id="keyword" placeholder="검색어를 입력하세요." value="<%=keyword%>">
		<button id="searchBtn" type="submit"><img src="shop/search.png" width="15px" height="15px"></button>
	</form>
</div>

<%--검색된 상품이 없는 경우 --%>
<% if(totalProduct==0) { %>
  	<div class="no_search" style="font-size: 16px; padding-top: 15px;">검색된 상품이 없습니다.</div>
<%-- 검색된 상품이 있는 경우 --%>  	
<% } else { %>
	<p class="total"><strong><%=totalProduct%></strong>개의 상품이 있습니다.</p>	
	<div class="product-box-list">
		<% for(ProductDTO product:productList) { %>
			<% if (product.getpStock()!=0) { %>		
				<div class="product-box" style="margin: 10px 20px 50px 10px;">
					<div class="product-image">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=product.getpNo()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>"> 
							<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="300" height="300">
						</a>
					</div> 
							
					<div class="product-name-price">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=product.getpNo()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
							<div class="product-name">
								<%=product.getpName() %>
							</div> 
							<div class="product-price">
								<%=DecimalFormat.getInstance().format(product.getpPrice())%><span>원</span>
							</div>
						</a>
					</div>
				</div>
			<% } %>	
		<% } %>				
	</div>
<% } %>


<%-- 페이지 번호 출력 및 링크 설정 - 블럭화 처리 --%>
<%
int blockSize=5;
int startPage=(pageNum-1)/blockSize*blockSize+1;
int endPage=startPage+blockSize-1;
if(endPage>totalPage) {
	endPage=totalPage;
}
%>
<span class="product-page-box">
	<% if(startPage>blockSize) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
	<% } %>
		
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else { %>
			<span style="font-weight: 900">[<%=i %>]</span>
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
	<% } %>
</span>
