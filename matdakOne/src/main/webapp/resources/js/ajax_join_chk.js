// 변수값 정의 
var all_chk='none';
var chk_count=0;
var auth_time=0;
var auth_count=0;
//아이디
var code_01 = '사용 가능한 아이디 입니다.';
var code_02 = '이미 사용중인 아이디 입니다.';
var code_03 = '영문자, 숫자, _만 입력 가능 합니다.';
var code_04 = '최소 6자이상 입력해 주세요.';
// 패스워드 
var code_10 = '비밀번호가 일치합니다.'; 	
var code_11 = '매우 안전한 비밀번호 입니다.'; 	
var code_12 = '적정 수준의 안전한 비밀번호입니다.'; 	
var code_13 = '비밀번호는 8~15자 이내로 가능합니다.'; 	
var code_14 = '비밀번호는 영자, 숫자, 특수 문자 중 2가지 이상을 사용해야 합니다.'; 	
var code_15 = '연속된문자/숫자는 사용불가합니다.'; 	
var code_16 = '비밀번호가 일치하지 않습니다. 다시입력해주세요'; 	
var code_17 = '보안에 매우 취약하여 사용할 수 없습니다.'; 	
var code_18 = '안전한 사용을 위해 영문만 사용할 수 없습니다.'; 	
// 이메일 & 휴대폰 
var code_20 = '아이디 또는 비밀번호를 찾기위해 꼭 필요한 정보이므로 정확하게 입력해주세요.';
var code_21 = '휴대폰번호 형식이 올바르지 않습니다.';
var code_22 = '이메일 주소 및 형식을 확인해 주세요.';
var code_23 = '숫자만 입력해 주세요.';
var code_24 = '사용하실 수 없는 별명 입니다.';
var code_25 = '휴대폰번호를 정확히 입력해 주세요.';

var code_26 = '별명은 하루에 한번 이상 변경하실 수 없습니다.';

