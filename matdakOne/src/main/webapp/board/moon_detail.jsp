<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="xyz.itwill.dao.MoonDAO"%>
<%@page import="xyz.itwill.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("mCode")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}



	int mCode = Integer.parseInt(request.getParameter("mCode"));
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	
	MoonDTO moon = MoonDAO.getDAO().selectMoon(mCode);
	HewonDTO loginHewon = (HewonDTO)session.getAttribute("loginHewon");
	
	if(moon==null || moon.getmStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	if(moon.getmStatus()==2){
		if(loginHewon==null || !loginHewon.gethId().equals(moon.getmId()) && loginHewon.gethStatus()!=9){
			out.println("<script type='text/javascript'>");
			out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
			out.println("</script>");
			return;
		}
	}
	
	MoonDAO.getDAO().updatemLook(mCode);
%>    
<style type="text/css">
#moon_detail {
	width: 500px;
	margin: 0 auto;
}
table {
	border: 1px solid black;
	border-collapse: collapse;
}
th, td {
	border: 1px solid black;
	padding: 5px;
}
th {
	width: 100px;
}

td {
	width: 400px;
}
.mTitle, .mContent {
	text-align: left;
}
.mContent {
	height: 200px;
	vertical-align: middle;
}
#moon_menu {
	text-align: right;
	margin: 5px;
}
</style>
<div id="moon_detail">
	<h2 style="width:100%;  text-align: center; font-size: 1.7em; margin: 0.5em;">문의사항</h2>
	<table>
		<tr>
			<th>작성자</th>
			<td><%=moon.getmWriter() %> | <%=moon.getmId() %> 
			<%if(loginHewon!=null && loginHewon.gethStatus()==9){//관리자인 경우 %>
			[<%=moon.getmIp() %>] <%} %>
			</td>
		</tr>
		<tr>
			<th>작성일</th>
			<td><%=moon.getmDate() %></td>
		</tr>
		<tr>
			<th>조회수</th>
			<td><%=moon.getmLook() + 1 %></td>
		</tr>
		<tr>
			<th>제목</th>
			<td class="mTitle">
				<% if(moon.getmStatus()==2){%> 
				[비밀글] 
				<%} %> 
				<%=moon.getmTitle()%>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td class="mContent">
				<%=moon.getmContent().replace("\n", "<br>")%>
			</td>
		</tr>
	</table>
</div>

<div id="moon_menu">
	<%if(loginHewon!=null && (loginHewon.gethId().equals(moon.getmId()) || loginHewon.gethStatus()!=9)){%>
	<button type="button" id="modifyBtn">글변경</button>
	<button type="button" id="removeBtn">글삭제</button>
	<%} %>

	<%if(loginHewon!=null){%>
	<button type="button" id="replyBtn">답글쓰기</button>
	<%} %>

	<button type="button" id="listBtn">글목록</button>
</div>	


<%-- 요청 페이지에 값을 전달하기 위한 form 태그 --%>
<form action="<%=request.getContextPath()%>/index.jsp" method="get" id="menuForm">
	<input type="hidden" name="workgroup" value="board">
	<input type="hidden" name="work" id="work">

<%-- [글변경] 및 [글삭제]를 클릭한 경우 전달되는 값 --%>
	<input type="hidden" name="mCode" value="<%=moon.getmCode()%>">
	
<%-- [글변경] 및 [글목록]를 클릭한 경우 전달되는 값 --%>
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	
<%-- [답글쓰기]를 클릭한 경우 전달되는 값 --%>
	<input type="hidden" name="mRef" value="<%=moon.getmRef()%>">
	<input type="hidden" name="mRestep" value="<%=moon.getmRestep()%>">
	<input type="hidden" name="mRelevel" value="<%=moon.getmRelevel()%>">
</form>
	
	
<script type="text/javascript">
$("#modifyBtn").click(function() {
	$("#work").val("moon_modify");
	$("#menuForm").submit();
});

$("#removeBtn").click(function() {
	if(confirm("게시글을 삭제 하시겠습니까?")) {
		$("#work").val("moon_delete_action");
		$("#menuForm").submit();
	}
});

$("#replyBtn").click(function() {
	$("#work").val("moon_write");
	$("#menuForm").submit();
});

$("#listBtn").click(function() {
	$("#work").val("moon");
	$("#menuForm").submit();
});
</script>	