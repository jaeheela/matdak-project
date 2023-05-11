<%@page import="com.matdak.entity.Product"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pCate=request.getParameter("pCate");
	if(pCate==null) pCate="";
	String keyword=request.getParameter("keyword");
	if(keyword==null) keyword="";
	
	int pageNum=1; 
	if(request.getParameter("pageNum")!=null) { 
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}	
	int pageSize=6; 
	int totalProduct=ProductDAO.getDAO().selectProductCount(search, keyword);
	
	int totalPage=(int)Math.ceil((double)totalProduct/pageSize);	
	if(pageNum<=0 || pageNum>totalPage) { 
		pageNum=1; 
	}	
	int startRow=(pageNum-1)*pageSize+1;		
	int endRow=pageNum*pageSize;	
	if(endRow>totalProduct) {
		endRow=totalProduct;
	}
	
	List<Product> productList = ProductDAO.getDAO().selectProductListBypCate(startRow, endRow, pCate, keyword);
	int printNum=totalProduct-(pageNum-1)*pageSize;
	
	int blockSize=5;
	int startPage=(pageNum-1)/blockSize*blockSize+1;
	int endPage=startPage+blockSize-1;
	if(endPage>totalPage) {
		endPage=totalPage;
	}
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
	<% if(pCate.equals("ALL") || pCate.equals("")){ %> 전체
	<% } else if(pCate.equals("DAKGASM")){ %> 닭가슴살
	<% } else if(pCate.equals("ANSIM")){ %> 닭안심살
	<% } else if(pCate.equals("DOSIRAK")){ %> 도시락
	<% } else if(pCate.equals("INSTANT")){ %> 즉석/간편식
	<% } else if(pCate.equals("DESSERT")){ %> 빵/간식
	<% } %>
	</h2>

	<form id="search" method="get" action ="<%=request.getContextPath()%>/index.jsp">
		<input type="hidden" name="workgroup" value="shop">
		<input type="hidden" name="work" value="product">
		<select name="pCate">
			<option value="ALL" <%if(pCate.equals("ALL")){%>selected="selected" <%}%>>&nbsp;전체&nbsp;</option>
			<option value="DAKGASM" <%if(pCate.equals("DAKGASM")){%>selected="selected" <%}%>>&nbsp;닭가슴살&nbsp;</option>
			<option value="ANSIM" <%if(pCate.equals("ANSIM")){%>selected="selected" <%}%>>&nbsp;닭안심살&nbsp;</option>
			<option value="DOSIRAK" <%if(pCate.equals("DOSIRAK")){%>selected="selected" <%}%>>&nbsp;도시락&nbsp;</option>
			<option value="INSTANT" <%if(pCate.equals("INSTANT")){%>selected="selected" <%}%>>&nbsp;즉석/간편식&nbsp;</option>
			<option value="DESSERT" <%if(pCate.equals("DESSERT")){%>selected="selected" <%}%>>&nbsp;빵/간식&nbsp;</option>
		</select>
		<input type="text" class="search_input" name="keyword" id="keyword" placeholder="검색어를 입력하세요." value="<%=keyword%>">
		<button id="searchBtn" type="submit"><img src="shop/search.png" width="15px" height="15px"></button>
	</form>
</div>

<% if(totalProduct==0) { %>
	<div class="no_search" style="font-size: 16px; padding-top: 15px;">검색된 상품이 없습니다.</div>
<% } else { %>
	<p class="total"><strong><%=totalProduct%></strong>개의 상품이 있습니다.</p>	
	<div class="product-box-list">
		<% for(Product product:productList) { %>
			<% if (product.getpStock()!=0) { %>		
				<div class="product-box" style="margin: 10px 20px 50px 10px;">
					<div class="product-image">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=product.getpNo()%>&pageNum=<%=pageNum%>&pCate=<%pCate%>&keyword=<%=keyword%>"> 
							<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="300" height="300">
						</a>
					</div> 
							
					<div class="product-name-price">
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=product.getpNo()%>&pageNum=<%=pageNum%>&pCate=<%=pCate%>&keyword=<%=keyword%>">
							<div class="product-name"><%=product.getpName() %></div> 
							<div class="product-price"><%=DecimalFormat.getInstance().format(product.getpPrice())%><span>원</span></div>
						</a>
					</div>
				</div>
			<% } %>	
		<% } %>				
	</div>
<% } %>
<span class="product-page-box">
	<% if(startPage>blockSize) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=startPage-blockSize%>&pCate=<%=pCate%>&keyword=<%=keyword%>">[이전]</a>
	<% } %>
		
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=i%>&pCate=<%=pCate%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<% } else { %>
			<span style="font-weight: 900">[<%=i %>]</span>
		<% } %>	
	<% } %>
	
	<% if(endPage!=totalPage) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=shop&work=product&pageNum=<%=startPage+blockSize%>&pCate=<%=pCate%>&keyword=<%=keyword%>">[다음]</a>
	<% } %>
</span>
