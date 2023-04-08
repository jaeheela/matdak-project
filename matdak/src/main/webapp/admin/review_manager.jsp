<%@page import="xyz.itwill.dao.AdminRDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation"%>
<%@page import="java.text.ParseException"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.text.DecimalFormat"%>
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
	//카테고리값이 변경될 경우
	String category=request.getParameter("category");
	if(category==null) {
		category="10";
	}
	//전달값을 반환받아 저장
	int rStatus=Integer.parseInt(category);
	

%>

<%
	//검색대상과 검색단어를 반환받아 저장
	String search = request.getParameter("search");
	if(search==null){
		search="";
	}
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	
	//페이징처리 관련 요청페이지번호를 반환받아 저장
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 이미지의 갯수 설정
	int pageSize = 6;
	
	//검색 관련 정보를 전달받아 review 테이블에 저장된 특정 공지사항의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalreview = AdminRDAO.getDAO().selectReviewCount(search, keyword,rStatus);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage = (int)Math.ceil((double)totalreview/pageSize);
	
	//요청페이지번호 검증 - 비정상적인 요청
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	
	//시작행과 종료행을 계산하여 저장
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totalreview){
		endRow=totalreview;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료게시글의 행번호를 전달받아
	//review 테이블에 저장된 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 DAO클래스의 메소드 호출
	List<ReviewDTO> reviewList = AdminRDAO.getDAO().selectReviewList(startRow, endRow, search, keyword,rStatus);
	
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청페이지에 검색되어 출력될 시작 게시글의 일련번호에 대한 시작값을 계산하여 저장
	int printNum = totalreview-(pageNum-1)*pageSize;
	
	//페이징 처리
	//하나의 페이지 블럭에 출력될 페이지 번호의 갯수 설정
	int blockSize = 5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	int StartPage=(pageNum-1)/blockSize*blockSize+1;
	
	//페이지블럭에 출력될 종료 페이지 번호를 계산하여 저장
	int endPage=StartPage+blockSize-1;
	//마지막페이지 블럭의 종료 페이지 번호 변경
	if(endPage>totalPage){
		endPage=totalPage;
	}
%>


<style type="text/css">

h2 {
	text-align: center;
	padding-bottom: 15px;
	font-weight: 530;
}

.review-searching-box{
	margin-top:20px;
	text-align: center;
}


.pname {
	width: 600px;
}


.review-paging-box{
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
	<h2>리뷰 목록</h2>
	

	
	<table>
		<tr>
			<th>리뷰 번호</th>
			<th>ID</th>
			<th class="rName">리뷰 내용</th>
			<th>리뷰 상태<br>(0:삭제,1:일반,2:비밀)</th>
			<th>리뷰 작성일</th>
		</tr>
		
		<% if(reviewList.isEmpty()) { %>
		<tr>
			<td colspan="4">검색된 리뷰가 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(ReviewDTO review:reviewList) { %>
			<tr>
				<td><%=review.getrCode()%></td>
				<td><%=review.getrId()%></td>
				<td>	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=review#<%=review.getrCode()%>">
				<%=review.getrContent()%>	</a> </td>
				<td><%=review.getrStatus() %></td>	
				<td><%=review.getrDate() %></td>	
			</tr>
			<% } %>
		<% } %>
	</table>
	
	<br>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=review_manager" 
		method="post" id="productForm">
		<select  name="category" id="category">
			<option value="10" <% if(category.equals("10")){ %> selected="selected" <% } %>>
				전체
			</option>
			<option value="1" <% if(category.equals("1")) { %> selected="selected" <% } %>>
				일반
			</option>
					<option value="2" <% if(category.equals("2")) { %> selected="selected" <% } %>>
				비밀
			</option>
			<option value="0" <% if(category.equals("0")) { %> selected="selected" <% } %>>
				삭제
			</option>

		</select>	
	</form>
</div>

<div class="review-paging-box">

		<% if(StartPage>blockSize) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=review_manager&pageNum=<%=StartPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=rStatus%>" style="font-size: 16px;">[이전]</a>
		<% } else{ %>
			<span style="color: gray; font-size: 16px;">[이전]</span>
		<%} %>
		
		<%for(int i=StartPage; i<=endPage; i++) {%>
			<% if(pageNum!=i){%>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=review_manager&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=rStatus%>" style="font-size: 16px;">[<%=i %>]</a>
			<%} else {%>
				<span style="font-weight: 900; font-size: 16px;">[<%=i %>]</span>
			<%} %>
		<%} %>
		
		<%if(endPage!=totalPage){ %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=review_manager&pageNum=<%=StartPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=rStatus%>" style="font-size: 16px;">[다음]</a>
		<%} else{ %>
			<span style="color: gray; font-size: 16px;">[다음]</span>
		<%} %>
		
</div>


<%-- 서칭 처리--%>
<div class="review-searching-box">
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=review_manager" method="post" style="display: inline;">
		ID : 
		<input type="text" name="keyword" value="<%=keyword%>" placeholder="아이디를 검색하세요."> 
		<button type="submit" style="font-size:15px;"><img src="shop/search.png" width="15px" height="15px"></button>		
	</form>
</div>




<script type="text/javascript">

$("#category").change(function() { //카테고리 선택시 상태 변경
	$("#productForm").submit();
});
</script>
