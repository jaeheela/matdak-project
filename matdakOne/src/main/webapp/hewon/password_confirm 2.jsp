<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>   
<style type="text/css">
#content{
margin-top: 400px;
margin-left:400px;
}
</style>

<%
	String action=request.getParameter("action");
	String message=(String)session.getAttribute("message");
	
	if(action==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}	
	if(!action.equals("modify") && !action.equals("remove")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	if(message==null) message="";
	else session.removeAttribute("message");
	
%>

<% if(action.equals("modify")) { %>
	<p>회원정보변경을 위해 비밀번호를 입력해 주세요.</p>
<% } else { %>	
	<p>회원탈퇴를 위해 비밀번호를 입력해 주세요.</p>
<% } %>

<form method="post" name="passwordForm">
	<input type="password" name="pw">
	<button type="button" onclick="submitCheck();">입력완료</button>
</form>
<p id="message" style="color: red;"><%=message %></p>

<script type="text/javascript">
passwordForm.pw.focus();
function submitCheck() {
	if(passwordForm.pw.value=="") {
		document.getElementById("message").innerHTML="비밀번호를 반드시 입력해 주세요.";
		passwordForm.pw.focus();
		return;
	}
	
	<% if(action.equals("modify")) { %>
		passwordForm.action="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=hewon_modify";
	<% } else { %>
		passwordForm.action="<%=request.getContextPath()%>/index.jsp?workgroup=hewon_action&work=hewon_remove_action";
	<% } %>
	
	passwordForm.submit();
}
</script>