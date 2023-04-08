<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 사용자로부터 회원정보를 입력받기 위한 JSP 문서 --%>
<%-- => [회원가입]을 클릭한 경우 회원정보 삽입페이지(_join_action.jsp)로 이동 - 입력값 전달 --%>
<%-- => [아이디 중복 검사]를 클릭한 경우 팝업창을 실행하여 아이디 중복 검사페이지(id_check.jsp)를 요청 - 아이디 전달 --%>
<%-- => [우편번호 검색]를 클릭한 경우 팝업창을 실행하여 우편번호 검색페이지(post_search.jsp)를 요청 --%>    
<style type="text/css">

.id-box{
	width: 100%;

}

#join .id-fieldset{
	display: flex;
	flex-direction: column;
	justify-content:center;
	align-items: center;
}
#join .id-fieldset ul li{
	list-style-type: none;
	margin: 15px 0;
	width: 100%;
}

#join select{
	border: 1px solid #ccc;
    width: 100px;
    height: 50px;
    line-height: 50px;
    font-size: 15px;
    color: #999;
    text-indent: 10px;
    margin-right: 5px;
    margin-top:10px;
}

.fieldset-style{
	width: 70%;
	margin: 0 auto;
}
fieldset {
	text-align: left;
	margin: 10px auto;
	width: 30%;
	border: none;
}
legend {
	display: block;
	width:100%;
	text-align: center;
	font-size: 1.2em;
	margin: 0 auto;
}

#join{
	display: flex; 
	flex-direction:column;  
	justify-content:center;
	align-items: center;
	width: 100%;
	margin: 0 auto;
}

#join ul li {
	list-style-type: none;
	margin: 15px 0;
	width: 100%;

}
#join select{
	border: 1px solid #ccc;
	border-radius: 20px;
    width: 100px;
    height: 50px;
    line-height: 50px;
    font-size: 15px;
    color: #999;
    text-indent: 10px;
    margin-right: 5px;
    margin-top:10px;
}

.i_s_border2{
	border: 1px solid #ccc;
	border-radius: 20px;
    width: 110px;
    height: 50px;
    line-height: 50px;
    font-size: 15px;
    color: #999;
    text-indent: 10px;
    margin-right: 5px;
    margin-top:10px;
}
.i_s_border{
	border: 1px solid #ccc;
	border-radius: 20px;
    width: 380px;
    height: 50px;
    line-height: 50px;
    font-size: 15px;
    color: #999;
    text-indent: 10px;
    margin-right: 5px;
    margin-top: 20px;
}

#fs button{
	text-align: center;
	font-size: 16px;
	padding: 7px 20px 7px 20px;
	border: 1px solid red;
	border-radius: 20px;
	cursor: pointer;
	background-color: red;
	color: white;
	font-weight: 550;
}


#fs button:hover {
	
}


.error {
	color: red;
	display: none;
	font-size: 0.9em;
	font-weight: 900;
	text-align: center;
}
.check{
	border-radius: 20px;
	width: 100%;
	display: flex;
	justify-content: center;
}
#idCheck, #postSearch {
	font-size: 15px;
	cursor: pointer;
	padding: 2px 10px;
	border: 2px solid red;
	border-radius: 20px;
	color: red;
	font-weight: 550;
}
#idCheck:hover, #postSearch:hover {
	
}

</style>

