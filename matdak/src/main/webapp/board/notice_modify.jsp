<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 공지사항 번호를 전달받아 BOARD 테이블에 저장된 해당 번호의 게시글을 검색하여
입력태그의 초기값으로 설정하고 사용자로부터 변경값을 입력받기 위한 JSP 문서 --%>    
<%-- => [글변경]을 클릭한 경우 notice_modify_action.jsp로 이동 - 입력값 전달 --%>

<%-- => 로그인 사용자 중 관리자만 요청 가능한 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리 - 공지사항 번호 없는 경우
	if(request.getParameter("nCode")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int nCode = Integer.parseInt(request.getParameter("nCode"));
	
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	String pageNum = request.getParameter("pageNum");
	//System.out.println("3.search= "+search);
	//System.out.println("keyword= "+keyword);
	//System.out.println("pageNum= "+pageNum);
	//System.out.println("=======");
	
	//글번호(nCode)를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 공지사항 글을 
	//검색하는 DAO 클래스의 메소드 호출
	NoticeDTO notice = NoticeDAO.getDAO().selectNotice(nCode);
	
	//검색된 게시글이 없거나 삭제게시글인 경우 에러페이지로 이동되도록 응답 처리
	if(notice==null || notice.getnStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}	
%>
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
<h2 style="margin:10px; font-size: 20px">공지사항 수정</h2>
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_modify_action" 
	method="post" id="noticeModifyForm" enctype="multipart/form-data">
	<%-- 변경할 공지사항 이미지를 구분하기 위한 식별자로 공지사항번호 전달 --%>
	<input type="hidden" name="nCode" value="<%=nCode%>">
	<%-- 제품 관련 이미지를 변경하지 않을 경우 기존 제품 관련 이미지를 사용하기 위해 전달 혹은 --%>
	<%-- 제품 관련 이미지를 변경할 경우 기존 제품 관련 이미지를 서버 디렉토리에서 삭제하기 위해 전달--%>
	<input type="hidden" name="currentImage" value="<%=notice.getnImage()%>">
	<input type="hidden" name="search" value="<%=search%>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
	<table>	
		<tr>
			<th>제목</th>
			<td>
				<div style="margin: 10px; ">
				<input type="text" name="nTitle" id="nTitle" size="40" value="<%=notice.getnTitle()%>">
				<div id="titleMsg" class="error">제목을 입력해 주세요.</div>
				</div>
			</td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td>
				<div style="margin: 10px; ">
				<div style="font-size:16px;">현재 사용하고 있는 파일명 : <%=notice.getnImage() %></div>
				<input type="file" name="nImage" id="nImage">
				<div style="color:red; font-size:15px;">파일을 변경하지 않을 경우 입력하지 마세요.</div>
				</div>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<div style="margin: 10px; ">
				<textarea  rows="7" cols="60" name="nContent" id="nContent"><%=notice.getnContent() %></textarea>
				<div id="contentMsg" class="error">내용을 입력해 주세요.</div>
				</div>
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

$("#noticeModifyForm").submit(function() {
	
	$(".error").css("display","none");	
	var result = true;
	
	if($("#nTitle").val()=="") {
		$("#titleMsg").css("display","block");
		$("#nTitle").focus();
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
