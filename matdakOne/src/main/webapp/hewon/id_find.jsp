<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>

<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<style type="text/css">

@import url("https://hangeul.pstatic.net/hangeul_static/css/nanum-barun-gothic.css");


body{
	font-size: 15px;
	font-family: "nanumbarungothic";
}



#message{
	text-align: center;
}

input {
  width: 150px;
  height: 15px;
  font-size: 15px;
  margin-bottom: 5px;
  border: 1px solid rgba(0,0,0,0.2);
  padding-left: 10px;
}

#form{
	text-align: center;
	margin-top: 20px;
}

#check{
	margin-top: 10px;
	width: 50px;
    height: 20px;
    border-radius: 3px;
    background-color: #34495e;
    font-weight: bold;
    border: none;
    color: white;
    font-size: 14px;
    cursor: pointer;
}



</style>
</head>
<body>

<p style="text-align: center; font-weight: bold;">아이디 찾기</p>
<div id="message">
			가입 시 기재한 이름과 이메일 주소를 입력해주세요.
		</div>
		<div id="form">
			<form id="find" action="<%=request.getContextPath()%>/hewon/id_find_action.jsp"  method="get">
	
				<input type="text" name="name" id="name" placeholder="이름" >
				<div id="nameMsg" class="error">이름을 입력해 주세요.</div><br>
		
				 <input type="text" name="email" id="email" placeholder="이메일" > 
				<div id="emailMsg" class="error">이메일을 입력해 주세요.</div>
	
			<button type="submit">확인</button>
			</form>
	</div>
</body>
	<script type="text/javascript">

		$("#find").submit(function() {
			var submitResult=true;
			
			$(".error").css("display","none");
			var idReg=/^[a-zA-Z]\w{5,19}$/g;
		
			if($("#name").val()=="") {
				$("#nameMsg").css("display","block");
				submitResult=false;
			}
			
			var emailReg=/^([a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+(\.[-a-zA-Z0-9]+)+)*$/g;
			if($("#email").val()=="") {
				$("#emailMsg").css("display","block");
				submitResult=false;
			} 
			
			return submitResult;
		});
		</script>
</html>