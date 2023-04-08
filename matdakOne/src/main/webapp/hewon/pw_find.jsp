<%@page import="com.matdak.entity.Hewon"%>
<%@page import="com.matdak.dao.HewonDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(request.getParameter("hId")==null) {
		response.sendError(HttpServletResponse.SC_BAD_REQUEST);
		return;
	}

	String hId=request.getParameter("hId");
	Hewon hewon=HewonDAO.getDAO().selectHewonByhId(hId);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JSP</title>
<style type="text/css">
div {
	text-align: center;
	margin: 10px;
}
.id {
	font-weight: bold;
	color: red;
}
</style>
</head>
<body>

<% if(hewon==null) { %>
	<div>입력된 <span class="id">[<%=hId %>]</span>는 사용 가능한 아이디입니다.</div>
	<div>
		<button type="button" onclick="selectId();">아이디 사용</button>
	</div>
	
	<script type="text/javascript">
	function selectId() {
		opener.join.id.value="<%=hId%>";
		opener.join.idCheckResult.value="1";
		window.close();
	}
	</script>
	
<% } else { %>
	<div>입력된 <span class="id">[<%=hId %>]</span>는 이미 사용중인 아이디입니다.
	<br>다른 아이디를 입력하고 [확인] 버튼을 눌러주세요.</div>
	
	<div>
	<form name="checkForm">
		<input type="text" name="id">
		<button type="button" onclick="idCheck();">확인</button>
	</form>
	</div>
	<div id="message" style="color: red;"></div>
	
	<script type="text/javascript">
	function idCheck() {
		var id=checkForm.id.value;
		if(id=="") {
			document.getElementById("message").innerHTML="아이디를 입력해 주세요.";
			return;
		}
		
		var idReg=/^[a-zA-Z]\w{5,19}$/g;
		if(!idReg.test(id)) {
			document.getElementById("message").innerHTML="아이디를 형식에 맞게 입력해 주세요.";
			return;
		}
		
		checkForm.submit();
	}
	</script>
<% } %>
</body>
</html>