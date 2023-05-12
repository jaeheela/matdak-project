<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 회원정보변경 또는 회원탈퇴를 위한 비밀번호를 입력받기 위한 JSP 문서  --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [입력완료]를 클릭한 경우 전달값에 의한 페이지 이동 - 입력값 전달 --%>
<%@include file="/security/login_check.jspf" %>   
<style type="text/css">
#content{
margin-top: 400px;
margin-left:400px;
}


</style>

<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("action")==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	//전달값을 반환받아 저장
	String action=request.getParameter("action");
	
	//비정상적인 요청에 대한 응답 처리
	if(!action.equals("modify") && !action.equals("remove")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
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
	
	<%-- 전달값에 의해 form 태그로 요청하는 JSP 문서(action 속성값)를 다르게 설정 --%>
	<% if(action.equals("modify")) {//[회원정보변경]인 경우 %>
		passwordForm.action="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=hewon_modify";
	<% } else {//[회원탈퇴]인 경우 %>
		passwordForm.action="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=hewon_remove_action";
	<% } %>
	
	passwordForm.submit();
}
</script>