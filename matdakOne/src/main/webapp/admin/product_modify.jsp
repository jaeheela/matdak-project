<%@page import="java.io.PrintWriter"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/admin_check.jspf" %>
<%
	if(request.getParameter("pNo")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	int pNo=Integer.parseInt(request.getParameter("pNo"));
	ProductDTO product=ProductDAO.getDAO().selectProduct(pNo);
	
	if(product==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
%>

<style type="text/css">
#product {
	width: 800px;
	margin: 0 auto;
}
table {
	margin: 0 auto;
}
td {
	text-align: left;
}
</style>

<div id="product">
	<h2>상품변경</h2>
	
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin_action&work=product_modify_action" method="post" enctype="multipart/form-data" id="productForm">
		<input type="hidden" name="pNo" value="<%=product.getpNo()%>">
		<input type="hidden" name="currentpImg" value="<%=product.getpImg()%>">
		<input type="hidden" name="currentpInfo" value="<%=product.getpInfo()%>">
		<table>
			<tr>
				<td>카테고리</td>
				<td>
					<select name="pCate">
						<option value="DAKGASM">닭가슴살</option>
						<option value="ANSIM">닭안심살</option>
						<option value="DOSIRAK">도시락</option>
						<option value="INSTANT">즉석/간편식</option>
						<option value="DESSERT">빵/간식</option>
					</select>
				</td>
			</tr>
			<tr>
				<td>제품명</td>
				<td>
					<input type="text" name="pName" id="pName" value="<%=product.getpName()%>">
				</td>
			</tr>
			<tr>
				<td>대표이미지</td>
				<td>
					<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="200">
					<br>
					<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>
					<br>
					<input type="file" name="pImg" id="pImg">
				</td>
			</tr>
			<tr>
				<td>상세이미지</td>
				<td>
				<img src="<%=request.getContextPath()%>/product_image/<%=product.getpImg()%>" width="400">
					<br>
					<span style="color: red;">이미지를 변경하지 않을 경우 입력하지 마세요.</span>
					<br>
					<input type="file" name="pInfo" id="pInfo">
				</td>
			</tr>
			<tr>
				<td>제품수량</td>
				<td>
				<input type="text" name="pStock" id="pStock" value="<%=product.getpStock()%>">
				</td>
			</tr>
			<tr>
				<td>제품가격</td>
				<td>
					<input type="text" name="pPrice" id="pPrice" value="<%=product.getpPrice()%>">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">제품변경</button>
				</td>
			</tr>
		</table>	
	</form>	
	<div id="message" style="color: red;"></div>
</div>

<script>
$("#productForm").submit(function() {
	if($("#pName").val()=="") {
		$("#message").text("제품명을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#pStock").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#pPrice").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
});	
</script>