<%@page import="com.matdak.dao.JumunDAO"%>
<%@page import="com.matdak.dto.JumunDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.matdak.dto.HewonDTO"%>
<%@page import="com.matdak.dto.ReviewDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.matdak.dao.ReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
//검색대상과 검색단어를 반환받아 저장
	String reviewSearch = request.getParameter("reviewSearch");
	String reviewKeyword = request.getParameter("reviewKeyword");
	if(reviewSearch==null){
		reviewSearch="";
	}
	if(reviewKeyword==null){
		reviewKeyword="";
	}
	//System.out.println("reviewSearch = "+reviewSearch+", reviewKeyword = "+reviewKeyword);

	//페이징처리 관련 요청페이지번호를 반환받아 저장
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	//하나의 페이지에 출력될 리뷰갯수 설정
	int pageSize = 5;
	
	//검색 관련 정보를 전달받아 REVIEW 테이블에 저장된 특정 리뷰게시물의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출		
	int totalReview = ReviewDAO.getDAO().selectReviewCount(reviewSearch, reviewKeyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage = (int)Math.ceil((double)totalReview/pageSize);	
	//요청페이지번호 검증 - 비정상적인 요청
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}	
	//시작행과 종료행을 계산하여 저장
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totalReview){
		endRow=totalReview;
	}	
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료게시글의 행번호를 전달받아
	//REVIEW 테이블에 저장된 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 DAO클래스의 메소드 호출
	List<ReviewDTO> reviewList = ReviewDAO.getDAO().selectReviewList(startRow, endRow, reviewSearch, reviewKeyword);
		
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	HewonDTO loginHewon = (HewonDTO) session.getAttribute("loginHewon");
	//System.out.println(loginHewon.gethStatus());
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청페이지에 검색되어 출력될 시작 게시글의 일련번호에 대한 시작값을 계산하여 저장
	int printNum = totalReview-(pageNum-1)*pageSize;
		
	//페이징 처리
	//하나의 페이지 블럭에 출력될 페이지 번호의 갯수 설정
	int blockSize = 5;

	//페이지 블럭에 출력될 시작 페이지 번호를 계산하여 저장
	int StartPage=(pageNum-1)/blockSize*blockSize+1;
	
	//페이지블럭에 출력될 종료 페이지 번호를 계산하여 저장
	int endPage=StartPage+blockSize-1;
	//마지막페이지 블럭의 종료 페이지 번호 변경
	if(endPage>totalPage){
		endPage=totalPage;
	}
%>

<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.2/css/all.min.css"
	integrity="sha512-1sCRPdkRXhBV2PBLUdRb4tMg1w2YPf37qatUFeS7zlBy7jJI8Lf4VHwWfZZfpXtYSLy85pkm9GaYVYMfw5BC1A=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<style type="text/css">
.customer-head-title {
	text-align: center;
}

.customer-head-title .customer-sub-title {
	padding: 40px;
	border-bottom: 1px solid #ccc;
}

.customer-head-title .customer-sub-content {
	padding: 20px 10px;
	border-bottom: 1px solid #ccc;
}

#reviewSearchForm .review-reviewKeyword {
	width: 100%;
	padding: 8px 0px;

}
#reviewSearchForm .review-reviewSearchRadio {
	width: 100%;
	padding: 8px 0px;
	display: flex;
	justify-content: space-around;
}

#reviewSearchForm .review-reviewSearchBtn {
	width: 100%;
	padding: 8px 0px;
}
#reviewSearchForm .review-reviewSearchBtn button{
	background-color: transparent;
    border-style: none;
    padding: 5px;
    border: 1px solid #ccc;
    border-radius: 10px;
}
.review-paging-box{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}
.review-box {
	border-bottom: 1px solid #ccc;
	padding: 10px;
}

.review-box>span {
	margin-left: 5px;
	font-size: 0.8em;
}

.reveiw-content {
	padding: 10px 0px;
}

