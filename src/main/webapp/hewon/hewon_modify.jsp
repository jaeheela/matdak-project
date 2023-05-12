<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 비밀번호를 전달받아 로그인 사용자의 비밀번호와 비교하여 같은 경우 로그인 사용자의
정보를 입력태그의 초기값으로 설정하고 변경값을 입력받기 위한 JSP 문서 --%>
<%-- => 로그인 사용자만 요청 가능한 JSP 문서 --%>
<%-- => [회원변경]을 클릭한 경우 회원정보 변경페이지(member_modify_action.jsp)로 이동 - 입력값 전달 --%>
<%@include file="/security/login_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	//전달값을 반환받아 저장
	String pw=Utility.encrypt(request.getParameter("pw"));
	
	//전달된 비밀번호가 로그인 사용자의 비밀번호와 같지 않은 경우 비밀번호 입력페이지
	//(password_confirm.jsp)로 이동
	if(!pw.equals(loginHewon.gethPw())) {
		session.setAttribute("message", "비밀번호가 맞지 않습니다.");
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=password_confirm&action=modify';");
		out.println("</script>");
		return;
	}
%>    
<style type="text/css">
fieldset {
	text-align: left;
	margin: 10px auto;
	width: 1100px;
}
legend {
	font-size: 1.2em;
}
#join label {
	width: 150px;
	text-align: right;
	float: left;
	margin-right: 10px;
}
#join ul li {
	list-style-type: none;
	margin: 15px 0;
}
#fs {
	text-align: center;
}
.error {
	color: red;
	position: relative;
	left: 160px;
	display: none;
}
#idCheck, #postSearch {
	font-size: 12px;
	font-weight: bold;
	cursor: pointer;
	margin-left: 10px;
	padding: 2px 10px;
	border: 1px solid black;
}
#idCheck:hover, #postSearch:hover {
	background: aqua;
}
</style>
<form id="join" action="index.jsp?workgroup=hewon&work=hewon_modify_action" method="post">
<fieldset>
	<legend>회원정보변경</legend>
	<ul>
		<li>
			<label for="id">아이디</label>
			<input type="text" name="id" id="id" value="<%=loginHewon.gethId()%>" readonly="readonly">
		</li>
		<li>
			<label for="pw">비밀번호</label>
			<input type="password" name="pw" id="pw">
			<span style="color: red;">비밀번호를 변경하지 않을 경우 입력하지 마세요.</span>
			<div id="pwRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
		</li>
		<li>
			<label for="name">이름</label>
			<input type="text" name="name" id="name" value="<%=loginHewon.gethName()%>" >
			<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
		</li>
		<li>
			<label for="email">이메일</label>
			<input type="text" name="email" id="email" value="<%=loginHewon.gethEmail()%>" >
			<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
			<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
		</li>
		<li>
			<label for="phone">전화번호</label>
			<% String[] phone=loginHewon.gethPhone().split("-"); %>
			<select name="phone1">
				<option value="010" <% if(phone[0].equals("010")) { %> selected <% } %>>&nbsp;010&nbsp;</option>
				<option value="011" <% if(phone[0].equals("011")) { %> selected <% } %>>&nbsp;011&nbsp;</option>
				<option value="016" <% if(phone[0].equals("016")) { %> selected <% } %>>&nbsp;016&nbsp;</option>
				<option value="017" <% if(phone[0].equals("017")) { %> selected <% } %>>&nbsp;017&nbsp;</option>
				<option value="018" <% if(phone[0].equals("018")) { %> selected <% } %>>&nbsp;018&nbsp;</option>
				<option value="019" <% if(phone[0].equals("019")) { %> selected <% } %>>&nbsp;019&nbsp;</option>
			</select>
			- <input type="text" name="phone2" id="phone2" size="4" maxlength="4" value="<%=phone[1]%>">
			- <input type="text" name="phone3" id="phone3" size="4" maxlength="4" value="<%=phone[2]%>">
			<div id="phoneMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
			<div id="phoneRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
		</li>
		<li>
			<label>우편번호</label>
			<input type="text" name="postcode" id="postcode" size="7" value="<%=loginHewon.gethPostcode()%>"  readonly="readonly">
			<span id="postSearch">우편번호 검색</span>
			<div id="postcodeMsg" class="error">우편번호를 입력해 주세요.</div>
		</li>
		<li>
			<label for="addr1">기본주소</label>
			<input type="text" name="addr1" id="addr1" size="50" value="<%=loginHewon.gethAddr1()%>"  readonly="readonly">
			<div id="addr1Msg" class="error">기본주소를 입력해 주세요.</div>
		</li>
		<li>
			<label for="addr2">상세주소</label>
			<input type="text" name="addr2" id="addr2" size="50" value="<%=loginHewon.gethAddr2()%>" >
			<div id="addr2Msg" class="error">상세주소를 입력해 주세요.</div>
		</li>
	</ul>
</fieldset>
<div id="fs">
	<button type="submit">회원변경</button>
	<button type="reset">다시입력</button>
</div>
</form>
<script type="text/javascript">
$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#pw").val()!="" && !pwReg.test($("#pw").val())) {
		$("#pwRegMsg").css("display","block");
		submitResult=false;
	} 
	if($("#name").val()=="") {
		$("#nameMsg").css("display","block");
		submitResult=false;
	}
	
	var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
	if($("#email").val()=="") {
		$("#emailMsg").css("display","block");
		submitResult=false;
	} else if(!emailReg.test($("#email").val())) {
		$("#emailRegMsg").css("display","block");
		submitResult=false;
	}
	var phone2Reg=/\d{3,4}/;
	var phone3Reg=/\d{4}/;
	if($("#phone2").val()=="" || $("#phone3").val()=="") {
		$("#phoneMsg").css("display","block");
		submitResult=false;
	} else if(!phone2Reg.test($("#phone2").val()) || !phone3Reg.test($("#phone3").val())) {
		$("#phoneRegMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#postcode").val()=="") {
		$("#postcodeMsg").css("display","block");
		submitResult=false;
	}
	
	if($("#addr1").val()=="") {
		$("#addr1Msg").css("display","block");
		submitResult=false;
	}
	
	if($("#addr2").val()=="") {
		$("#addr2Msg").css("display","block");
		submitResult=false;
	}
	
	return submitResult;
});
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {
	new daum.Postcode({
	    oncomplete: function(data) {
	        $("#postcode").val(data.zonecode);
	        $("#addr1").val(data.addr);
	    }
	}).open();
});
</script>