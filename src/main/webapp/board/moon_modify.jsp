<%@page import="xyz.itwill.dao.MoonDAO"%>
<%@page import="xyz.itwill.dto.MoonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>
<%

	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("mCode")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장
	int mCode = Integer.parseInt(request.getParameter("mCode"));
	String pageNum = request.getParameter("pageNum");
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");

	MoonDTO moon = MoonDAO.getDAO().selectMoon(mCode);
	
	if(moon==null || moon.getmStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	

	if(!loginHewon.gethId().equals(moon.getmId()) && loginHewon.gethStatus()!=9){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
%>
<style type="text/css">
table{
	margin: 0 auto;
}
th {
	width: 70px;
	font-weight: normal;
}
td {
	text-align: left;
}
</style>
<h2>글변경</h2>
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon_modify_action" 
	method="post" id="moonForm">
	<input type="hidden" name="mCode" value="<%=mCode%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="mTitle" id="mTitle" size="40" value="<%=moon.getmTitle()%>">
				<input type="checkbox" name="mStatus" value="2" <%if(moon.getmStatus()==2){ %> checked="checked" <%} %>>비밀글
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea  rows="7" cols="60" name="mContent" id="mContent"><%=moon.getmContent()%></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글변경</button>
				<button type="reset" id="resetBtn">다시쓰기</button>				
			</th>
		</tr>
	</table>
</form>
<div id="message" style="color:red;"></div>
<script type="text/javascript">
$("#mTitle").focus();
$("#moonForm").submit(function() {
	if($("#mTitle").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#mTitle").focus();
		return false;
	}
	
	if($("#mContent").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#mContent").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#mTitle").focus();
	$("#message").text("");
});
</script>