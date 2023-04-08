<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/security/admin_check.jspf" %> --%>
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
	<h2>제품등록</h2>
	
	<%-- 사용자로부터 파일을 입력받아 요청 페이지로 전달하기 위해서는 반드시 form 태그의
	enctype 속성값을 [multipart/form-data]으로 설정 --%>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=product_add_action" 
		method="post" enctype="multipart/form-data" id="productForm">
		<table>
			<tr>
				<td>상품코드</td>
				<td>
					<input type="text" name="pNo" id="pNo">
				</td>
			</tr>
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
				<td>상품명</td>
				<td>
					<input type="text" name="pName" id="pName">
				</td>
			</tr>
			<tr>
				<td>대표이미지</td>
				<td>
					<input type="file" name="pImg" id="pImg">
				</td>
			</tr>
			<tr>
				<td>상세이미지</td>
				<td>
					<input type="file" name="pInfo" id="pInfo">
				</td>
			</tr>
			<tr>
				<td>제품수량</td>
				<td>
					<input type="text" name="pStock" id="pStock">
				</td>
			</tr>
			<tr>
				<td>제품가격</td>
				<td>
					<input type="text" name="pPrice" id="pPrice">
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<button type="submit">제품등록</button>
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
	
	if($("#pImg").val()=="") {
		$("#message").text("대표이미지를 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#pInfo").val()=="") {
		$("#message").text("상세이미지를 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#pStock").val()=="") {
		$("#message").text("제품수량을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
	if($("#price").val()=="") {
		$("#message").text("제품가격을 입력해 주세요.");
		$("#name").focus();
		return false;
	}
	
});	
</script>