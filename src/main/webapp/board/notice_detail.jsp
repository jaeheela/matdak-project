<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%-- 공지사항 세부 출력페이지 --%>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getParameter("nCode")==null){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;		
	}

	//전달값을 반환받아 저장
	int nCode = Integer.parseInt(request.getParameter("nCode"));
	String search = request.getParameter("search");
	String keyword = request.getParameter("keyword");
	String pageNum = request.getParameter("pageNum");
	//System.out.println("2.search= "+search);
	//System.out.println("keyword= "+keyword);
	//System.out.println("pageNum= "+pageNum);
	//System.out.println("=======");
	
	//글번호(nCode)를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 공지사항 글을 
	//검색하는 DAO 클래스의 메소드 호출
	NoticeDTO notice = NoticeDAO.getDAO().selectNotice(nCode);
	
	//공지사항번호를 전달받아 BOARD 테이블에 저장된 해당 공지사항의 조회수를 증가하는 DAO 클래스의 메소드 호출
	NoticeDAO.getDAO().updatenLook(nCode);
	
	//검색된 게시글이 없거나 삭제 게시글인 경우 
	if(notice==null || notice.getnStatus()==0){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}
	
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	HewonDTO loginHewon = (HewonDTO) session.getAttribute("loginHewon");

%>
<style type="text/css">
.customer-head-title { text-align: center; padding-bottom: 50px; }
.customer-head-title .customer-sub-title { padding-top: 10px; }
/* 공지사항 view content */
#notice_view_wrap{padding-bottom:40px; border-bottom:1px solid #ccc;}
#notice_view_wrap .notice_view_con_table{width:100%; border-collapse:collapse; border-top:1px solid #999;}
.notice_view_con_title_t{padding:15px;}
.notice_view_con_title_t_r{padding:15px; text-align:right;}
.notice_view_con_title_t_r span{font-size:13px;}
.notice_view_con_title_b{color:#999; padding:8px 15px; font-size:13px;}
.notice_view_con_title_b span{color:#999; font-size:13px;}
.notice_view_notice{color: #f22; border: 1px solid #f22; padding: 2px 7px; margin-right:7px;}
.notice_view_news{color: #666; border: 1px solid #666; padding: 2px 7px;  margin-right:7px;}
.notice_view_con_days_time{color:#999;}
.notice_view_inquiry{text-align:right;}
.notice_view_inquiry span{color:#999; padding-left:10px;}
.notice_view_con_tr_b{border-top:1px solid #ccc; border-bottom:1px solid #ccc;}
.notice_view_content_img img{padding-top:20px; display: block; margin: 0 auto;}
.notice_view_content_text{padding-top:30px;}

/* 공지사항 버튼 */
.notice-listBtn { background-color: #fff; border: 1px solid #f22; color: #f22; width: 200px; height: 50px; font-size: 18px; cursor:pointer;}

/* 공지사항 수정 & 삭제 버튼 */
.notice_view_con_title_b .btn_b01_modify{ background-color: #fff; border: 1px solid #999; color: #999;}
.notice_view_con_title_b .btn_b01_delete{background-color:#f22; color:#fff; border: 1px solid #f22;}
        
</style>	
<div style="width:90%; margin: 0 auto;">

	<!-- 공지사항 title -->
	<div class="customer-head-title">
		<div class="customer-sub-title">맛있닭의 중요한 공지사항과 새로운 소식을 만나보세요 :)</div>
	</div>
	<!-- 공지사항 view content -->
	<div id="notice_view_wrap">
		<div>
			<%if(loginHewon!=null && loginHewon.gethStatus()==9) { %>
				<div style="text-align: right; margin: 5px; font-size: 10px;">
					<button type="button" id="notice-modifyBtn" >글 수정</button>
					<button type="button" id="notice-removeBtn" >글 삭제</button>
				</div>		
			<% } %>	
			<table class="notice_view_con_table">
				<tr>
					<!-- 공지사항 제목 [N_TITLE]-->
					<td class="notice_view_con_title_t"><span><%=notice.getnTitle() %></span></td>
					<!-- 공지사항 작성날짜와 시간 [N_DATE]-->
					<td class="notice_view_con_title_t_r">
						<span class="notice_view_con_days_time"><%=notice.getnDate() %></span>
					</td>
				</tr>
				<tr class="notice_view_con_tr_b">
					<!-- 공지사항 작성 [N_ID - dto에는 작성자이름 따로 저장하기 writer]-->
					<td class="notice_view_con_title_b">
						<span class="sv_member"><%=notice.getnWriter().replace("\n", "<br>") %></span>
					</td>
					<!-- 조회수 [N_LOOK]-->
					<td class="notice_view_con_title_b notice_view_inquiry">
						조회<span><%=notice.getnLook()+1 %></span>
					</td>
				</tr>
			</table>
		</div>
		<div style="text-align: center;">
			<!-- 공지사항 이미지 [N_IMAGE] -->
			<div class="notice_view_content_img">
				<img
					src="<%=request.getContextPath()%>/board/notice_image/<%=notice.getnImage() %>"
					alt="" width="500">
			</div>
			<!-- 공지사항 내용 [N_CONTENT] -->
			<div class="notice_view_content_text">
				<%=notice.getnContent() %>
			</div>
		</div>
	</div>

	<!-- 공지사항 버튼 -->
	<div style="width:100%; display: block;  margin-top:10px;  text-align: center; display: flex; justify-content:center; align-items: center;">
		<span> 			
			<button class="notice-listBtn" type="button" id="notice-listBtn">목록</button>
		</span> 
	</div>
	
</div>
<form method="post" id="menuForm">
	<input type="hidden" name="nCode" value="<%=nCode%>">
	<input type="hidden" name="search" value="<%=search %>">
	<input type="hidden" name="keyword" value="<%=keyword%>">
	<input type="hidden" name="pageNum" value="<%=pageNum%>">
</form>



<script type="text/javascript">
//POST방식이용
$("#notice-modifyBtn").click(function() {
	if(confirm("수정 하시겠습니까?")){
		$("#menuForm").attr("action","<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_modify");
		$("#menuForm").submit();
	}
})
//자바스크립트로 쿼리스트링 전달
$("#notice-removeBtn").click(function() {
	if(confirm("정말로 삭제 하시겠습니까? (복구 불가능)")){
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_delete_action&nCode=<%=nCode%>";
	}
})
$("#notice-listBtn").click(function() {
	location.href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>";
});
</script>