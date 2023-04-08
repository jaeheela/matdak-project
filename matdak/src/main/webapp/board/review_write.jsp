<%@page import="xyz.itwill.dto.ReviewDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.JumunDAO"%>
<%@page import="xyz.itwill.dto.JumunDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인회원 중 구매한 회원에게 리뷰 글을 입력받기 위한 JSP 문서 --%>    
<%-- => [글저장]을 클릭한 경우 게시글 삽입페이지(review_write_action.jsp)로 이동 - 입력값 전달 --%>
<%-- => 로그인회원 중 구매자만 요청 가능한 문서 --%>
<%@include file="/security/login_url.jspf" %>

<style type="text/css">
div.content-box{
	margin: 0 auto;
	text-align: center;
}

.content-box table{
	margin: 10px auto 0;
}
.content-box th {
	width: 200px;
	font-weight: 400;
	text-align: center;
}
td {
	text-align: left;
	
}
input, textarea{
	font-size: 16px;
}

.error{
	font-size: 15px;
	font-weight: 900;
	color: red;
	display: none;
}
	
.review-cate-box>p{
	width: 100%;
	text-align: center;
	font-size:15px;
	font-weight: 900;
}

.review-cate{
	display: flex;
	align-items: center;
	position: relative;
	border: 1px solid #ccc;
	margin: 3px;
}
.review-cate-radio{
	width: 5%;
}
.review-cate-no{
	width: 10%;
	margin: 0 auto;
}
.review-cate-img{
	width: 30%;
}
.review-cate-name{
	width: 40%;
}
.review-cate-date{
	width: 15%;
}
.review-cate img{
	width: 10%;	
	margin: 0 auto;
}
</style>
<%
	//주문한 객체 생성
	List<JumunDTO> jumunList = new ArrayList<JumunDTO>();
	jumunList = JumunDAO.getDAO().selectJumunList(loginHewon.gethId());		
%>

<div class="content-box">
	<h2 style="margin:10px; font-size: 30px">구매후기 작성</h2>
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_write_action" 
		method="post" id="reviewForm" enctype="multipart/form-data">
		
	<input type="hidden" name="rDone" value="1">			
	<h3 style="margin:10px; font-size: 20px">구매 후기를 작성할 제품을 선택해주세요. <span style="color: red;">(중복 선택 불가능)</span></h3>
	<table class="review-cate-box">
		<tr>
			<div class="review-cate">
				<p class="review-cate-radio">o</p>
				<p class="review-cate-no" >구매번호</p>		
				<p class="review-cate-img" >구매제품 이미지</p>
				<p class="review-cate-name">구매제품 이름</p>	
				<p class="review-cate-date">구매날짜</p>
			</div>
		</tr>
	<%for(JumunDTO jumun:jumunList){ %>
		<tr>
			<label for="cate-<%=jumun.getjNo()%>" class="review-cate">
				<input class="review-cate-radio" type="radio" id="cate-<%=jumun.getjNo()%>" name="rJno" value="<%=jumun.getjNo()%>">
				<p class="review-cate-no" ><%=jumun.getjPno() %></p>		
				<img class="review-cate-img" src="<%=request.getContextPath()%>/product_image/<%=jumun.getjPimg()%>" alt="<%=jumun.getjNo()%>">
				<p class="review-cate-name"><%=jumun.getjPname() %></p>	
				<p class="review-cate-date"><%=jumun.getjDate() %></p>
			</label>
		</tr>	
	<%} %>		
	<div id="productMsg" class="error">리뷰할 제품을 반드시 선택해 주세요.</div>
	</table>

	<table>		
		<tr>
			<th>별점</th>
			<td>
			<label for="star-1">
			<input type="radio" id="star-1" name="rStar" value="1">1
			</label>
			<label for="star-2">
			<input type="radio" id="star-2" name="rStar" value="2">2
			</label>
			<label for="star-3">
			<input type="radio" id="star-3" name="rStar" value="3">3
			</label>
			<label for="star-4">
			<input type="radio" id="star-4" name="rStar" value="4">4
			</label>
			<label for="star-5">
			<input type="radio" id="star-5" name="rStar" value="5">5
			</label>
			<div id="starMsg" class="error">별점을 반드시 선택해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea  rows="7" cols="60" name="rContent" id="rContent"></textarea>
				<input type="checkbox" name="rStatus" value="2">비밀글
				<div id="contentMsg" class="error">내용은 반드시 입력해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td>
				<input type="file" name="rImage" id="rImage">
				<div id="imageMsg" class="error">파일을 첨부해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th colspan="2">
				<button type="submit">글저장</button>
				<button type="reset" id="resetBtn">다시쓰기</button>				
			</th>
		</tr>
	</table>
</form>
</div>

<script type="text/javascript">
$("#rContent").focus();

$("#reviewForm").submit(function() {
	
	$(".error").css("display","none");	
	var result = true;
	
	if($("input[name='rJno']:checked").length<1){
		$("#productMsg").css("display","block");
		 result=false;
	}
	if($("input[name='rStar']:checked").length<1){
		$("#starMsg").css("display","block");
		 result=false;
	}
	
	if($("#rContent").val()=="") {
		$("#contentMsg").css("display","block");
		$("#rContent").focus();
		result=false;
	}
	return result;
});

$("#resetBtn").click(function() {
	$("#rTitle").focus();
	$("#imageMsg").text("");
	$("#contentMsg").text("");
});

</script>
