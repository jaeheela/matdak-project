<%@page import="com.matdak.dao.AdminPDAO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.awt.Image"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="com.matdak.dto.Product"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 
클라이언트에게 전달하는 JSP 문서 --%>  
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [제품정보변경]을 클릭한 경우 제품정보 입력페이지(product_modify.jsp)로 이동 - 제품번호 전달 --%>    
<%@include file="/security/admin_check.jspf" %>
<%
if(request.getParameter("pNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	int pNo=Integer.parseInt(request.getParameter("pNo"));
	
	Product product=ProductDAO.getDAO().selectProduct(pNo);
	
	if(product==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;	
}
td {
	border: 1px solid black;
}
.title {
	background-color: black;
	color: white;
	text-align: center;
	width: 100px;
}
.value {
	padding: 5px;
	text-align: left;
	width: 500px;
}
</style>

<h2>상품상세정보</h2>
<table>
	<tr>
		<td class="title">상품번호</td>
		<td class="value"><%=product.getpNo() %></td>
	</tr>
	<tr>
		<td class="title">카테고리</td>
		<td class="value"><%=product.getpCate() %></td>
	</tr>
	<tr>
		<td class="title">상품명</td>
		<td class="value"><%=product.getpName() %></td>
	</tr>
	<tr>
		<td class="title">대표이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="200">
		</td>
	</tr>
	<tr>
		<td class="title">상세이미지</td>
		<td class="value">
			<img src="<%=request.getContextPath()%>/product_image/<%=product.getpInfo()%>" width="400">
		</td>
	</tr>
	<tr>
		<td class="title">상품수량</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getpStock()) %></td>
	</tr>
	<tr>
		<td class="title">상품가격</td>
		<td class="value"><%=DecimalFormat.getInstance().format(product.getpPrice()) %>원</td>
	</tr>
</table>

<!-- 상품정보변경 -->
<p><button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_modify&pNo=<%=product.getpNo()%>';">제품정보변경</button></p>

<button type="button" id="removeBtn" >글 삭제</button>

<script>
$("#removeBtn").click(function() {
	if(confirm("정말로 삭제 하시겠습니까? (복구 불가능)")){
		location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=product_delete_action&pNo=<%=product.getpNo()%>";
	}
})
</script>
