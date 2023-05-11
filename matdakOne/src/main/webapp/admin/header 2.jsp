<%@page import="com.matdak.dto.HewonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style type="text/css">
.header-box .header-login-join ul{
    display: flex;
    flex-direction: row;
    position: absolute;
    top:20px;
    right: 5px;
}
.header-box .header-login-join ul li{
    display: inline;
    margin-top: 5px;
}    

.header-box .header-logo{
    margin: 20px;
}   

.header-box .header-logo img{
    display: block;
    margin-left: auto;
    margin-right: auto;
}  

.header-box .header-menubar{
    display: block;
    position: sticky;
    top:0px;
}

.header-box .header-menu{
    display: flex;
    padding: 10px;
    justify-content: space-around;
    background-color:#FFFFFF;
    border-bottom: 1px solid rgb(160, 158, 158);
}

.header-box .header-menu .header-menu-category a:hover,
.header-box .header-menu .header-menu-best a:hover,
.header-box .header-menu .header-menu-notice:hover,
.header-box .header-menu .header-menu-mypage:hover,
.header-box .header-menu .header-menu-basket:hover {
    cursor: pointer;
}
.header-box .header-login-join>ul>li>a:hover,
.header-box .header-menu>.header-menu-category>span>a:hover,
.header-box .header-menu>.header-menu-category>.header-menu-category-list>li>a:hover,
.header-box .header-menu>.header-menu-best>a:hover,
.header-box .header-menu>.header-menu-notice>span>a:hover,
.header-box .header-menu>.header-menu-notice>.header-menu-notice-list>li>a:hover {
       color: orange;
}



.header-box .header-menu .header-menu-category .header-menu-category-list{
    margin-top:5px;
    text-align: center;  
    display: none;
}
.header-box .header-menu .header-menu-category .header-menu-category-list li{
    padding-top:15px;
}


.header-box .header-menu .header-menu-notice .header-menu-notice-list{
    margin-top:5px;
    text-align: center;   
    display: none;
}
.header-box .header-menu .header-menu-notice .header-menu-notice-list li{
    padding-top:15px;
}

</style>
<%
//세션에 저장된 권한 관련 정보를 반환받아 저장
	HewonDTO loginHewon=(HewonDTO)session.getAttribute("loginHewon");
%>

<div class="header-login-join">
	
	<% if(loginHewon==null) {//비로그인 사용자인 경우 %>
		<ul style="margin-left: 20px;">
		<li><a href="index.jsp?workgroup=hewon&work=hewon_login&login=1"><span style="font-size: 13px;">로그인</span></a>&nbsp;&nbsp;</li>
		<li><a href="index.jsp?workgroup=hewon&work=hewon_join"><span style="font-size: 13px;">회원가입</span></a>&nbsp;&nbsp;</li>
		</ul>
	<% } else {//로그인 사용자인 경우  %>
		<ul>
		<li><a href="index.jsp?workgroup=hewon&work=hewon_logout_action"><span style="font-size: 13px;">로그아웃</span></a>&nbsp;&nbsp;</li>
		<% if(loginHewon.gethStatus()==9) { //로그인 사용자가 관리자인 경우 %>
		<li><a href="index.jsp?workgroup=main&work=main_page"><span style="font-size: 13px;">쇼핑몰</span></a>&nbsp;&nbsp;</li>
		</ul>
		<% } %>
	<% } %>	
</div>

<%--
<div class="header-login-join">
	<ul>
	<% if(loginHewon==null) {//비로그인 사용자인 경우 %>
		<li><a href="index.jsp?workgroup=hewon&work=hewon_login&login=1">로그인</a>&nbsp;&nbsp;</li>
		<li><a href="index.jsp?workgroup=hewon&work=hewon_join">회원가입</a>&nbsp;&nbsp;</li>
	<% } else {//로그인 사용자인 경우  %>
		<li><a href="index.jsp?workgroup=hewon&work=hewon_logout_action">로그아웃</a>&nbsp;&nbsp;</li>
		<% if(loginHewon.gethStatus()==9) {//로그인 사용자가 관리자인 경우 %>
			<li><a href="index.jsp?workgroup=main&work=main_page">쇼핑몰</a>&nbsp;&nbsp;</li>
		<% } %>
	<% } %>		
	</ul>
</div>
 --%>    

<%if(loginHewon!=null){ %>
<div style="width: 98%; text-align: right; position: absolute; top:70px; font-size: 13px; padding-right: 15px;">
[<span style="font-weight: 530"><%=loginHewon.gethName() %></span>]님, 환영합니다
</div>
<%} %>

<%-- 
<%if(loginHewon!=null){ %>
<div style="width: 100%; text-align: right; position: absolute; top:70px;">
[<span style="font-weight: 900"><%=loginHewon.gethName() %></span>]님, 환영합니다
</div>
<%} %>
--%>

<div class="header-logo">
	<img src="<%=request.getContextPath()%>/theme/basic/img/head/logo_main5.png" alt="matdak_main_logo">
</div>
<div class="header-menubar">
	<div class="header-menu">
		<div class="header-menu-hewon">
			<span><a href="index.jsp?workgroup=admin&work=hewon_manager" style="font-size: 16px;">회원 관리</a></span>
			
		</div>
		<div class="header-menu-product"><a href="index.jsp?workgroup=admin&work=product_manager" style="font-size: 16px;">제품 관리</a></div>

		<div class="header-menu-order">
			<a href="index.jsp?workgroup=admin&work=order_manager" style="font-size: 16px;">주문 관리</a>
		</div>
		<div class="header-menu-review">
			<a href="index.jsp?workgroup=admin&work=review_manager" style="font-size: 16px;">리뷰 관리</a>
		</div>
		<div class="header-menu-notice">
			<a href="index.jsp?workgroup=admin&work=notice_manager" style="font-size: 16px;">공지사항 관리</a>
		</div>
	</div>
</div>


</script>