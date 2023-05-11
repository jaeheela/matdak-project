<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("utf-8");

String workgroup = request.getParameter("workgroup");
if (workgroup == null) workgroup = "main";

String work = request.getParameter("work");
if (work == null) work = "main_page";

String headerPath = "header.jsp";
if (workgroup.equals("admin")) headerPath = "admin/header.jsp";

String contentPath = workgroup + "/" + work + ".jsp";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>MATDAK</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/resources/js/jquery.menu.js"></script>

<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/csshome/reset.css" type="text/css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/resources/csshome/common.css" type="text/css">
</head>
<body>
	<div class="header-box">
		<jsp:include page="<%=headerPath%>" />
	</div>

	<div class="content-box">
		<jsp:include page="<%=contentPath%>" />
	</div>

	<div class="footer-box">
		<jsp:include page="footer.jsp" />
	</div>

</body>
</html>