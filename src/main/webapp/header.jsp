<%@page import="xyz.itwill.dto.HewonDTO"%>
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
    width : 280px;
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


/*
.header-box .header-menu:before {
    content: '';
    display: block;
    width: 90%;
    height: 1px;
    background: rgb(228, 225, 225);
    position: absolute;
    top: 15%; 
}
.header-box .header-menu:after {
    content: '';
    display: block;
    width: 90%;
    height: 1px;
    background: rgb(228, 225, 225);
    position: absolute;
    top: 20%; 
    margin-top: -7px;
}
*/

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
.header-box .header-menubar{
    display: block;
    position: sticky;
    top:0px;
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
		<% if(loginHewon.gethStatus()==9) {//로그인 사용자가 관리자인 경우 %>
		<li><a href="index.jsp?workgroup=admin&work=main_page"><span style="font-size: 13px;">관리자</span></a>&nbsp;&nbsp;</li>
		</ul>
		<% } %>
	<% } %>	
</div>

<%if(loginHewon!=null){ %>
<div style="width: 100%; text-align: right; position: absolute; top:70px; font-size: 13px; padding-right: 15px;">
[<span style="font-weight: 530"><%=loginHewon.gethName() %></span>]님, 환영합니다
</div>
<%} %>

<div class="header-logo">
	<a href="index.jsp?workgroup=main&work=main_page">
		<img src="<%=request.getContextPath()%>/theme/basic/img/head/logo_main5.png" alt="matdak_main_logo">
	</a>	
</div>
<div class="header-menubar" style="display: block; position: sticky; top:0px;">
	<div class="header-menu">
		<div class="header-menu-category">
			<span><a href="index.jsp?workgroup=shop&work=product" style="font-size: 16px;">전체카테고리</a></span>
			<ul class="header-menu-category-list">
				<li><a href="index.jsp?workgroup=shop&work=product&search=DAKGASM" style="font-size: 16px;">닭가슴살</a></li>
				<li><a href="index.jsp?workgroup=shop&work=product&search=ANSIM" style="font-size: 16px;">닭안심살</a></li>
				<li><a href="index.jsp?workgroup=shop&work=product&search=DOSIRAK" style="font-size: 16px;">도시락</a></li>
				<li><a href="index.jsp?workgroup=shop&work=product&search=INSTANT" style="font-size: 16px;">즉석/간편식</a></li>
				<li><a href="index.jsp?workgroup=shop&work=product&search=DESSERT" style="font-size: 16px;">빵/간식</a></li>
			</ul>
		</div>
		<div class="header-menu-best"><a href="index.jsp?workgroup=shop&work=best_list" style="font-size: 16px;">베스트</a></div>
		<div class="header-menu-notice">
			<span><a href="#" style="font-size: 16px;">커뮤니티</a></span>
			<ul class="header-menu-notice-list">
				<li><a href="index.jsp?workgroup=board&work=notice" style="font-size: 16px;">공지사항</a></li>
				<li><a href="index.jsp?workgroup=board&work=review" style="font-size: 16px;">구매후기</a></li>
				<li><a href="index.jsp?workgroup=board&work=moon" style="font-size: 16px;">문의사항</a></li>
			</ul>
		</div>
		<div class="header-menu-my">
			<a href="index.jsp?workgroup=mypage&work=mypage_main">
				<img src="theme/basic/img/head/mypage.png" alt="마이페이지">
			</a>
		</div>
		<div class="header-menu-basket">
			<a href="index.jsp?workgroup=basket&work=basket_list">
				<img src="theme/basic/img/head/cart.png" alt="장바구니">
			</a>
		</div>
	</div>
</div>


<script type="text/javascript">

        //전체카테고리에 마우스 hover
        $(".header-menu-category").hover(function () {
            $('.header-menu-category-list').show();
        }, function () {
            $('.header-menu-category-list').hide();
        });

        //커뮤니티에 마우스 hover
        $(".header-menu-notice").hover(function () {
            $('.header-menu-notice-list').show();
        }, function () {
            $('.header-menu-notice-list').hide();
        });

/*
        // 스크롤 메뉴 
        $(window).scroll(function () {

            var height = $(document).scrollTop();

            if (height > 120) {
                $(".header-menubar").css({
                    "position": "fixed"
                });

            } else {
                $(".header-menubar").css({
                    "position": "relative"
                });
            }
        });
*/

</script>