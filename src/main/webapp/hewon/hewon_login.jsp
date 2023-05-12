<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 로그인정보를 입력받기 위한 JSP 문서 --%>
<%-- => [로그인]을 클릭한 경우 로그인 처리페이지(member_login_action.jsp)로 이동 - 입력값 전달 --%>
<%
	if(request.getParameter("login")!=null) {//전달값이 있는 경우
		//메인페이지로 이동되도록 세션에 저장된 기존 요청 URL 주소를 제거 
		session.removeAttribute("returnUrl");
	}
	String message=(String)session.getAttribute("message");
	if(message==null) {
		message="";
	} else {
		session.removeAttribute("message");
	}
	
	String id=(String)session.getAttribute("id");
	if(id==null) {
		id="";
	} else {
		session.removeAttribute("id");
	}
%>    
<style type="text/css">

#login_btn:hover{
	cursor:pointer;
}
#search:hover{
	cursor:pointer;
}

/*css추가*/
h1{
	margin-top: 100px;
	margin-left:50px;
}
.loginForm-size{
	max-width: 600px;
	margin: 0 auto;
}
form#login {
	max-width:70%;
	margin: 40px auto 0;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
}

.login-logo{
	display: flex;
	margin-bottom: 10px;
}

.login_tag {
	margin: 5px auto;
	width: 100%;
}  


#login li {
	list-style-type: none;
	margin-bottom: 10px;
}
.login_btn-box{
	width: 100%;
	margin: 0 auto;
}
#login_btn {
	width: 80%;	
	padding-right: 10px;
	padding-left: 10px;
    height: 50px;
    line-height: 50px;
    border: 1px solid #ff2222;
    font-size: 17px;
    color: #fff;
    background-color: red;
    margin: 0 auto;
    margin-bottom: 30px;
    border-radius: 20px;
}
#login input{
	width: 80%;
    height: 30px;
    line-height: 30px;
    padding: 10px;
    text-indent: 15px;
    margin-bottom: 15px;
    font-size: 15px;
    color: #999;
    border: 1px solid #ccc;
    border-radius: 20px;
    outline: none;
}

}

#search {
	display: inline-block;
	margin: 5px auto;
}
#search a{
	border-radius: 10px;
	padding: 3px;
}
#search a:hover {
	background-color: #ffaeae;
}

#message {
	margin-top:20px;
	color: red;	
	text-align: center;
	font-weight: bold;
	font-size: 16px;
}

</style>
<div class="loginForm-size">
	<form id="login" name="loginForm" action="index.jsp?workgroup=hewon&work=hewon_login_action" method="post">
		<div class="login-logo">	
			<img src="<%=request.getContextPath()%>/hewon/login_2.png" style="width: 20px; height: 20px; padding-top: 3px; padding-right: 5px;">
			<span style="font-style: red; font-weight: 530; font-size: 16px; padding-top: 3px;">로그인</span>
		</div>
		
		<ul class="login_tag">
			<li>
				<input type="text" name="id" id="id" placeholder="아이디" value="<%=id%>">
			</li>
			<li>
				<input type="password" name="pw" placeholder="비밀번호"  id="pw">
			</li>
		</ul>
		<div class="login_btn-box">
			<div id="login_btn">로그인</div>
		</div>
		<div id="search">
			<a class="id_find" style="font-size: 17px;">아이디 찾기</a>
			<span>|</span>
			<a class="pw_find" style="font-size: 17px;">비밀번호 찾기</a>
		</div>	
		<div id="message"><%=message %></div>
	</form>
</div>
<script type="text/javascript">
$("#search .id_find").click(function() {
	//팝업창 실행하여 아이디 중복 검사 페이지요청 
	window.open("<%=request.getContextPath()%>/hewon/id_find.jsp"
			,"emailcheck","width=500,height=300,left=700,top=400");
	});
	
$("#search .pw_find").click(function() {
	//팝업창 실행하여 아이디 중복 검사 페이지요청 
	window.open("<%=request.getContextPath()%>/hewon/pw_find.jsp" 
			,"emailcheck","width=500,height=300,left=700,top=400");
	});


$("#id").focus();
$("#login_btn").click(function() {
	if($("#id").val()=="") {
		$("#message").text("아이디를 입력해 주세요.");
		$("#id").focus();
		return;
	}
	
	if($("#pw").val()=="") {
		$("#message").text("비밀번호를 입력해 주세요.");
		$("#pw").focus();
		return;
	}
	
	$("#login").submit();
});
</script>