#reviewSearchForm {
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	text-align: center;
	width: 70%;
	margin: 10px auto;
	border: 1px solid #ccc;
	border-radius: 20px;
}

<%for(ReviewDTO review:reviewList){%>
#review-image-<%=review.getrCode()%> {
	display: none;
}
<%}%>

.moreBtn{
	background-color: transparent;
    border-style: none;
}
.clicked{
    transform: rotate(180deg);
    transition: transform 300ms ease-in-out;
}
.review-pName{
	display:inline-block; 
	border:1px solid #CCC; 
	border-radius: 5px; 
	font-size: 13px; 
	padding: 4px;
	text-align: center;
}
.review-secret{
	display:inline-block; 
	width: 30px; 
	border:1px solid red; 
	border-radius: 5px; 
	font-size: 10px; 
	padding: 2px;
	text-align: center;
}

.review-Pimage-content{
	display: flex;
	align-items: center;
}
.review-Pimage{
	position: relative;
	width: 100px;
	height:100px;
	margin-right: 10px; 
}
.review-Pimage>img{
	position: relative;
	max-width: 100%;
}
</style>


<!-- 구매후기 title -->
<div class="customer-head-title">
	<div class="customer-sub-title">구매후기 <span style="color:red;">(<%=totalReview%>)</span></div>	
	<div class="customer-sub-content">
	<p style="text-align: left; line-height: 1.5em; font-size:0.7rem;">
	· 맛있닭은 믿을 수 있는 후기관리를 위해 회원으로 가입되신 실제 구매자만 후기를 작성하실 수 있습니다.<br>
    · 구매하신 상품을 받으신 후, 10일 이내 후기를 남겨주시면 최대 100P가 적립됩니다.<br>
	· 상품과 관련 없는 후기 혹은 욕설, 비방, 부적절한 단어, 문의글, 양도글, 광고성, 도배, 환불처리된 주문, 개인정보가 포함된 후기는 예고없이 블라인드 처리 될 수 있습니다.</p>
	</div>
</div>
<%
JumunDTO jumun=null;
	if(loginHewon!=null){
		jumun = JumunDAO.getDAO().selectJumun(loginHewon.gethId());		
	}
%>

<%
if(loginHewon==null){
%>
	<div style="font-size: 15px; color: red;">로그인을 해야 구매후기 작성이 가능합니다.</div>
	<button type="button" id="writeBtn" style="font-size:15px; margin:10px;" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=hewon&work=hewon_login';">구매후기 작성</button>
<%
} else if(jumun==null){
%>	
	<div style="font-size: 15px; color: red;">구매후기를 작성할 제품이 없습니다.</div>
	<button type="button" id="writeBtn" style="font-size:15px; margin:10px;">구매후기 작성</button>
<%
} else {
%>
	<%
	if(loginHewon!=null && (loginHewon.gethId().equals(jumun.getjId()) || loginHewon.gethStatus()!=9)){
	%>
		<%-- [구매후기 작성]버튼 : 로그인회원 중 구매자이거나 관리자에게만 권한 부여  --%>
		<div style="font-size: 15px; color: blue;">구매한 제품에 대한 후기를 작성할 수 있습니다.</div>
		<button type="button" id="writeBtn" style="font-size:15px; margin:10px;" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review_write';">구매후기 작성</button>
	<%
	}
	%>	
<%
	}
	%>	

