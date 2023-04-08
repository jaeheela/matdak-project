<%@page import="xyz.itwill.dao.JumunDAO"%>
<%@page import="xyz.itwill.dto.JumunDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation"%>
<%@page import="java.text.ParseException"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/admin_check.jspf" %>
<%
	String search = request.getParameter("search");
	if(search==null){
		search="";
	}
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	int pageSize = 6;
	
	int totaljumun = JumunDAO.getDAO().selectJumunCount(search,keyword);
	
	int totalPage = (int)Math.ceil((double)totaljumun/pageSize);
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totaljumun){
		endRow=totaljumun;
	}
	
	List<JumunDTO> jumunList= JumunDAO.getDAO().selectJumunList(startRow, endRow, search, keyword);
	
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	int printNum = totaljumun-(pageNum-1)*pageSize;
	int blockSize = 5;
	int StartPage=(pageNum-1)/blockSize*blockSize+1;
	int endPage=StartPage+blockSize-1;
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

.notice-searching-box{
	margin-top:20px;
	text-align: center;
}


.pname {
	width: 600px;
}


.jumun-paging-box{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}

#order {
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
</style>
<div id="order">
	<h2>주문 목록</h2>
	

	
	<table>
		<tr>
			<th>주문 번호</th>
			<th>ID</th>
			<th class="rName">주문자 이름</th>
			<th>주문 금액</th>
			<th>주문 일자</th>
		</tr>
		
		<% if(jumunList.isEmpty()) { %>
		<tr>
			<td colspan="4">검색된 주문이 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(JumunDTO jumun:jumunList) { %>
			<tr>
				<td><%=jumun.getjNo()%></td>
				<td><%=jumun.getjId()%></td>
				<td><%=jumun.getjJname()%>	 </td>
				<td><%=DecimalFormat.getInstance().format(jumun.getjTp())%><span style="font-size: 16px;">원</span></td>	
				<td><%=jumun.getjDate() %></td>	
			</tr>
			<% } %>
		<% } %>
	</table>
	
	<br>

</div>

<div class="jumun-paging-box">

		<% if(StartPage>blockSize) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=jumun_manager&pageNum=<%=StartPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>" style="font-size: 16px;">[이전]</a>
		<% } else{ %>
			<span style="color: gray; font-size: 16px;">[이전]</span>
		<%} %>
		
		<%for(int i=StartPage; i<=endPage; i++) {%>
			<% if(pageNum!=i){%>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=order_manager&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>" style="font-size: 16px;">[<%=i %>]</a>
			<%} else {%>
				<span style="font-weight: 900; font-size: 16px;">[<%=i %>]</span>
			<%} %>
		<%} %>
		
		<%if(endPage!=totalPage){ %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=order_manager&pageNum=<%=StartPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>" style="font-size: 16px;">[다음]</a>
		<%} else{ %>
			<span style="color: gray; font-size: 16px;">[다음]</span>
		<%} %>
		
</div>

<%-- 서칭 처리--%>
<div class="notice-searching-box">
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=order_manager" method="post" style="display: inline;">
	ID : 
	<input type="text" name="keyword" value="<%=keyword%>" placeholder="아이디를 검색하세요."> 
	<button type="submit" style="font-size:15px;"><img src="shop/search.png" width="15px" height="15px"></button>		
</form>
</div>


<script type="text/javascript">
$("#category").change(function() { //카테고리 선택시 상태 변경
	$("#orderForm").submit();
});
</script>
