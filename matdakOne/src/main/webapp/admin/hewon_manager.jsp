<%@page import="xyz.itwill.util.Pager"%>
<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>   
<%@include file="/security/admin_check.jspf"%>

<%
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	
	//페이징처리 관련 요청페이지번호를 반환받아 저장
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	
	//하나의 페이지에 출력될 이미지의 갯수 설정
	int pageSize = 6;
	
	//검색 관련 정보를 전달받아 review 테이블에 저장된 특정 공지사항의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalreview = HewonDAO.getDAO().selectHewonCount(keyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage = (int)Math.ceil((double)totalreview/pageSize);
	
	//요청페이지번호 검증 - 비정상적인 요청
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	
	//시작행과 종료행을 계산하여 저장
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totalreview){
		endRow=totalreview;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료게시글의 행번호를 전달받아
	//review 테이블에 저장된 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 DAO클래스의 메소드 호출
	List<HewonDTO> HewonList = HewonDAO.getDAO().selectHewonList(startRow, endRow, keyword);
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청페이지에 검색되어 출력될 시작 게시글의 일련번호에 대한 시작값을 계산하여 저장
	int printNum = totalreview-(pageNum-1)*pageSize;
	
	//페이징 처리
	//하나의 페이지 블럭에 출력될 페이지 번호의 갯수 설정
	int blockSize = 5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	int StartPage=(pageNum-1)/blockSize*blockSize+1;
	
	//페이지블럭에 출력될 종료 페이지 번호를 계산하여 저장
	int endPage=StartPage+blockSize-1;
	//마지막페이지 블럭의 종료 페이지 번호 변경
	if(endPage>totalPage){
		endPage=totalPage;
	}
%>
<style type="text/css">

.hewon-searching-box{
	margin-top:20px;
	text-align: center;
}

.hewon-paging-box{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}


h2{
text-align: center;
padding-bottom: 15px;
}
p{
margin-top:30px;
text-align: center;
}
table {
	margin: 0 auto;
	border: 1px solid black;
	border-collapse: collapse;
}
th, td {
	border: 1px solid black;
	padding: 3px;
	text-align: center;
	font-size: 12px;
}
th {
	background-color: #eee;
	color: black;
}
.Hewon_check { width: 80px; }
.Hewon_id { width: 80px; }
.Hewon_name { width: 80px; }
.Hewon_email { width: 140px; }
.Hewon_mobile { width: 140px; }
.Hewon_address { width: 300px; }
.Hewon_join { width: 150px; }
.Hewon_login { width: 150px; }
.Hewon_status { width: 80px; }
</style>

<h2 style="font-weight: 530;">회원목록</h2>
<form name="HewonForm" id="HewonForm">
	<table>
		<tr>
			<th><input type="checkbox" id="allCheck"></th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>상태</th>
		</tr>
		
		<% for(HewonDTO Hewon:HewonList) { %>
		<tr>
			<td class="Hewon_check">
				<% if(Hewon.gethStatus()==9) { %>
					관리자
				<% } else { %>
					<input type="checkbox" name="checkId" value="<%=Hewon.gethId()%>" class="check">
				<% } %>
			</td>
			<td class="Hewon_id"><%=Hewon.gethId() %></td>
			<td class="Hewon_name"><%=Hewon.gethName() %></td>
			<td class="Hewon_email"><%=Hewon.gethEmail() %></td>
			<td class="Hewon_mobile"><%=Hewon.gethPhone() %></td>
			<td class="Hewon_address">
				[<%=Hewon.gethPostcode() %>]<%=Hewon.gethAddr1() %> <%=Hewon.gethAddr2() %>
			</td>
			
			<td class="Hewon_status">
				<select class="status" name="<%=Hewon.gethId()%>">
					<option value="0" <% if(Hewon.gethStatus()==0) { %> selected="selected" <% } %>>탈퇴회원</option>
					<option value="1" <% if(Hewon.gethStatus()==1) { %> selected="selected" <% } %>>일반회원</option>
					<option value="9" <% if(Hewon.gethStatus()==9) { %> selected="selected" <% } %>>관리자</option>
				</select>
			</td>
		</tr>
		<% } %>
	</table>
	<p><button type="button" id="removeBtn">선택회원삭제</button></p>
	<div id="message" style="color: red;"></div>
</form>

<div class="hewon-paging-box">
	<% if(StartPage>blockSize) { %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=hewon_manager&pageNum=<%=StartPage-blockSize%>&keyword=<%=keyword%>">[이전]</a>
	<% } else{ %>
		<span style="color: gray;">[이전]</span>
	<%} %>
	
	<%for(int i=StartPage; i<=endPage; i++) {%>
		<% if(pageNum!=i){%>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=hewon_manager&pageNum=<%=i%>&keyword=<%=keyword%>">[<%=i %>]</a>
		<%} else {%>
			<span style="font-weight: 900">[<%=i %>]</span>
		<%} %>
	<%} %>
	
	<%if(endPage!=totalPage){ %>
		<a href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=review_manager&pageNum=<%=StartPage+blockSize%>&keyword=<%=keyword%>">[다음]</a>
	<%} else{ %>
		<span style="color: gray;">[다음]</span>
	<%} %>
</div>


<%-- 서칭 처리--%>
<div class="hewon-searching-box">
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=hewon_manager" method="post" style="display: inline;">
	ID : 
	<input type="text" name="keyword" value="<%=keyword%>" placeholder="아이디를 검색하세요."> 
	<button type="submit" style="font-size:15px;">검색</button>		
</form>
</div>






<script type="text/javascript">
$("#allCheck").change(function() {
	if($(this).is(":checked")) {
		$(".check").prop("checked",true);
	} else {
		$(".check").prop("checked",false);
	}
});
$("#removeBtn").click(function() {
	if($(".check").filter(":checked").length==0) {
		$("#message").text("선택된 회원이 하나도 없습니다.");
		return;
	}
	
	$("#HewonForm").attr("action", "<%=request.getContextPath()%>/index.jsp?workgroup=admin_action&work=hewon_remove_action");
	$("#HewonForm").attr("method","post");
	
	$("#HewonForm").submit();
});

$(".status").change(function() {
	//이벤트가 발생된 입력태그의 태그 속성값을 반환받아 저장
	// => 회원상태를 변경하고자 하는 회원의 아이디를 제공받아 저장 - 식별자
	var id=$(this).attr("name");
	
	//이벤트가 발생된 입력태그의 입력값을 반환받아 저장
	// => 변경할 회원상태를 제공받아 저장 - 변경값
	var status=$(this).val();
	
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin_action&work=hewon_status_action&id="+id+"&status="+status;
});
</script>