<%-- 서칭 form태그 --%>
<form action="<%=request.getContextPath()%>/index.jsp" method="get" id="reviewSearchForm">	
	<input type="hidden" name="workgroup" value="board">
	<input type="hidden" name="work" value="review">
	
	<%-- 카테고리별 체크박스 --%>
	<div class="review-reviewKeyword">
		<label for="review-reviewKeyword">
		<input type="text" id="review-reviewKeyword" name="reviewKeyword" style="width: 300px; height: 40px; text-align: center;" placeholder="구매후기를 검색하세요.">
		</label>
	</div>

	<div class="review-reviewSearchRadio">
		<label for="review-radio-1">
		<input type="radio" name="reviewSearch" id="review-radio-1" value="highDate"<%if(reviewSearch.equals("highDate")){%> checked="checked" <%}%>>
			<span style= "font-size: 16px;">&nbsp;최신순&nbsp;&nbsp;</span>
		</label>
		<label for="review-radio-2">
		<input type="radio" name="reviewSearch" id="review-radio-2" value="lowDate" <%if(reviewSearch.equals("lowDate")){%> checked="checked" <%}%>>
			<span style= "font-size: 16px;">&nbsp;오래된순&nbsp;&nbsp;</span>
		</label>
		<label for="review-radio-3">
		<input type="radio" name="reviewSearch" id="review-radio-3" value="highStar" <%if(reviewSearch.equals("highStar")){%> checked="checked" <%}%>>
			<span style= "font-size: 16px;">&nbsp;별점 높은순&nbsp;&nbsp;</span>
		</label>
		<label for="review-radio-4">
		<input type="radio" name="reviewSearch" id="review-radio-4" value="lowStar" <%if(reviewSearch.equals("lowStar")){%> checked="checked" <%}%>>
			<span style= "font-size: 16px;">&nbsp;별점 낮은순&nbsp;&nbsp;</span>
		</label>
	</div>
	<div class="review-reviewSearchBtn"><button type="submit" style="font-size:16px;">검색</button></div>
</form>

<%-- 페이징 처리--%>
<div class="review-paging-box">
<%
if(StartPage>blockSize) {
%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=StartPage-blockSize%>&reviewSearch=<%=reviewSearch%>&reviewKeyword=<%=reviewKeyword%>">[이전]</a>
<%
} else{
%>
	<span style="color: gray;">[이전]</span>
<%
}
%>

<%
for(int i=StartPage; i<=endPage; i++) {
%>
	<%
	if(pageNum!=i){
	%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=i%>&reviewSearch=<%=reviewSearch%>&reviewKeyword=<%=reviewKeyword%>">[<%=i%>]</a>
	<%
	} else {
	%>
		<span style="font-weight: 900">[<%=i%>]</span>
	<%
	}
	%>
<%
}
%>

<%
if(endPage!=totalPage){
%>
	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=review&pageNum=<%=StartPage+blockSize%>&reviewSearch=<%=reviewSearch%>&reviewKeyword=<%=reviewKeyword%>">[다음]</a>
<%
} else{
%>
	<span style="color: gray;">[다음]</span>
<%
}
%>
</div>	


