<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/security/login_url.jspf"%>

<link rel="stylesheet" type="text/css" href="mypage/mypage.css">
<link rel="stylesheet" type="text/css" href="mypage/mypage_main.css">
    
<style type="text/css">

.info {
	text-align: left;
	padding: 20px 0 0 0;
}

#detail {
	width: 500px;
	margin: 0 auto;
}

#detail dt {
	font-weight: 530;
	padding-bottom: 5px;
}

#link {
	margin-top: 100px;
	text-align: center;
}
#link a:hover {
	color: orange;
}
</style>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MATDAK</title>
</head>
<body>
	<!-- 마이페이지 상단 head -->
	<div id="mypage_wrap">
		<!-- 마이페이지 title -->
		<div class="mypage_title">마이페이지</div>
		
		<!-- 마이페이지 닉네임 -->
		<div class="mypage_head">
			<%-- <div class="mypage_head_id"><%=loginMember.gethId() %></div> --%>
			<div class="mypage_head_id"><%= loginHewon.gethId()%></div>
		</div>
	</div>
	
	<!-- 마이페이지 tablist -->
	<div class="mypage_head_list">
		<ul>
			<li class="head_list_chk">
				<a href="index.jsp?workgroup=mypage&work=mypage_main"><img src="mypage/mypage_list1.png" alt="구매내역"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				<a href="index.jsp?workgroup=mypage&work=mypage_hewon"><img src="mypage/mypage_list9.png" alt="회원관리"></a>
			</li>
		</ul>
	</div>
	
<script type="text/javascript">
//마이페이지 첫 li css속성을 다른 li들을 클릭하면 똑같이 사용할 수 있도록 만들기
$(".mypage_head_list ul li").click(function(){
	$(".mypage_head_list ul li").removeClass("head_list_chk");
	$(this).addClass("head_list_chk");
});
</script>

<div class="main_info" style="text-align:left; padding: 20px 0px 20px 0px; border-bottom: 1px solid #999;">
	<span style="font-size: 35px; font-weight: 550;">내 정보</span>
</div>

<div class="info">
	<div class="detail">
		<dl>
			<dt style="font-weight: 530; padding-bottom: 5px;">아이디</dt>
			<dd style="font-size: 16px; padding-bottom: 10px; border-bottom: 1px solid #eee;"><%=loginHewon.gethId() %></dd>
			<dt style="font-weight: 530; padding-bottom: 5px; padding-top: 10px">이름</dt>
			<dd style="font-size: 16px; padding-bottom: 10px; border-bottom: 1px solid #eee; padding-top: 5px;"><%=loginHewon.gethName() %></dd>
			<dt style="font-weight: 530; padding-bottom: 5px; padding-top: 10px;">이메일</dt>
			<dd style="font-size: 16px; padding-bottom: 10px; border-bottom: 1px solid #eee;"><%=loginHewon.gethEmail() %></dd>
			<dt style="font-weight: 530; padding-bottom: 5px; padding-top: 10px;">전화번호</dt>
			<dd style="font-size: 16px; padding-bottom: 10px; border-bottom: 1px solid #eee;"><%=loginHewon.gethPhone() %></dd>
			<dt style="font-weight: 530; padding-bottom: 5px; padding-top: 10px;">주소</dt>
			<dd style="font-size: 16px; padding-bottom: 10px;">[<%=loginHewon.gethPostcode() %>]<%=loginHewon.gethAddr1() %> <%=loginHewon.gethAddr2() %></dd>
		</dl>
	</div>
</div>

<div id="link">
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=modify">[회원정보변경]</a>&nbsp;&nbsp;
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=password_confirm&action=remove">[회원탈퇴]</a>&nbsp;&nbsp;
</div>