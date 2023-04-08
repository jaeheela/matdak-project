<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.matdak.dto.HewonDTO"%>
<%@page import="com.matdak.dto.MoonDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.matdak.dao.MoonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String search=request.getParameter("search");
	if(search==null){
		search="";
	}	
	String keyword=request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}	
	
	int pageNum=1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}

	int pageSize = 15;
	int totalMoon = MoonDAO.getDAO().selectMoonCount(search, keyword);
	int totalPage = (int)Math.ceil((double)totalMoon/pageSize);	
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1; 
	}
	int startRow=(pageNum-1)*pageSize+1;
	int endRow=pageNum*pageSize;
	if(endRow>totalMoon){
		endRow=totalMoon;
	}

	List<MoonDTO> moonList = MoonDAO.getDAO().selectMoonList(startRow, endRow, search, keyword);
	HewonDTO loginHewon = (HewonDTO) session.getAttribute("loginHewon");
	
	//서버 시스템에 현재 날짜를 반환받아 저장
	//=> 게시글의 작성날짜를 현재날짜와 비교하여 구분출력하기 위해 필요
	//=> ex. [오늘작성날짜]: 시간만 출력, [과거작성날짜]: 날짜 + 시간 출력
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	int printNum = totalMoon-(pageNum-1)*pageSize ;
%>
<style type="text/css">
.customer-head-title {
	text-align: center;
}

.customer-head-title .customer-sub-title {
	padding: 40px;
	border-bottom: 1px solid #ccc;
}

.customer-head-title .customer-sub-content {
	padding: 20px 10px;
	border-bottom: 1px solid #ccc;
}
.moon-paging-box{
	width: 100%;
	margin: 20px auto;
	text-align: center;
}
#searchForm{
	display: flex;
	justify-content: center;
	width: 100%;
	margin: 20px auto;
	
}
table {
	margin: 10px auto;
	border-collapse: collapse;
}

tr {
	border-bottom: 1px solid black;
}

td {
	text-align: center;
	padding: 10px;
}
td.review-title{
	text-align: left;
}
.subject {
	text-align: left;
	padding: 5px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

#board_list a:hover {
	text-decoration: none;
	color: red;
	font-weight: bold;
}

.secret, .remove {
	background-color: black;
	color: white;
	font-size: 14px;
	border: 1px solid black;
	border-radius: 4px;
}

</style>
<!-- 문의사항 title -->
	<div class="customer-head-title">
		<div class="customer-sub-title">문의사항 <span style="color: red;">(<%=totalMoon%>)</span></div>
		<div class="customer-sub-content">
		<p style="text-align: left; line-height: 1.5em; font-size:0.7rem;">
		· 상품문의에서는 상품과 무관한 요청은 처리되지 않습니다.<br>
	    · 미구매,비방이나 양도 광고성, 욕설, 도배글, 개인정보가 포함된 글은 예고없이 삭제되거나 노출이 제한될 수 있습니다.</p>
		</div>
	</div>
	
<%--로그인 사용자가 문의사항을 요청한 경우 --%>	
<%
	if(loginHewon!=null){
	%>
<div style="text-align: right;">
	<button type="button" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon_write'">글쓰기</button>
</div>
<%
}
%>

<%--페이징 처리 --%>
<%
int blockSize=5;
	int startPage=(pageNum-1)/blockSize*blockSize+1;
	int endPage=startPage+blockSize-1;
	if(endPage>totalPage)endPage=totalPage;
%>
<%-- 페이징 처리--%>
<div class="moon-paging-box">
<%
if(startPage>blockSize) {
%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon&pageNum=<%=startPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
<%
} else{
%>
	<span style="color: gray;">[이전]</span>
<%
}
%>

<%
for(int i=startPage; i<=endPage; i++) {
%>
	<%
	if(pageNum!=i){
	%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i%>]</a>
	<%
	} else {
	%>
		<span style="font-weight: 900">[<%=i%>]</span>
	<%
	}
	%>
<%
}
%>

<%
if(endPage!=totalPage){
%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon&pageNum=<%=startPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
<%
} else{
%>
	<span style="color: gray;">[다음]</span>
<%
}
%>
</div>

<%--서칭처리 --%>
<form id="searchForm" action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon" method="post">
	<select name="search">
		<option value="h_name" <%if(search.equals("h_name")){%> selected="selected" <%}%>>&nbsp;작성자&nbsp;</option>
		<option value="m_title" <%if(search.equals("m_title")){%> selected="selected" <%}%>>&nbsp;제목&nbsp;</option>
		<option value="m_content" <%if(search.equals("m_content")){%> selected="selected" <%}%>>&nbsp;내용&nbsp;</option>
	</select>		
	<input type="text" name="keyword" value="<%=keyword%>" placeholder="문의사항을 검색하세요.">
	<button type="submit">검색</button>
</form>


<%--문의사항 목록 출력 --%>
<table>
	<tr>
		<th width="100">번호</th>
		<th width="500">제목</th>
		<th width="100">작성자</th>
		<th width="100">조회수</th>
		<th width="200">작성일</th>
	</tr>
	
	
	<%-- 검색된 문의사항이 없을 경우 --%>
	<%
	if(totalMoon==0){
	%> 
	<tr>
		<td colspan="5">검색된 문의사항이 없습니다.</td>
	</tr>
	
	<%-- 검색된 문의사항이 있을 경우 --%>
	<%
	} else {
	%>
	<%
	for(MoonDTO moon:moonList) {
	%> 
		<tr>
			<%--1. 일련번호 출력 --%>
			<td><%=printNum %></td>
				<% printNum--;%> 
			<%--2. 제목 출력 --%>
			<td class="review-title">
				<%--게시글이 답글인 경우 --%>
				<%if(moon.getmRestep()!=0) {%>
				<span style="margin-left: <%=moon.getmRelevel()*20%>px">└[답글]</span>
				<%} %>
				
				<%--게시글이 일반글인 경우 --%>
				<%if(moon.getmStatus()==1) {%>
				<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon_detail&mCode=<%=moon.getmCode()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
                 	<%=moon.getmTitle() %>
                </a>
				<%}%>
				
                <%--게시글이 비밀글인 경우 --%>
				<%if (moon.getmStatus()==2) {%>
				<span class="secret">비밀글</span> 
					<%if(loginHewon!=null && (loginHewon.gethId().equals(moon.getmId())|| loginHewon.gethStatus()==9)){ %>
						<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon_detail&mCode=<%=moon.getmCode()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">
		                 	<%=moon.getmTitle() %>
		                </a>
					<%}else { %>
						<br><span style="color: red; font-size: 0.7em;">작성자 또는 관리자만 확인 가능합니다.</span>
					<%} %>
				<%} %>
				
				
				<%--게시글이 삭제글인 경우 --%>
				<%if (moon.getmStatus()==0) {%>
					<span class="remove">삭제글</span>
					작성자 또는 관리자에 의해 삭제된 게시글입니다.
				<%} %>
			</td>
						
			<%--3. 작성자,조회수,날짜 출력 --%>
			<%if(moon.getmStatus()!=0) {%>
				<td><%=moon.getmWriter() %></td>			
				<td><%=moon.getmLook() %></td>
				<td>
				<%if(currentDate.equals(moon.getmDate().subSequence(0, 10)) ) { //오늘%>
					<%=moon.getmDate().substring(11) %>
				<%} else{ //오늘아님%>
					<%=moon.getmDate() %>
				<%} %>
				</td>
			<%} else {%>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			<%} %>
		</tr>		
	<%} %>
<%} %>
</table>