$( document ).ready(function() {
	
	//------- 초기화  --------//
	
	// 인증 번호 
	var auth_number='';
	
	// 생년 월일 
	if( $("#mb_birth").val()!='' ){	
		$("#birth_year").val( $("#mb_birth_year").val() );
		$("#birth_month").val( $("#mb_birth_month").val() );
		$("#birth_day").val( $("#mb_birth_day").val() );
	}

	// 이메일
	if( $("#mb_email").val()!='' ){	
		var email_id = $("#mb_email").val()		
		$("#email_id").val(email_id);
		
	}
	
	// 성별
	if( $("#mb_sex").val()!='' ){
		if( $("#mb_sex").val()=='M' ){
			select_gender('M');
		}else if( $("#mb_sex").val()=='F' ){
			select_gender('F');		
		}	
	}
	/*
	// 메일링 
	if( $("#mb_mailling").val()!='' ){
		
		var chked_url = g4_url+'/images/join/select_btn2.png';
		var unchk_url = g4_url+'/images/join/select_btn1.png';
				
		if( $("#mb_mailling").val()=='1' ){
			$("#emailChk_img").attr('src',chked_url);
		}else if( $("#mb_mailling").val()=='' ){
			$("#emailChk_img").attr('src',unchk_url);	
		}	
	}
	
	// SMS 
	if( $("#mb_sms").val()!='' ){
		
		var chked_url = g4_url+'/images/join/select_btn2.png';
		var unchk_url = g4_url+'/images/join/select_btn1.png';
				
		if( $("#mb_sms").val()=='1' ){
			$("#smsChk_img").attr('src',chked_url);
		}else if( $("#mb_sms").val()=='' ){
			$("#smsChk_img").attr('src',unchk_url);	
		}	
	}
	*/
	//------ 여기 까지 ------//
	
	
	// 아이디 체크 
	$("#mb_id").blur(function (){
		// 아이디 체크 이벤트
		id_chk();
	});

	// 비밀번호 체크 
	$("#mb_password").blur(function (){
		// 비밀번호 체크 이벤트 
		pw_chk();
	});

	// 비밀번호 확인 체크 
 	$("#mb_password_chk").blur(function (){
 		// 비밀번호 확인 체크 이벤트
 		pw_chk_overlap();
 	});
	
 	// 이름 체크
 	$("#mb_name").blur(function (){
 		// 이름 체크 이벤트 
 		//name_chk();
 	});
 	 	
 	// 별명 체크 
 	$("#mb_nick").blur(function (){
 		// 별명 체크 이벤트
 		//nickChkEvent();
 	});
 	
 	/*
 	$("#mb_hp").focus(function (){
 		
 		if( $("#mb_hp").val()=='정확한 휴대폰 번호를 적어 주세요.'  ){
 			$("#mb_hp").val('');
 		}
 		$("#mb_hp").css('color','#494949');
 		
 	});
 	*/
 	 	 	 	 	 	
 	// 휴대폰 번호 체크 
 	$("#mb_hp").blur(function (){
 		// 모바일 체크 이벤트 
 		mobile_chk();
 	});
 	
 	$("#mb_email").blur(function (){
 		emailChkEvent2();
 	});
 	
 	$("#email_address_select").change(function (){
 		emailChkEvent2();
 	});
 	
 	$("#selectEmail").change(function (){
 		emailChkEvent2();
 	});
 	
 	
 	// 이메일 체크 
 	$("#email_id").blur(function (){
 		// 이메일 체크 이벤트
 		//emailChkEvent('id');
 	});

 	// 이메일 체크 
 	$("#email_address").blur(function (){
 		// 이메일 체크 이벤트
 		//emailChkEvent();
 	});

	// 생년월일 체크 - 년
	$("#birth_year").change(function (){
		$("#mb_birth_year").val($(this).val());
		// 생년월일 이벤트 
		birthEvent();
	});
	// 생년월일 체크 - 월
	$("#birth_month").change(function (){
		$("#mb_birth_month").val($(this).val());
		// 생년월일 이벤트 
		birthEvent();
	});
	// 생년월일 체크 - 일
	$("#birth_day").change(function (){
		$("#mb_birth_day").val($(this).val());
		// 생년월일 이벤트 
		birthEvent();
	});

	// 모바일 인증 보내기
	$("#send_mobile").click(function() {
		
		if( auth_time==0 ){
				
			// 모바일 번호가 존재 하는지
			if( mobile_chk()==true ){
				
				var mb_hp=$("#mb_hp").val();			
				
				// 인증 초기화
				$("#mb_hp_enabled").val('');
				// ajax 처리 후 인증 번호 받기		
						
				// 임시 
				//var auth_number = Math.floor(Math.random() * 8999)+1000;
				//alert('인증번호는 '+auth_number+' 입니다');
				
				if( auth_count > 5 ){
					$("#mb_hp").css({	'border': '1px solid #999' });      
 					$("#mb_hp_phrase").css({ 'color': '#f22' });
 					$("#mb_hp_phrase").text('재전송은 5번 까지만 하실 수 있습니다.');
 					return false;
				}else{
						
					$.ajax({
			 		    type: 'POST',
			 		    url: "/bbs/ajax_member_mobile_certify.php",
			 		    data: { status:0, mb_hp : mb_hp, de_sms_use:'icode' },  //status :: 0 가입  :: 1 정보수정
			 		    beforeSend: function(){
			 		    	$("#mb_hp").prop('readonly',true);
			 		    	$("#mb_hp").css({
			 					'background': '#f9f9f9',
			 					'border': '1px solid #337ab7'
			 				});
			 		    },
			 		    success: function (data) {
			 		    	//alert( data );
			 		    	if( data=='overlap' ){
			 		    		//alert("이미 등록 되어있는 번호 입니다.");
			 		    		$("#mb_hp").prop('readonly',false);
			 		    		$("#mb_hp").css({
			 		    			'border': '1px solid #f22',
			 		    			'background' : '#fff'
			 		    		});
			 					$("#mb_hp_phrase").css({ 'color': '#f22' });
			 					$("#mb_hp_phrase").text('이미 등록 되어있는 번호 입니다.');	
			 		    		return false;
			 		    	}else if( data=='fail' ){
			 		    		//alert("하루가 지나야 수정이 가능 합니다.");
			 		    		$("#mb_hp").css({	'border': '1px solid #f22' });      
			 					$("#mb_hp_phrase").css({ 'color': '#f22' });
			 					$("#mb_hp_phrase").text('하루가 지나야 수정이 가능 합니다.');	
			 		    		return false;
			 		    	}else{
			 		    		//alert(data);
				 		    	//alert("인증 번호를 발송 하였습니다.");
				 		    	// 받은 값 넣기 (삭제)
			 		    		//$("#mb_hp_phrase").text("");
			 		    		
			 		    		/*data=data.split("/");	
			 		   			test_auth=data[1];
			 		   			auth_number=data[0];*/
			 		   			auth_number=data;
			 		    		
				 		    	$("#auth_number").val(auth_number);
				 		   		$("#mb_hp_chk").focus();
				 		   		auth_time=180;
				 		   		$("#mb_hp_phrase").html('인증 번호를 발송 하였습니다.<br><span id="timer"></span> 이내 인증완료 해주세요');
				 		   		$('#send_mobile').attr('style','color:#999');
				 		   		$('#send_mobile').css('border','1px solid #999');
				 		   		
				 		   		/* 테스트용 */
				 		   		/*if( g4_url !='http://www.rankingdak.com/m' ){
				 		   			$("#mb_hp_phrase").append('<div style="text-align: right;">테스트서버용 : 인증 번호 '+test_auth+'</div>');
				 		   		}*/
					 		   	
				 		   		certifyCount(auth_time);
			 		    	}
			 		    },
			 		    error: function (request, status, error) {
			 		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
			 		    	//alert('실패 : '+status);
			 		    	return false;
			 		    }
			 		});
				}
			}
		}else{
			alert( $("#timer").text()+'후에 재전송 가능 합니다');
		}
		
		
	});

	// 인증 하기 
	$("#send_chk").click(function() {
		movileCertifyEvent(1);
	});
	
});
// ready end

