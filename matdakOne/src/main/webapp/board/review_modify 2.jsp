<%@page import="oracle.net.aso.j"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.matdak.dao.JumunDAO"%>
<%@page import="com.matdak.dto.JumunDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.matdak.dto.ReviewDTO"%>
<%@page import="com.matdak.dao.ReviewDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 리뷰글을 전달받아 REVIEW 테이블에 삽입하고 리뷰 출력페이지로
이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 --%> 

<%-- => 로그인 사용자 중 구매자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/login_check.jspf" %>

<%
//비정상적인 요청에 대한 응답 처리 - 리뷰 번호 없는 경우
	if(request.getParameter("rCode")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}


	//전달값을 반환받아 저장
	int rCode = Integer.parseInt(request.getParameter("rCode"));
	//System.out.println(rCode);
	
	//글번호(rCode)를 전달받아 RIVIEW 테이블에 저장된 해당 글번호의 공지사항 글을 
	//검색하는 DAO 클래스의 메소드 호출
	ReviewDTO review = ReviewDAO.getDAO().selectReview(rCode);
	/*
	//검색된 게시글이 없거나 삭제게시글인 경우 에러페이지로 이동되도록 응답 처리
	if(review==null || review.getrStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}
	*/
%>

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
<div class="content-box">
<h2 style="margin:10px; font-size: 20px">구매후기 수정</h2>
<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_modify_action" 
	method="post" id="reviewForm" enctype="multipart/form-data">
	<%-- 변경할 공지사항 이미지를 구분하기 위한 식별자로 공지사항번호 전달 --%>
	<input type="hidden" name="rCode" value="<%=rCode%>">
	<input type="hidden" name="currentImage" value="<%=review.getrImage()%>">

<%
//주문한 객체 생성
	List<JumunDTO> jumunList = new ArrayList<JumunDTO>();
	jumunList = JumunDAO.getDAO().selectJumunList(loginHewon.gethId());
%>		
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
<%
for(JumunDTO jumun:jumunList){
%>
	<tr>
		<label for="cate-<%=jumun.getjNo()%>" class="review-cate">
			<input class="review-cate-radio" type="radio" id="cate-<%=jumun.getjNo()%>" name="rJno" value="<%=jumun.getjNo()%>"
				<%if(jumun.getjNo()==review.getrJno()) {%> checked="checked" <%} %> >
			<p class="review-cate-no" ><%=jumun.getjPno() %></p>		
			<img class="review-cate-img" src="<%=request.getContextPath()%>/product_image/<%=jumun.getjPimg()%>" alt="<%=jumun.getjNo()%>">
			<p class="review-cate-name"><%=jumun.getjPname() %></p>	
			<p class="review-cate-date"><%=jumun.getjDate() %></p>
		</label>
	</tr>	
<%} %>		
</table>

	<table>	
		<tr>
			<th>별점</th>
			<td>
			<label for="star-1">
			<input type="radio" id="star-1" name="rStar" value="1" <%if(review.getrStar()==1){ %> checked="checked" <%} %>>1
			</label>
			<label for="star-2">
			<input type="radio" id="star-2" name="rStar" value="2" <%if(review.getrStar()==2){ %> checked="checked" <%} %>>2
			</label>
			<label for="star-3">
			<input type="radio" id="star-3" name="rStar" value="3" <%if(review.getrStar()==3){ %> checked="checked" <%} %>>3
			</label>
			<label for="star-4">
			<input type="radio" id="star-4" name="rStar" value="4" <%if(review.getrStar()==4){ %> checked="checked" <%} %>>4
			</label>
			<label for="star-5">
			<input type="radio" id="star-5" name="rStar" value="5" <%if(review.getrStar()==5){ %> checked="checked" <%} %>>5
			</label>
			<div id="starMsg" class="error">별점을 반드시 선택해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>내용</th>
			<td>
				<textarea  rows="7" cols="60" name="rContent" id="rContent"><%=review.getrContent() %></textarea>
				<input type="checkbox" name="rStatus" value="2" <%if(review.getrStatus()==2){ %> checked="checked" <%} %> >비밀글
				<div id="contentMsg" class="error">내용은 반드시 입력해 주세요.</div>
			</td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td>
				<div style="font-size:16px;">현재 사용하고 있는 파일명 : <%=review.getrImage() %></div>
				<input type="file" name="rImage" id="rImage">
				<div style="color:red; font-size:15px;">파일을 변경하지 않을 경우 입력하지 마세요.</div>
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


