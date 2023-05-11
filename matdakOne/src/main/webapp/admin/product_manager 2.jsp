<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.matdak.dao.AdminPDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="com.matdak.dto.Product"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 모든 제품정보를 검색하여
클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>    
<%-- => [제품등록]을 클릭한 경우 제품정보 입력페이지(product_add.jsp)로 이동 --%>
<%-- => [카테고리]가 변경된 경우 제품목록 출력페이지(product_manager.jsp)로 이동 - 입력값 전달 --%>
<%-- => 제품정보의 [제품명]을 클릭한 경우 제품정보 출력페이지(product_detail.jsp)로 이동 - 제품번호 전달 --%>
<%@include file="/security/admin_check.jspf" %>
<%
String pCate=request.getParameter("pCate");
	if(pCate==null) {
		pCate="ALL";		
	}
	
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	int pageSize = 10;
	
	int totalProduct=ProductDAO.getDAO().selectProductCountpCate(pCate);
	
	int totalPage = (int)Math.ceil((double)totalProduct/pageSize);
	
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	
	int startRow = (pageNum-1)*pageSize+1;
	
	int endRow = pageNum*pageSize;
	
	if(endRow>totalProduct){
		endRow=totalProduct;
	}
	
	List<Product> productList=ProductDAO.getDAO().selectProductListKeywordpCate(startRow, endRow, pCate);
	
	String currentDate=new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int printNum=totalProduct-(pageNum-1)*pageSize;
%>

<style type="text/css">

h2 {
	text-align: center;
	padding-bottom: 10px;
	font-weight: 530;
}

.product-paging-box{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

#product {
	width: 1000px;
	margin: 0 auto;
}
#btn {
	text-align: right;
	margin-bottom: 5px;
}
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}
th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	width: 200px;
	font-size: 16px;	
}
th {
	background-color: #eee;
	color: black;
}
.pname {
	width: 500px;
}
td a, td a:hover {
	text-decoration: underline;
	color: red;
	font-size: 16px;
}

option {
	font-size: 13px;
}
</style>

<div id="product">
	<h2>제품목록</h2>
	
	<div id="btn">
		<button type="button" id="addBtn" style="font-size: 15px; padding: 3px;">제품등록</button>
	</div>
	
	<table>
		<tr>
			<th>제품번호</th>
			<th class="pname">제품명</th>
			<th>카테고리</th>
			<th>제품수량</th>
			<th>제품가격</th>
			<th style="width: 400px;">제품등록일자</th>
		</tr>
		
		<%
				if(productList.isEmpty()) {
				%>
		<tr>
			<td colspan="6">검색된 제품이 하나도 없습니다.</td>
		</tr>
		<%
		} else {
		%>
			<%
			for(Product product:productList) {
			%>
			<tr>
				<td><%=product.getpNo()%></td>
				
				<!-- 제품명 -->
				<td class="pName">
				
					<!-- 게시글 상태를 구분하여 제품명과 링크를 다르게 설정하여 응답되도록 처리 -->
					<% if(product.getpStatus().equals("1")) { //존재하는 상품인 경우 %>
						<a href="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product_detail&pNo=<%=product.getpNo()%>&pageNum=<%=pageNum%>">
							<%=product.getpName() %>
						</a>
					<% } if(product.getpStatus().equals("0")) { //삭제된 상품인 경우 %>
						삭제된 제품입니다.
					<% } %>
				</td>
				
				<% if(!product.getpStatus().equals("0")) { %>
				<!-- 카테고리 -->
				<td><%=product.getpCate() %></td>
				
				<!-- 재고 -->
				<td>
					<%=DecimalFormat.getInstance().format(product.getpStock()) %>
				</td>
				
				<!-- 제품가격 -->
				<td>
					<%=DecimalFormat.getInstance().format(product.getpPrice())%><span style="font-size: 16px;">원</span>
				</td>
				
				<!-- 제품등록일 -->
				<td>
					<% if(currentDate.equals(product.getpRegdate().substring(0, 10))) { %>
						<%=product.getpRegdate().substring(11) %>
					<% } else { %>
						<%=product.getpRegdate() %>
					<% } %>
				</td>
				<% } else { %>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
					<td>&nbsp;</td>
				<% } %>	
			</tr>
			<% } %>
		<% } %>
	</table>
	
	<br>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product_manager" 
		method="post" id="productForm">
		<select name="pCate" id="pCate" style="font-size: 13px;">
			<option value="ALL" <% if(pCate.equals("ALL")) { %> selected="selected" <% } %>>
				전체
			</option>
			<option value="DAKGASM" <% if(pCate.equals("DAKGASM")) { %> selected="selected" <% } %>>
				닭가슴살
			</option>
			<option value="ANSIM" <% if(pCate.equals("ANSIM")) { %> selected="selected" <% } %>>
				닭안심살
			</option>
			<option value="DOSIRAK" <% if(pCate.equals("DOSIRAK")) { %> selected="selected" <% } %>>
				도시락
			</option>
			<option value="INSTANT" <% if(pCate.equals("INSTANT")) { %> selected="selected" <% } %>>
				즉석/간편식
			</option>	
			<option value="DESSERT" <% if(pCate.equals("DESSERT")) { %> selected="selected" <% } %>>
				빵/간식
			</option>	
		</select>	
	</form>
</div>

<%
int blockSize=5;

int startPage=(pageNum-1)/blockSize*blockSize+1;

int endPage=startPage+blockSize-1;

if(endPage>totalPage) {
	endPage=totalPage;
}
%>

<div class="product-paging-box" style="text-align: center;">
	<span>
	<% if(startPage>blockSize) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_manager&pageNum=<%=startPage-blockSize%>" style="font-size: 16px;">[이전]</a>
	<% } %>
		
	<% for(int i=startPage;i<=endPage;i++) { %>
		<% if(pageNum!=i) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_manager&pageNum=<%=i%>" style="font-size: 16px;">[<%=i %>]</a>
		<% } else { %>
			<span style="font-weight: 900; font-size: 16px;" >
				[<%=i %>]
			</span>
		<% } %>	
	<% } %>
		
	<% if(endPage!=totalPage) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_manager&pageNum=<%=startPage+blockSize%>" style="font-size: 16px;">[다음]</a>
	<% } %>
	</span>
</div>

<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_add";
});
$("#pCate").change(function() {
	$("#productForm").submit();
});
</script>