// 카운트 다운
function certifyCount(time){
			
	var time = Math.round(time);
	var countdown_format = 'S';
    if( time > 60) countdown_format = 'MS';
    $("#timer").countdown({
    	until : time,
    	compact : true,
    	format : countdown_format,
    	onExpiry : function(){
	        try{
	        	//alert('다시 인증해주세요');
	        	// 다시 인증 하기
	        	auth_time=0;
	        	auth_count++;
	        	$("#auth_number").val('');
	        	$("#mb_hp_phrase").text("인증 시간이 지났습니다 재전송 하시기 바랍니다.");
	        	$("#mb_hp").prop('readonly',false);
	        	$("#mb_hp").css({
					'background': '#fff',
					'border': '1px solid #ccc'
				});
	        	$("#send_mobile").css({"color":"#333","border":"1px solid #333"});

	        	
	        }
	        catch(e){}
    	}
    });
	
}

// 아이디 체크 이벤트
function id_chk(){
	
	// 아이디 값
	var id_val=$("#mb_id").val();
	// 아이디 길이 체크 
	if( id_val.length < 6 ){
		$("#mb_id").css({	'border': '1px solid #f22' });      
		$("#mb_id_phrase").css({ 'color': '#f22' });
		$("#mb_id_phrase").text(code_04);			
		$("#mb_id_enabled").val('n');
		return false;
	}else{
		// 문자체크에 걸린 경우 
		var reg_id = /^[A-za-z0-9]+$/g;
		if(!reg_id.test(id_val)){
			$("#mb_id").css({	'border': '1px solid #f22' });      
			$("#mb_id_phrase").css({ 'color': '#f22' });
			$("#mb_id_phrase").text(code_03);			
			$("#mb_id_enabled").val('n');
		    return false;
		}else{
			$.ajax({
		        type: "POST",
		        url: g5_bbs_url+"/ajax.mb_id.php",
		        data: {
		            "reg_mb_id": encodeURIComponent($("#mb_id").val())
		        },
		        cache: false,
		        async: false,
		        success: function(data) {
		            if(data!="") {
		            	$("#mb_id").css({	'border': '1px solid #f22' });      
						$("#mb_id_phrase").css({ 'color': '#f22' });
						$("#mb_id_phrase").text(data);			
						$("#mb_id_enabled").val('n');
						return false;
		            }else {
						$("#mb_id").css({'border': '1px solid #337ab7'});
				        $("#mb_id_phrase").css({'color': '#337ab7'});
						$("#mb_id_phrase").text(code_01);
						$("#mb_id_enabled").val('y');        	
		            }
		        }
		    });
		    
		}
	}
	
}


