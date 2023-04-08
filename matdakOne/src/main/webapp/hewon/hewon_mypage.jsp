<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_check.jspf" %>    
<style type="text/css">
#detail p{
	text-align: center;
}
#detail {
	width: 500px;
	margin: 0 auto;
	text-align: left;
}
#detail li{
	margin-top : 50px;
	list-style-type: circle;
	font-size: 1.3em;
}
#link {
	margin-top: 100px;
	text-align: center;
}
#link a:hover {
	color: orange;
}
</style>
<div id="detail">
	<p>내 정보<p>
	<ul>
		<li>아이디 = <%=loginHewon.gethId() %></li>
		<li>이름 = <%=loginHewon.gethName() %></li>
		<li>이메일 = <%=loginHewon.gethEmail() %></li>
		<li>전화번호 = <%=loginHewon.gethPhone() %></li>
		<% String[] addr=loginHewon.gethAddr().split("%%%%%"); %>
		<li>주소 = [<%=loginHewon.gethPostcode() %>]<%=addr[0] %> - <%=addr[1] %></li>
	</ul>
</div>

<div id="link">
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=remove">[회원탈퇴]</a>&nbsp;&nbsp;
</div>