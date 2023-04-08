<%@page import="com.matdak.dao.HewonDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- Hewon 테이블에 저장된 모든 회원정보를 검색하여 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- => [선택회원삭제]를 클릭한 경우 회원정보 삭제페이지(Hewon_remove_action.jsp)로 이동 - 체크박스로 선택된 모든 회원의 아이디 전달  --%>
<%-- => 회원정보에서 [상태]를 변경한 경우 회원상태 변경페이지(Hewon_status_action.jsp)로 이동 - 아이디와 회원상태 전달 --%>    
<%@include file="/security/admin_check.jspf" %>   
<%
   //Hewon 테이블에 저장된 모든 회원정보를 검색하여 반환하는 DAO 클래스의 메소드 호출
      	List<HewonDTO> HewonList=HewonDAO.getDAO().selectHewonList();
   %>
<style type="text/css">
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
	background-color: black;
	color: white;
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

<h2>회원목록</h2>
<form name="HewonForm" id="HewonForm">
	<table>
		<tr>
			<th><input type="checkbox" id="allCheck"></th>
			<th>아이디</th>
			<th>이름</th>
			<th>이메일</th>
			<th>전화번호</th>
			<th>주소</th>
			<th>가입날짜</th>
			<th>최종로그인</th>
			<th>상태</th>
		</tr>
		
		<%
				for(HewonDTO Hewon:HewonList) {
				%>
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
	
	$("#HewonForm").attr("action", "<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=hewon_remove_action");
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
	
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=admin&work=hewon_status_action&id="+id+"&status="+status;
});
</script>