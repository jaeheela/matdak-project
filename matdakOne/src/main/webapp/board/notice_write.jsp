<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 관리자로부터 공지사항 글을 입력받기 위한 JSP 문서 --%>    
<%-- => [글저장]을 클릭한 경우 게시글 삽입페이지(notice_write_action.jsp)로 이동 - 입력값 전달 --%>
<%-- => 관리자만 요청 가능한 문서 --%>
<%@include file="/security/admin_check.jspf" %>

<style type="text/css">
div.content-box{
	margin: 0 auto;
	text-align: center;
}

.content-box table{
	margin: 10px auto 0;
}
.content-box th {
	width: 100px;
	font-weight: 400;
	text-align: center;
}
td {
	text-align: left;
	
}
input, textarea{
	font-size: 16px;
}

.error{
	font-size: 15px;
	font-weight: 900;
	color: red;
	display: none;
}
</style>
<div class="content-box">
<h2 style="margin:10px; font-size: 20px">공지사항 작성</h2>
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_write_action" 
	method="post" id="noticeForm" enctype="multipart/form-data">
	<table>	
		<tr>
			<th>제목</th>
			<td>
				<input type="text" name="nTitle" id="nTitle" size="40">
				<div id="titleMsg" class="error">제목을 입력해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td>
				<input type="file" name="nImage" id="nImage">
				<div id="imageMsg" class="error">파일을 첨부해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea  rows="7" cols="60" name="nContent" id="nContent"></textarea>
				<div id="contentMsg" class="error">내용을 입력해 주세요.</div>
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
</div>
<script type="text/javascript">
$("#nTitle").focus();

$("#noticeForm").submit(function() {
	
	$(".error").css("display","none");	
	var result = true;
	
	if($("#nTitle").val()=="") {
		$("#titleMsg").css("display","block");
		$("#nTitle").focus();
		result=false;
	}
	
	if($("#nImage").val()=="") {
		$("#imageMsg").css("display","block");
		$("#nImage").focus();
		result=false;
	}
	
	if($("#nContent").val()=="") {
		$("#contentMsg").css("display","block");
		$("#nContent").focus();
		result=false;
	}
	return result;
});

$("#resetBtn").click(function() {
	$("#nTitle").focus();
	$("#titleMsg").text("");
	$("#imageMsg").text("");
	$("#contentMsg").text("");
});

</script>