// 비밀번호 체크 이벤트 
function pw_chk(){
	
	var pw_val=$("#mb_password").val();
	
	if( pw_val.length == 0 ){ //비밀번호 변경하지 않는 경우 (입력했다가 취소한 경우)
		
		$("#mb_password").css({ 'border': '1px solid #ccc' });
		$("#mb_password_phrase").text('');	
		$("#mb_password_enabled").val('y');
		
	}else {
		
		// 비밀번호 길이 체크 
		if( pw_val.length < 8 || pw_val.length > 15  ){
			$("#mb_password").css({ 'border': '1px solid #f22' });
	        $("#mb_password_phrase").css({ 'color': '#f22' });
			$("#mb_password_phrase").text(code_13);		
			//$("#mb_password").focus();
			$("#mb_password_enabled").val('n');
			return false;			
		}else{		
			// 문자열 체크
			var reg_upw_a = /^(?=.*[0-9])(?=.*[!@#$%^*+=-]).{8,15}$/;		// 숫자 또는 특수문자 
			var reg_upw_b = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-]).{8,15}$/;	// 문자 또는 특수문자 
			var reg_upw_c = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,15}$/; 			// 문자 또는 숫자
			var reg_upw_d = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*+=-]).{8,15}$/; 
			var reg_upw_only = /^(?=.*[a-zA-Z]).{8,15}$/; 			// 문자 또는 숫자
			var regExpPw = /(?=.*\d{1,15})(?=.*[~`!@#$%\^&*()-+=]{1,15})(?=.*[a-zA-Z]{2,15}).{8,15}$/;
	
			// 연속된 문자 숫자    	
			var regexp =  /(\w)\1\1/;
	
			if( pw_val.match(regexp) ){
				$("#mb_password").css({'border': '1px solid #f22'});
	        	$("#mb_password_phrase").css({'color': '#f22'});
	        	$("#mb_password_phrase").text(code_15);
	        	//$("#mb_password").focus();
	        	$("#mb_password_enabled").val('n');
				return false;	
			}
	
			// 정규식 영문 숫자 특수 2개 이상 
			//if( !reg_upw_a.test(pw_val) && !reg_upw_b.test(pw_val) && !reg_upw_c.test(pw_val) ){
			if( !reg_upw_d.test(pw_val) ){
				$("#mb_password").css({'border': '1px solid #f22'});
	        	$("#mb_password_phrase").css({'color': '#f22'});
	        	// 영문만 사용 했을 경우 
	        	/*if( reg_upw_only.test(pw_val) ){
	        		$("#mb_password_phrase").text(code_18);		
				}else{
					$("#mb_password_phrase").text(code_14);		
				}*/
				$("#mb_password_phrase").text("비밀번호는 영자,숫자,특수문자 중 3가지 이상을 사용해야 합니다.");
				//$("#mb_password").focus();
				$("#mb_password_enabled").val('n');
			    return false;		    
			}
	
			// 보안 수준 (정규식 2개 또는 3개 사용시)			
			if( reg_upw_d.test(pw_val) ){
				$("#mb_password").css({'border': '1px solid #337ab7'});
		        $("#mb_password_phrase").css({'color': '#337ab7'});
				$("#mb_password_phrase").text(code_11);	
				$("#mb_password_enabled").val('y');
			}else{
				$("#mb_password").css({'border': '1px solid #337ab7'});
		        $("#mb_password_phrase").css({'color': '#337ab7'});
				$("#mb_password_phrase").text(code_12);
				$("#mb_password_enabled").val('y');
			}
			
			// 보안취약 (너무 쉬운 비밀번호에 경우) /* pass */
		}
		
	}
}

// 비밀번호 확인 체크 이벤트
function pw_chk_overlap(){
	
	var pw_val = $("#mb_password").val();
	var pw_val_chk = $("#mb_password_chk").val();

	if( pw_val_chk.length < 1 )  {
		$("#mb_password_chk").css({'border': '1px solid #f22'});
	    $("#mb_password_chk_phrase").css({'color': '#f22'});
		$("#mb_password_chk_phrase").text(code_16);
		return false;
		}else{
		// 비밀번호와 비밀번호 확인 매치
		if( pw_val!=pw_val_chk ){
			$("#mb_password_chk").css({'border': '1px solid #f22'});
	        $("#mb_password_chk_phrase").css({'color': '#f22'});
			$("#mb_password_chk_phrase").text(code_16);
			return false;
		}else{
			$("#mb_password_chk").css({'border': '1px solid #337ab7'});
	        $("#mb_password_chk_phrase").css({'color': '#337ab7'});
			$("#mb_password_chk_phrase").text(code_10);
			$("#mb_password_chk_enabled").val('y');
		}
	}
}

// 이름 체크 이벤트
function name_chk() {
	
	var name_val = $("#mb_name").val();
	
	// 이름 길이 검사 2자 이상
	if( name_val.length < 2 ){
		$("#mb_name").css({'border': '1px solid #f22'});
	    $("#mb_name_phrase").css({'color': '#f22'});
		$("#mb_name_phrase").text("이름을 입력해 주세요");	
		return false;
		
	}else{
		
		// jquery 용 
		$.ajax({
		    type: 'POST',
		    url: g4_url+"/../bbs/m_ajax_member_name_check.php",   // web용 ajax 사용 
		   //url: g4_url+"/"+g4_bbs+"/ajax_member_name_check.php",
		    data: { mb_name : name_val },
		    success: function (data) {
		    	//alert(data);
		    	if( data=='ok'){
		    		// 별명 가능 
		    		$("#mb_name").css({'border': '1px solid #337ab7'});
		    	    $("#mb_name_phrase").css({'color': '#337ab7'});
		    		$("#mb_name_phrase").text('');
		    		name_hangul=1;
		    	}else if( data=='fail' ){
		    		// 별명 중복 
		 			$("#mb_name").css({'border': '1px solid #f22'});
			        $("#mb_name_phrase").css({'color': '#f22'});
			        $("#mb_name_phrase").text("이름은 한글/영문만 가능합니다");
					return false;
		    	}else if( data=='overlap' ){
		    		// 별명 중복 
		 			$("#mb_name").css({'border': '1px solid #f22'});
			        $("#mb_name_phrase").css({'color': '#f22'});
					$("#mb_name_phrase").text("사용하실 수 없는 이름입니다");
					return false;					
		    	}else{
		    		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
	 		    	//alert('실패 : '+status);
	 		    	return false;
		    	}
		    },
		    error: function (request, status, error) {
		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
		    	//alert('실패 : '+status);
		    	return false;
		    }
		});
	}
}

// 별명 체크 이벤트
function nickChkEvent() {
	
	var nick_val = $("#mb_nick").val();
	
	// 별명 길이 검사 한자 이상
	if( nick_val.length < 1 ){
		$("#mb_nick").css({'border': '1px solid #f22'});
	    $("#mb_nick_phrase").css({'color': '#f22'});
		$("#mb_nick_phrase").text("별명을 입력해 주세요.");
		return false;
	}

	// 별명 기본 금지 설정 검사   
	var nick_chk = prohibit_id_check(nick_val);
	
	// 기본 금지 설정 별명 일 경우  
	if( nick_chk ){
		$("#mb_nick").css({'border': '1px solid #f22'});
		$("#mb_nick_phrase").css({'color': '#f22'});
		$("#mb_nick_phrase").text(code_24);
		return false;
		
	// 금지 별명이 아닐 경우  
	}else{
	
		// 별명 ajax 검사 
		
		// 스크립트 용 
		//AjaxRequest( g4_url+"/ajax_member_nick_check.php?mb_nick="+nick_val);
		
		// jquery 용 
		$.ajax({
		    type: 'POST',
		    url: g4_url+"/../bbs/m_ajax_member_nick_check.php",
		    data: { mb_nick : nick_val, status : 0 },
		    success: function (data) {
		    	//alert(data);
		    	if( data=='ok'){
		    		// 별명 가능 
		 			$("#mb_nick").css({'border': '1px solid #337ab7'});
			        $("#mb_nick_phrase").css({'color': '#337ab7'});
					$("#mb_nick_phrase").text('');
					$("#mb_nick_enabled").val(nick_val);
		    	}else if( data=='fail' ){
		    		// 별명 중복 
		 			$("#mb_nick").css({'border': '1px solid #f22'});
			        $("#mb_nick_phrase").css({'color': '#f22'});
					$("#mb_nick_phrase").text(code_24);
					return false;
		    	}else{
		    		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
	 		    	//alert('실패 : '+status);
	 		    	return false;
		    	}
		    },
		    error: function (request, status, error) {
		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
		    	//alert('실패 : '+status);
		    	return false;
		    }
		});
	}
}


// 모바일 체크 이벤트
function mobile_chk() {
	
	var mobile_val =  $("#mb_hp").val().trim();
	var reg_mobile = /^[0-9]*$/;
	
	if( mobile_val.length < 10 ){
		
		$("#mb_hp").css({'border': '1px solid #f22'});
		$("#mb_hp_phrase").css({'color': '#f22'});
		$("#mb_hp_phrase").text(code_25);
		return false;	
		
	}else{
		
	if( !reg_mobile.test(mobile_val) ){
 			$("#mb_hp").css({'border': '1px solid #f22'});
	        $("#mb_hp_phrase").css({'color': '#f22'});
			$("#mb_hp_phrase").text(code_23);
			return false;
 		}else{
 			
 			//휴대폰 상태
 			var phone_num = new Array();
	 			phone_num.push("010");
	 			phone_num.push("016");
	 			phone_num.push("011");
	 			phone_num.push("017");
	 			phone_num.push("018");
	 			phone_num.push("019");
	 			
 			var first_number = mobile_val.substr(0,3);
 			
 			var status = -1;
 			 
 			for (var i=0; i<phone_num.length; i++) {
 			    if(phone_num[i] == first_number) {
 			    	status = 1;
 			        break;
 			    }
 			}
 			
 			if( status == -1 ){
 				 	 				
 				$("#mb_hp").css({'border': '1px solid #f22'});
		        $("#mb_hp_phrase").css({'color': '#f22'});
				$("#mb_hp_phrase").text(code_21);
				return false;
 			}else{
 				
 				$("#mb_hp").css({'border': '1px solid #337ab7'});
		        $("#mb_hp_phrase").css({'color': '#337ab7'});
		        if( auth_time==0 ){
		        	$("#mb_hp_phrase").text('');
		        }
				return true;
 			}	
 		}
	}	
}


function movileCertifyEvent(status) {
	// 인증 이벤트 
	var hp_chk=$("#mb_hp_chk").val();
	var hp_num=$("#mb_hp").val();
	auth_number = $("#auth_number").val();
	
	if( auth_number!='' && status==1 ){
		
		chk_auth_number=hex_md5(hp_chk);
		
		/* 테스트용 
		if( g4_url !='http://www.rankingdak.com/m' ){
			//chk_auth_number=hex_md5(hp_chk)+'/'+hp_chk;
			chk_auth_number=hex_md5(hp_chk);
		}*/
				
		if( chk_auth_number!=auth_number ){
			$("#mb_hp_chk").css({'border': '1px solid #f22'});
			$("#mb_hp_chk_phrase").css({'color': '#f22'});
			$("#mb_hp_chk_phrase").text("인증 번호가 맞지 않습니다.");
			//$("#mb_hp_chk_phrase").text(hex_md5(hp_chk)+'/'+auth_number);
			return false;
		}else{
			
			// 카운트 stop
			$("#timer").countdown('pause');
			$("#timer").text('');
			auth_time=0;
			
			// 변경 
			$("#mb_hp_chk").prop('readonly',true);
			$("#mb_hp").prop('readonly',true);
			
			$("#send_mobile").hide();
			$("#send_chk").hide();
			$(".join_input_span2").hide();
			
			$("#mb_hp").css({
				'background': '#f9f9f9',
				'border': '1px solid #337ab7'
			});
			
			$("#mb_hp_chk").css({
				'background': '#f9f9f9',
				'border': '1px solid #337ab7'
			});
			$("#mb_hp_phrase").text('');
			$("#mb_hp_chk_phrase").css({'color': '#337ab7'});
			$("#mb_hp_chk_phrase").text("인증이 확인 되었습니다.");
			$("#mb_hp_enabled").val('y');
			
			
			$.ajax({
			 	type: 'POST',
	 		    url: "/bbs/ajax_member_mobile_change.php",
	 		    data: { status:1, mb_hp : hp_num },  //status :: 0 가입  :: 1 정보수정
	 		    success: function (data) {
	 		    	
	 		    }
			});
				
		}
	}else{
		//alert("인증번호를 받아 올 수 없습니다.");
		$("#mb_hp_chk").css({'border': '1px solid #f22'});
		$("#mb_hp_chk_phrase").css({'color': '#f22'});
		
		if( auth_count==0 ){
			$("#mb_hp_chk_phrase").text("인증번호 확인 후에 휴대폰 인증을 해주세요");
		}else{
			$("#mb_hp_chk_phrase").text("재전송 후에 휴대폰 인증을 해주세요");
		}
		
	}
}


// 이메일 체크 이벤트 
function emailChkEvent2(id){
	
	var mb_email = $("#mb_email").val();
	var email_address_val = $("#mb_email2").val();
	
	if( mb_email=='' ){	
		$("#mb_email").css({'border': '1px solid #f22'});
		//$("#email_address").css({'border': '1px solid #f22'});
		$("#email_address_select").css({'border': '1px solid #f22'});
		$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
	    $("#email_phrase").css({'color': '#f22'});
		$("#email_phrase").text(code_22);
		$("#mb_email_enabled").val('n');
		return false;
	}else{
	
		var email_info = mb_email+'@'+email_address_val;
		var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
		
		/*if ( email_info==$("#defalut_email").val() ){
					
			$("#email_id").css({'border': '1px solid #ddd'});
			$("#email_address").css({'border': '1px solid #ddd'});
			
		}else{*/
			
		if( regex.test(email_info) === false ){
			$("#mb_email").css({'border': '1px solid #f22'});
			$("#email_address").css({'border': '1px solid #f22'});
			$("#email_address_select").css({'border': '1px solid #f22'});
			$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
	        $("#email_phrase").css({'color': '#f22'});
			$("#email_phrase").text(code_22);
			$("#mb_email_enabled").val('n');
			return false;
		}else{
			
			$("#email_id").css({'border': '1px solid #ddd'});
			$("#email_address").css({'border': '1px solid #ddd'});
			$("#email_address_select").css({'border': '1px solid #ddd'});
			$(".join_info_email_box .ui-select").css({'border': '1px solid #ddd'});
	        $("#email_phrase").css({'color': '#494949'});
			$("#email_phrase").text('');
			$("#mb_email_enabled").val('y');
			
			if( email_info!='' ){
							
				/*$.ajax({
		 		    type: 'POST',
		 		    url: g4_url+"/../bbs/m_ajax_member_email_check.php",
		 		    //url: g4_url+"/"+g4_bbs+"/ajax_member_email_check.php",
		 		    data: { mb_email : email_info, auth : hex_md5(email_info) },
		 		    success: function (data) {
		 		    	//alert(data);
		 		    	if( data=='ok'){
		 		    		// 이메일 가능
		 		 			$("#email_id").css({'border': '1px solid #337ab7'});
		 		 			$("#email_address").css({'border': '1px solid #337ab7'});
		 		 			$("#email_address_select").css({'border': '1px solid #337ab7'});
		 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #337ab7'});
		 			        $("#email_phrase").css({'color': '#337ab7'});		 			        
		 					$("#email_phrase").text('');
		 					$("#mb_email").val(email_info);
		 					$("#mb_email_enabled").val('y');
		 					
		 		    	}else if( data=='fail'){
		 		    		// 이메일 중복 
		 		 			$("#email_id").css({'border': '1px solid #f22'});
		 		 			$("#email_address").css({'border': '1px solid #f22'});
		 		 			$("#email_address_select").css({'border': '1px solid #f22'});
		 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
		 			        $("#email_phrase").css({'color': '#f22'});
		 					$("#email_phrase").text("중복된 이메일 주소 입니다.");
		 					return false;
		 		    	}else{
		 		    		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
			 		    	//alert('실패 : '+status);
			 		    	return false;
		 		    	}
		 		    },
		 		    error: function (request, status, error) {
		 		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
		 		    	//alert('실패 : '+status);
		 		    	return false;
		 		    }
		 		});*/
			}
		}
			
	}
}


// 이메일 체크 이벤트 
function emailChkEvent(id){
	
	var email_id_val = $("#email_id").val();
	var email_address_val = $("#mb_email2").val();
	
	if( id=='id' ){
		
		if( email_id_val!='' && email_address_val!='' ){	
			var email_info = email_id_val+'@'+email_address_val;
			var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
				
			if( regex.test(email_info) === false ){
				$("#email_id").css({'border': '1px solid #f22'});
				$("#email_address").css({'border': '1px solid #f22'});
				$("#email_address_select").css({'border': '1px solid #f22'});
				$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
		        $("#email_phrase").css({'color': '#f22'});
				$("#email_phrase").text(code_22);
				return false;
			}else{
				$("#email_id").css({'border': '1px solid #ddd'});
				$("#email_address").css({'border': '1px solid #ddd'});
				$("#email_address_select").css({'border': '1px solid #ddd'});
				$(".join_info_email_box .ui-select").css({'border': '1px solid #ddd'});
		        $("#email_phrase").css({'color': '#494949'});
				$("#email_phrase").text('');
				if( email_info!='' ){
								
					$.ajax({
			 		    type: 'POST',
			 		    url: g4_url+"/../bbs/m_ajax_member_email_check.php",
			 		    //url: g4_url+"/"+g4_bbs+"/ajax_member_email_check.php",
			 		    data: { mb_email : email_info, auth : hex_md5(email_info) },
			 		    success: function (data) {
			 		    	//alert(data);
			 		    	if( data=='ok'){
			 		    		// 이메일 가능
			 		 			$("#email_id").css({'border': '1px solid #337ab7'});
			 		 			$("#email_address").css({'border': '1px solid #337ab7'});
			 		 			$("#email_address_select").css({'border': '1px solid #337ab7'});
			 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #337ab7'});
			 			        $("#email_phrase").css({'color': '#337ab7'});		 			        
			 					$("#email_phrase").text('');
			 					$("#mb_email").val(email_info);
			 					$("#mb_email_enabled").val('y');
			 					
			 		    	}else if( data=='fail'){
			 		    		// 이메일 중복 
			 		 			$("#email_id").css({'border': '1px solid #f22'});
			 		 			$("#email_address").css({'border': '1px solid #f22'});
			 		 			$("#email_address_select").css({'border': '1px solid #f22'});
			 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
			 			        $("#email_phrase").css({'color': '#f22'});
			 					$("#email_phrase").text("중복된 이메일 주소 입니다.");
			 					return false;
			 		    	}else{
			 		    		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
				 		    	//alert('실패 : '+status);
				 		    	return false;
			 		    	}
			 		    },
			 		    error: function (request, status, error) {
			 		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
			 		    	//alert('실패 : '+status);
			 		    	return false;
			 		    }
			 		});
				}
			}
			
		}
		
	}else{
		
		if( email_id_val=='' || email_address_val=='' ){	
			$("#email_id").css({'border': '1px solid #f22'});
			$("#email_address").css({'border': '1px solid #f22'});
			$("#email_address_select").css({'border': '1px solid #f22'});
			$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
		    $("#email_phrase").css({'color': '#f22'});
			$("#email_phrase").text(code_22);
			return false;
		}else{
		
			var email_info = email_id_val+'@'+email_address_val;
			var regex=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/; 
			
			/*if ( email_info==$("#defalut_email").val() ){
						
				$("#email_id").css({'border': '1px solid #ddd'});
				$("#email_address").css({'border': '1px solid #ddd'});
				
			}else{*/
				
				if( regex.test(email_info) === false ){
					$("#email_id").css({'border': '1px solid #f22'});
					$("#email_address").css({'border': '1px solid #f22'});
					$("#email_address_select").css({'border': '1px solid #f22'});
					$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
			        $("#email_phrase").css({'color': '#f22'});
					$("#email_phrase").text(code_22);
					return false;
				}else{
					
					$("#email_id").css({'border': '1px solid #ddd'});
					$("#email_address").css({'border': '1px solid #ddd'});
					$("#email_address_select").css({'border': '1px solid #ddd'});
					$(".join_info_email_box .ui-select").css({'border': '1px solid #ddd'});
			        $("#email_phrase").css({'color': '#494949'});
					$("#email_phrase").text('');
					
					if( email_info!='' ){
									
						$.ajax({
				 		    type: 'POST',
				 		    url: g4_url+"/../bbs/m_ajax_member_email_check.php",
				 		    //url: g4_url+"/"+g4_bbs+"/ajax_member_email_check.php",
				 		    data: { mb_email : email_info, auth : hex_md5(email_info) },
				 		    success: function (data) {
				 		    	//alert(data);
				 		    	if( data=='ok'){
				 		    		// 이메일 가능
				 		 			$("#email_id").css({'border': '1px solid #337ab7'});
				 		 			$("#email_address").css({'border': '1px solid #337ab7'});
				 		 			$("#email_address_select").css({'border': '1px solid #337ab7'});
				 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #337ab7'});
				 			        $("#email_phrase").css({'color': '#337ab7'});		 			        
				 					$("#email_phrase").text('');
				 					$("#mb_email").val(email_info);
				 					$("#mb_email_enabled").val('y');
				 					
				 		    	}else if( data=='fail'){
				 		    		// 이메일 중복 
				 		 			$("#email_id").css({'border': '1px solid #f22'});
				 		 			$("#email_address").css({'border': '1px solid #f22'});
				 		 			$("#email_address_select").css({'border': '1px solid #f22'});
				 		 			$(".join_info_email_box .ui-select").css({'border': '1px solid #f22'});
				 			        $("#email_phrase").css({'color': '#f22'});
				 					$("#email_phrase").text("중복된 이메일 주소 입니다.");
				 					return false;
				 		    	}else{
				 		    		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
					 		    	//alert('실패 : '+status);
					 		    	return false;
				 		    	}
				 		    },
				 		    error: function (request, status, error) {
				 		    	alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
				 		    	//alert('실패 : '+status);
				 		    	return false;
				 		    }
				 		});
					}
				}
				
			//}
		}	
	}
}

// 엔터 이벤트 

function EnterEvent(type){
	// 엔터 감지
    if(event.keyCode == 13){
    	return false;
	}
}


// 생년월일 이벤트
function birthEvent(){
	
	$("#mb_birth").val('');
	
	// 생년월일 빈값 체크 
	if( $("#mb_birth_year").val()=='' ){
		$("#birth_year").focus();
		return false;
	}else if( $("#mb_birth_month").val()=='' ){
		$("#birth_month").focus();
		return false;
	}else if( $("#mb_birth_day").val()=='' ){
		$("#birth_day").focus();
		return false;
	}else{
		// 생년월일 체크해서 년/월/일 전부 있을 경우 정규식으로 변경 저장
		if( $("#mb_birth_year").val()!='' && $("#mb_birth_month").val()!='' && $("#mb_birth_day").val()!=='' ){
			var mb_birth=$("#mb_birth_year").val()+'-'+$("#mb_birth_month").val()+'-'+$("#mb_birth_day").val();
			$("#mb_birth").val(mb_birth);
			$("#birth_phrase").text('');
		}
	}
}

// 성별 체크 이벤트
function select_gender(gender){

	//alert(gender);
	var chked_url = g4_url+'/images/join/select_btn2.png';
	var unchk_url = g4_url+'/images/join/select_btn1.png';

	if (gender=='F') {

		$("#male").find('img').attr('src',unchk_url);
		$("#female").find('img').attr('src',chked_url);
		//$("#male").next().css( "color" , "#494949" );
		//$("#female").next().css( 'color' , '#ff6001' );
		$("#mb_sex").val(gender);
	
	}else if (gender=='M'){

		$("#female").find('img').attr('src',unchk_url);
		$("#male").find('img').attr('src',chked_url);
		//$("#female").next().css( 'color' , '#494949' );
		//$("#male").next().css( 'color' , '#ff6001' );
		$("#mb_sex").val(gender);
	}else{
		alert("페이지에 오류가 있습니다 관리자에게 문의하세요.");
	}
}

//이메일 직접 입력시 
function emailAddressChange(addr){
	
	if( addr=='direct' ){
		$("#mb_email_enabled").val('');
		$("#email_address_select").hide();
		$(".join_info_email_box .ui-select").hide();
		$("#email_address").attr('type','text');
		$("#email_address").show();
		$("#email_address").focus();
		
		$("#email_id").css({'border': '1px solid #ddd'});
		$("#email_address").css({'border': '1px solid #ddd'});
		$("#email_address_select").css({'border': '1px solid #ddd'});
        $("#email_phrase").css({'color': '#494949'});
		$("#email_address").val('');
		
	}else{
		$("#mb_email_enabled").val('');
		$("#email_address").val(addr);
		//emailChkEvent();
	}
	
}




/***

스크립트 용 ajax

***/

var httpRequest;

function AjaxRequest(url) {
	if (window.XMLHttpRequest) { // Mozilla, Safari, ...
		httpRequest = new XMLHttpRequest();
	} else if (window.ActiveXObject) { // IE
		try {
			httpRequest = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			try {
				httpRequest = new ActiveXObject("Microsoft.XMLHTTP");
			} catch (e) {
			}
		}
	}

	if (!httpRequest) {
		alert('Giving up :( Cannot create an XMLHTTP instance');
		return false;
	}
	httpRequest.onreadystatechange = alertContents;
	httpRequest.open('GET', url);
	httpRequest.send();
}

function alertContents() {
	var res = httpRequest.responseText;
	if (httpRequest.readyState === 4) {
		if (httpRequest.status === 200) {
			alert(httpRequest.responseText);
		} else {
			//alert('There was a problem with the request.');
			alert('페이지에 오류가 있습니다.');
		}
	}
}

