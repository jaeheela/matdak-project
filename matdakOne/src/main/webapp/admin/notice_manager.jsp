<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="org.eclipse.jdt.internal.compiler.parser.ParserBasicInformation"%>
<%@page import="java.text.ParseException"%>
<%@page import="xyz.itwill.dao.AdminDAO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- <%@include file="/security/admin_check.jspf" %> --%>
<%
	String category=request.getParameter("category");
	if(category==null) {
		category="10";
	}
	int nStatus=Integer.parseInt(category);

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
	int totalNotice = NoticeDAO.getDAO().selectNoticeCount(search, keyword,nStatus);
	int totalPage = (int)Math.ceil((double)totalNotice/pageSize);
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totalNotice){
		endRow=totalNotice;
	}
	
	List<NoticeDTO> noticeList = NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword,nStatus);
	
	
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	int printNum = totalNotice-(pageNum-1)*pageSize;
	int blockSize = 5;
	int StartPage=(pageNum-1)/blockSize*blockSize+1;
	int endPage=StartPage+blockSize-1;
	if(endPage>totalPage){
		endPage=totalPage;
	}
%>


<style type="text/css">

.notice-searching-box{
	margin-top:20px;
	text-align: center;
}


.pname {
	width: 600px;
}


.notice-paging-box{
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
	border: 1px solid black;
	border-collapse: collapse;
}
th, td {
	border: 1px solid black;
	text-align: center;
	width: 200px;	
}
th {
	background-color: black;
	color: white;
}

td a, td a:hover {
	text-decoration: underline;
	color: blue;
}
</style>
<div id="product">
	<h2>공지사항 목록</h2>
	
	<div id="btn">
		<button type="button" id="addBtn">공지사항 등록</button>
	</div>
	
	<table>
		<tr>
			<th>공지사항 번호</th>
			<th>ID</th>
			<th class="nName">공지사항 제목</th>
			<th>공지사항 상태<br>(1:일반,0:삭제)</th>
			<th>공지사항 작성일</th>
		</tr>
		
		<% if(noticeList.isEmpty()) { %>
		<tr>
			<td colspan="4">검색된 공지사항이 없습니다.</td>
		</tr>
		<% } else { %>
			<% for(NoticeDTO notice:noticeList) { %>
			<tr>
				<td><%=notice.getnCode()%></td>
				<td><%=notice.getnId()%></td>
				<td>	<a href="<%=request.getContextPath() %>/index.jsp?workgroup=board&work=notice_detail&nCode=<%=notice.getnCode()%>">
				<%=notice.getnTitle()%>	</a> </td>
				<td><%=notice.getnStatus() %></td>	
				<td><%=notice.getnDate() %></td>	
			</tr>
			<% } %>
		<% } %>
	</table>
	
	<br>
	<form action="<%=request.getContextPath() %>/index.jsp?workgroup=admin&work=notice_manager" 
		method="post" id="productForm">
		<select  name="category" id="category">
			<option value="10" <% if(category.equals("10")){ %> selected="selected" <% } %>>
				전체(ALL)
			</option>
			<option value="1" <% if(category.equals("1")) { %> selected="selected" <% } %>>
				일반(1)
			</option>
			<option value="0" <% if(category.equals("0")) { %> selected="selected" <% } %>>
				삭제(0)
			</option>

		</select>	
	</form>
</div>



<div class="notice-paging-box">

		<% if(StartPage>blockSize) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=notice_manager&pageNum=<%=StartPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=nStatus%>">[이전]</a>
		<% } else{ %>
			<span style="color: gray;">[이전]</span>
		<%} %>
		
		<%for(int i=StartPage; i<=endPage; i++) {%>
			<% if(pageNum!=i){%>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=notice_manager&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=nStatus%>">[<%=i %>]</a>
			<%} else {%>
				<span style="font-weight: 900">[<%=i %>]</span>
			<%} %>
		<%} %>
		
		<%if(endPage!=totalPage){ %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=notice_manager&pageNum=<%=StartPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>&category=<%=nStatus%>">[다음]</a>
		<%} else{ %>
			<span style="color: gray;">[다음]</span>
		<%} %>
		
</div>

<%-- 서칭 처리--%>
	<div class="notice-searching-box">
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=notice_manager" method="post" style="display: inline;">
		ID : 
		<input type="text" name="keyword" value="<%=keyword%>" placeholder="아이디를 검색하세요."> 
		<button type="submit" style="font-size:15px;">검색</button>		
	</form>
	</div>


<script type="text/javascript">
$("#addBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_write";
});
$("#category").change(function() { //카테고리 선택시 상태 변경
	$("#productForm").submit();
});
</script>
