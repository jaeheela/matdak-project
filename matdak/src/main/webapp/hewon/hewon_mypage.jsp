<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인 사용자의 정보를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [회원정보변경]을 클릭한 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동 - 페이지 이동 관련 정보 전달 --%>
<%-- => [회원탈퇴]를 클릭한 경우 비밀번호 입력페이지(password_confirm.jsp)로 이동 - 페이지 이동 관련 정보 전달 --%>
<%--
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	MemberDTO loginHewon=(MemberDTO)session.getAttribute("loginHewon");
	//비로그인 사용자가 JSP 문서를 요청한 경우 - 비정상적인 요청에 대한 응답 처리
	if(loginHewon==null) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
--%>
<%-- 권한 관련 중복코드를 JSPF 파일로 작성하여 include 디렉티브를 이용하여 포함하여 사용 --%>
<%-- => 코드의 중복을 최소화 하여 생산성을 높이고 유지보수의 효율성 증가 --%>
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
	<li>주소 = [<%=loginHewon.gethPostcode() %>]<%=loginHewon.gethAddr1() %> <%=loginHewon.gethAddr2() %></li>
	</ul>
</div>

<div id="link">
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=remove">[회원탈퇴]</a>&nbsp;&nbsp;
</div>