<%-- 구매후기 list 반복문처리--%>
<%
for(ReviewDTO review:reviewList){
%>
	<%--권한 : 일반글,비밀글 --%>
	<%if(review.getrStatus()==1 || review.getrStatus()==2){ %>
		<div class="review-box">
			<%-- 리뷰별점 --%>
			<span class="review-star">
			<%if(review.getrStar()==1){ %>
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
			<%}else if(review.getrStar()==2){ %>
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
			<%}else if(review.getrStar()==3){ %>
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
			<%}else if(review.getrStar()==4){ %>
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star_off.png">
			<%}else if(review.getrStar()==5){ %>
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
				<img style="display:inline;" src="<%=request.getContextPath() %>/board/review_image/star.png">
			<%}%>
			</span>
			<%--별점 점수 --%>
			<span><%=review.getrStar() %>.0</span>
		
			<%--작성자 아이디 --%>
			<span class="review-id"><%=review.getrId().substring(0, 3)+"****" %></span>
			<span>|</span>
			<%-- 작성날짜 --%>
			<span class="review-date"><%=review.getrDate().substring(0,10) %></span>
			<%-- 리뷰 카테고리 --%>
			<div class="review-pName">
				<%=review.getrPname() %>
			</div>
			
			<%-- 비밀글 표시 --%>
			<% if(review.getrStatus()==2){ %><div class="review-secret">비밀글</div><%}%>
			
			<%-- 로그인회원 중 작성자이거나 관리자에게만 버튼 제공 --%>
			<%-- [수정] [삭제]버튼 --%>
			<% if (loginHewon!=null && (loginHewon.gethId().equals(review.getrId()) ||loginHewon.gethStatus()==9)) { %>	
			<button type="button" id="review-modifyBtn-<%=review.getrCode() %>" style="font-size:15px; margin-right:1px;">수정</button>
			<button type="button" id="review-removeBtn-<%=review.getrCode() %>" style="font-size:15px;">삭제</button>
			<% } %>
			
			<form action="<%=request.getContextPath()%>/index.jsp" method="get" id="menuForm">
			<input type="hidden" name="workgroup" value="board">
			<input type="hidden" name="work" id="work">	
			<input type="hidden" name="rCode" value="<%=review.getrCode()%>">
			<input type="hidden" name="pageNum" value="<%=pageNum%>">
			<input type="hidden" name="reviewSearch" value="<%=reviewSearch%>">
			<input type="hidden" name="reviewKeyword" value="<%=reviewKeyword%>">	
			</form>
			
			<%--리뷰할 이미지와 리뷰내용 --%>
			<div class="review-Pimage-content">
				<%--리뷰할 제품 이미지 --%>
				<a href="<%=request.getContextPath() %>/index.jsp?workgroup=shop&work=product_detail&pNo=<%=review.getrPno() %>" class="review-Pimage">
				<img src="<%=request.getContextPath() %>/product_image/<%=review.getrPimg() %>" alt="제품이미지(맛닭제공)" />
				</a>
				<%-- 리뷰내용 --%>	
				<div class="reveiw-content" id="<%=review.getrCode()%>">
					<%if(review.getrStatus()==1){ %>
					<p style="font-size: 16px;"><%=review.getrContent() %></p>
					<%} else if(review.getrStatus()==2){ %>
						<%if(loginHewon!=null && (loginHewon.gethId().equals(review.getrId()) ||loginHewon.gethStatus()==9)){ %>			
							<p style="font-size: 16px;"><%=review.getrContent() %></p>
						<%} else { %>
							<p style="font-size: 16px;">작성자 혹은 관리자만 확인 가능합니다.</p>
						<%} %>	
					<%} %>
				</div>
			</div>
			
			
			<%if(review.getrImage()!=null){ %>
				<%--사용자가 첨부한 이미지 보기 --%>
				<div class="reveiw-moreBtn">
					<button class="moreBtn clicked" id="btn-<%=review.getrCode()%>"><i class="fas fa-caret-down" style="color: gray;"></i></button>
					<span style="font-size: 15px; color: gray;">이미지보기</span>
				</div>
				<%-- 사용자 이미지 첨부 --%>
				<div class="review-image" id="review-image-<%=review.getrCode()%>">
					<img width="300px" src="<%=request.getContextPath() %>/board/review_image/<%=review.getrImage() %>">
				</div>
			<%} %>
			
		</div>
	
	<script type="text/javascript">
	
	$("#btn-<%=review.getrCode()%>").click(function() {
		
		$("#btn-<%=review.getrCode()%>").toggleClass("clicked");
		
		if($("#review-image-<%=review.getrCode()%>").css("display")=="none"){
			$("#review-image-<%=review.getrCode()%>").css("display","block")
		} else{ 
			$("#review-image-<%=review.getrCode()%>").css("display","none")
		}
	});
	
	$("#review-modifyBtn-<%=review.getrCode()%>").click(function() {
		if(confirm("수정 하시겠습니까?")){
		$("#work").val("review_modify");
		$("#menuForm").submit();
		}
	})
	$("#review-removeBtn-<%=review.getrCode()%>").click(function() {
		if(confirm("정말로 삭제 하시겠습니까? (복구 불가능)")){
		$("#work").val("review_delete_action");
		$("#menuForm").submit();
		}
	})	
	</script>
	<%} %>
<%} %>