<div class="id-box">
	<form id="join" action="index.jsp?workgroup=hewon&work=hewon_join_action" method="post">
		<%-- 아이디 사용 여부를 구분하기 위한 값을 저장하는 입력태그 --%>
		<%-- => 0 : 아이디 중복 검사 미실행 - 아이디 사용 불가능 --%>
		<%-- => 1 : 아이디 중복 검사 실행 - 아이디 사용 가능 --%>
		<input type="hidden" id="idCheckResult" value="0">
		<fieldset class="id-fieldset">
			<legend>회원가입</legend>
			<ul>
				<li>
					<input type="text" name="id" id="id" maxlength="20" class="i_s_border" 
				placeholder="아이디" required="">
					<div class="check">
					<span id="idCheck" style="display: inline-block; margin-top: 8px;">아이디 중복 검사</span>
					</div>
					<div id="idMsg" class="error">아이디를 입력해 주세요.</div>
					<div id="idRegMsg" class="error">아이디는 영문자로 시작되는 영문자,숫자,_의 6~20범위의 문자로만 작성 가능합니다.</div>
					<div id="idCheckMsg" class="error">아이디 중복 검사를 반드시 실행해 주세요.</div>
				</li>
				<li>
				
					<input type="password" name="pw" id="pw" maxlength="20" class="i_s_border" 
				placeholder="비밀번호" required="">
					<div id="pwMsg" class="error">비밀번호를 입력해 주세요.</div>
					<div id="pwRegMsg" class="error">비밀번호는 영문자,숫자,특수문자가 반드시 하나이상 포함된 6~20 범위의 문자로만 작성 가능합니다.</div>
				</li>
				<li>
					<input type="password" name="repw" id="repw" maxlength="20" class="i_s_border" 
				placeholder="비밀번호 확인" required="">
					<div id="repwMsg" class="error">비밀번호 확인을 입력해 주세요.</div>
					<div id="repwMatchMsg" class="error">비밀번호와 비밀번호 확인이 서로 맞지 않습니다.</div>
				</li>
				<li>
				
					<input type="text" name="name" id="name" maxlength="20" class="i_s_border" 
				placeholder="이름" required="">
					<div id="nameMsg" class="error">이름을 입력해 주세요.</div>
				</li>
				<li>
				
					<input type="text" name="email" id="email" maxlength="20" class="i_s_border" 
				placeholder="이메일" required="">
					<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
					<div id="emailRegMsg" class="error">입력한 이메일이 형식에 맞지 않습니다.</div>
				</li>
				<li>
				
					<select name="phone1">
						<option value="010" selected>&nbsp;010&nbsp;</option>
						<option value="011">&nbsp;011&nbsp;</option>
						<option value="016">&nbsp;016&nbsp;</option>
						<option value="017">&nbsp;017&nbsp;</option>
						<option value="018">&nbsp;018&nbsp;</option>
						<option value="019">&nbsp;019&nbsp;</option>
					</select>
					- <input type="text" name="phone2" id="phone2" size="4" maxlength="4" class="i_s_border2" 
				placeholder="0000" required="">
					- <input type="text" name="phone3" id="phone3" size="4" maxlength="4"  class="i_s_border2" 
				placeholder="0000" required="">
					<div id="phoneMsg" class="error">전화번호를 입력해 입력해 주세요.</div>
					<div id="phoneRegMsg" class="error">전화번호는 3~4 자리의 숫자로만 입력해 주세요.</div>
				</li>
				<li>
				
					<input type="text" name="postcode" id="postcode" size="7" readonly="readonly"  class="i_s_border" 
				placeholder="우편번호" required="">
					<div class="check">
					<span id="postSearch" style="display: inline-block; margin-top: 8px;">우편번호 검색</span>
					</div>
					<div id="postcodeMsg" class="error">우편번호를 입력해 주세요.</div>
				</li>
				<li>
			
					<input type="text" name="addr1" id="addr1" size="50" readonly="readonly"  class="i_s_border" 
				placeholder="기본주소" required="">
					<div id="addr1Msg" class="error">기본주소를 입력해 주세요.</div>
				</li>
				<li>
			
					<input type="text" name="addr2" id="addr2" size="50"  class="i_s_border" 
				placeholder="상세주소" required="">
					<div id="addr2Msg" class="error">상세주소를 입력해 주세요.</div>
				</li>
			</ul>
		</fieldset>
		<div id="fs" class="id-Btn">
			<button type="submit">회원가입</button>&nbsp;&nbsp;&nbsp;
			<button type="reset">다시입력</button>
		</div>
	</form>
</div>
<script type="text/javascript">
$("#id").focus();
$("#join").submit(function() {
	var submitResult=true;
	
	$(".error").css("display","none");
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		submitResult=false;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		submitResult=false;
	} else if($("#idCheckResult").val()=="0") {//아이디 중복 검사를 실행하지 않은 경우
		$("#idCheckMsg").css("display","block");
		submitResult=false;
	}
		
	var pwReg=/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[~!@#$%^&*_-]).{6,20}$/g;
	if($("#pw").val()=="") {
		$("#pwMsg").css("display","block");
		submitResult=false;
	} else if(!pwReg.test($("#pw").val())) {
		$("#pwRegMsg").css("display","block");
		submitResult=false;
	} 
	
	if($("#repw").val()=="") {
		$("#repwMsg").css("display","block");
		submitResult=false;
	} else if($("#pw").val()!=$("#repw").val()) {
		$("#repwMatchMsg").css("display","block");
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
$("#idCheck").click(function() {
	//아이디 관련 에러메세지가 보여지지 않도록 설정
	$("#idMsg").css("display","none");
	$("#idRegMsg").css("display","none");
	
	var idReg=/^[a-zA-Z]\w{5,19}$/g;
	if($("#id").val()=="") {
		$("#idMsg").css("display","block");
		return;
	} else if(!idReg.test($("#id").val())) {
		$("#idRegMsg").css("display","block");
		return;
	}
	
	//팝업창 실행하여 아이디 중복 검사 페이지(id_check.jsp) 요청 - 아이디 전달
	window.open("<%=request.getContextPath()%>/hewon/id_check.jsp?id="+$("#id").val()
			,"idcheck","width=450,height=130,left=700,top=400");
});
//입력태그(아이디)의 입력값이 변경된 경우 호출될 이벤트 처리 함수 등록
$("#id").change(function() {
	//입력태그(검사결과)의 입력값 변경 - 아이디 중복 검사 미실행으로 설정
	$("#idCheckResult").val("0");
});
/*
$("#postSearch").click(function() {
	//팝업창 실행하여 우편번호 검색페이지(post_search.jsp) 요청
	window.open("<%=request.getContextPath()%>//post_search.jsp","postseatch"
			,"width=600,height=600,left=600,top=250");
});
*/
</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$("#postSearch").click(function() {
	new daum.Postcode({
	    oncomplete: function(data) {
	        $("#postcode").val(data.zonecode);
	        $("#addr1").val(data.address);
	    }
	}).open();
});
</script>