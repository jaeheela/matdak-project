<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@include file="/security/login_check.jspf" %>

<%-- 새글 : board_list.jsp 문서에 의해 요청한 경우 - 전달값 : X --%>
<%-- 답글 : board_detail.jsp 문서에 의해 요청한 경우 - 전달값 : O --%>
<%-- => 부모글 관련 정보(ref,reStep,reLevel,pageNum) 전달  --%>
<%

	//전달값이 없는 경우(새글인 경우) 초기값 저장
	String mRef="0", mRestep="0", mRelevel="0", pageNum="1";
	//전달값이 있는 경우(답글인 경우)
	if(request.getParameter("mRef")!=null){ 
		mRef = request.getParameter("mRef");
		mRestep = request.getParameter("mRestep");
		mRelevel = request.getParameter("mRelevel");
		pageNum = request.getParameter("pageNum");
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
<%--새글인경우 --%>
<% if(mRef.equals("0")){ %>
	<h2>새글쓰기</h2>
<%--답글인 경우 --%> 
<% } else { %>
	<h2>답글쓰기</h2>
<% } %>


<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=moon_write_action" 
	method="post" id="boardForm">
	
	<input type="hidden" name="mRef" value="<%=mRef%>">
	<input type="hidden" name="mRestep" value="<%=mRestep%>">
	<input type="hidden" name="mRelevel" value="<%=mRelevel%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">

	<table>
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="mTitle" id="mTitle" size="40">
				<input type="checkbox" name="mStatus" value="2">비밀글
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea  rows="7" cols="60" name="mContent" id="mContent"></textarea>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글저장</button>
				<button type="reset" id="resetBtn">다시쓰기</button>				
			</th>
		</tr>
	</table>

</form>
<div id="message" style="color:red;"></div>
<script type="text/javascript">
$("#subject").focus();

$("#boardForm").submit(function() {
	if($("#subject").val()=="") {
		$("#message").text("제목을 입력해 주세요.");
		$("#subject").focus();
		return false;
	}
	
	if($("#board_content").val()=="") {
		$("#message").text("내용을 입력해 주세요.");
		$("#content").focus();
		return false;
	}
});

$("#resetBtn").click(function() {
	$("#subject").focus();
	$("#message").text("");
});
</script>