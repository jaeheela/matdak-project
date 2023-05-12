<%@page import="xyz.itwill.dao.HewonDAO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="xyz.itwill.dto.NoticeDTO"%>
<%@page import="javax.swing.plaf.basic.BasicSplitPaneUI.KeyboardDownRightHandler"%>
<%@page import="java.util.List"%>
<%@page import="xyz.itwill.dao.NoticeDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- NOTICE 테이블에 저장된 게시글을 검색하여 게시글 목록을 클라이언트에게 전달하는 JSP 문서 --%>    
<%-- => 게시글 목록을 페이지로 구분 검색하여 응답처리 - 페이징 처리 --%>

<%-- => [페이지번호] 클릭 시 notice.jsp 요청 : GET --%>
<%-- => 페이지번호(pageNum), 검색대상(search-컬럼명)과 검색단어(keyword) 전달 --%>

<%-- => [검색] 클릭 시 notice.jsp 요청 : POST --%>
<%-- => 검색대상(search-컬럼명)과 검색단어(keyword) 전달 --%>

<%-- => [글쓰기] 클릭 시 notice_wirte.jsp 요청 - 전달값 없음 --%>
<%-- => 관리자에게만 링크 제공 - 권한 부여 --%>

<%-- => [공지사항 이미지] 클릭 시 notice_detail.jsp 요청 --%>
<%-- => 글번호(nCode), 검색대상(search-컬럼명), 검색단어(keyword) 전달 --%>

<%
	//검색대상과 검색단어를 반환받아 저장
	String search = request.getParameter("search");
	if(search==null){
		search="";
	}
	String keyword = request.getParameter("keyword");
	if(keyword==null){
		keyword="";
	}
	
	//페이징처리 관련 요청페이지번호를 반환받아 저장
	int pageNum = 1;
	if(request.getParameter("pageNum")!=null){
		pageNum=Integer.parseInt(request.getParameter("pageNum"));
	}
	//System.out.println("1.search= "+search);
	//System.out.println("keyword= "+keyword);
	//System.out.println("pageNum= "+pageNum);
	//System.out.println("=======");
	//하나의 페이지에 출력될 이미지의 갯수 설정
	int pageSize = 6;
	
	//검색 관련 정보를 전달받아 NOTICE 테이블에 저장된 특정 공지사항의 갯수를 검색하여 반환하는
	//DAO 클래스의 메소드 호출
	int totalNotice = NoticeDAO.getDAO().selectNoticeCount(search, keyword);
	
	//전체 페이지의 갯수를 계산하여 저장
	int totalPage = (int)Math.ceil((double)totalNotice/pageSize);
	
	//요청페이지번호 검증 - 비정상적인 요청
	if(pageNum<=0 || pageNum>totalPage){ 
		pageNum=1;
	}
	
	//시작행과 종료행을 계산하여 저장
	int startRow = (pageNum-1)*pageSize+1;
	int endRow = pageNum*pageSize;
	if(endRow>totalNotice){
		endRow=totalNotice;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료게시글의 행번호를 전달받아
	//NOTICE 테이블에 저장된 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 DAO클래스의 메소드 호출
	List<NoticeDTO> noticeList = NoticeDAO.getDAO().selectNoticeList(startRow, endRow, search, keyword);
		
	//세션에 저장된 권한 관련 정보를 반환받아 저장
	HewonDTO loginHewon = (HewonDTO) session.getAttribute("loginHewon");
	//System.out.println(loginHewon.gethStatus());
	
	//서버 시스템의 현재 날짜를 반환받아 저장
	String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
	
	//요청페이지에 검색되어 출력될 시작 게시글의 일련번호에 대한 시작값을 계산하여 저장
	int printNum = totalNotice-(pageNum-1)*pageSize;
	
	
	
	
	
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
	
	/*
	// 저장된 쿠키 불러오기
	Cookie[] cookieFromRequest = request.getCookies();
	String cookieValue = null;
	for(int i = 0 ; i<cookieFromRequest.length; i++) {
		// 요청정보로부터 쿠키를 가져온다.
		cookieValue = cookieFromRequest[0].getValue();	// 테스트라서 추가 데이터나 보안사항은 고려하지 않으므로 1번째 쿠키만 가져옴	
	}	
 	// 쿠키 세션 입력
	if (session.getAttribute(nCode+":cookie") == null) {
	 	session.setAttribute(nCode+":cookie", nCode + ":" + cookieValue);
	} else {
		session.setAttribute(nCode+":cookie ex", session.getAttribute(nCode+":cookie"));
		if (!session.getAttribute(nCode+":cookie").equals(nCode + ":" + cookieValue)) {
		 	session.setAttribute(nCode+":cookie", nCode + ":" + cookieValue);
		}
	}
 	// 조회수 카운트
 	if (!session.getAttribute(nCode+":cookie").equals(session.getAttribute(nCode+":cookie ex"))) {
 		NoticeDAO.getDAO().updatenLook(nCode); //조회수 증가
 	}
 	//System.out.println("중복방지 111 = " + session.getAttribute(nCode+":cookie") );
 	//System.out.println("중복방지 222 = " + session.getAttribute(nCode+":cookie ex") );
 	//System.out.println("중복방지 333 = " + session.toString() );
 	//for(int i = 0; i < session.getValueNames().length; i++){
 	//	System.out.println("중복방지 444 = " + session.getValueNames()[i].toString() );
 	//}
	*/	
	
	
%>

<style type="text/css">
.customer-head-title { text-align: center; }
.customer-head-title .customer-sub-title { padding: 40px; border-bottom:1px solid #ccc;  }
.notice-paging-box{
	width: 100%;
	margin: 0 auto;
	text-align: center;
}
.notice-searching-box{
	width: 100%;
	margin: 5px auto;
	text-align: right;
}
.notice-list-area{
	padding-top:20px;
	width: 100%;
	display: flex;
	justify-content: space-between;
	flex-wrap: wrap;
	justify-content: center;
	align-items: center;
	margin: 0 auto;
	
}
.notice-list-box{
	width: 400px; 
	display: flex;
	flex-direction: column;
	margin: 0px 15px;
	position: relative;
	margin-bottom: 50px;
	
}
.notice-list-box .notice-thumbnail-image{
	width: 400px;
	height: 260px;
	/*border: 1px solid black;*/
	position: relative;
	
}
.notice-list-box .notice-thumbnail-image>img{
	position: relative;
	height:250px; 
	width: 90%;
	left: 21px;
	display: block;
}
.notice-list-box .notice-thumbnail-title{
	text-align: center;
	
}
</style>


<div style="width:100%;">
	<!-- 공지사항 title -->
	<div class="customer-head-title">
		<div class="customer-sub-title">맛있닭의 중요한 공지사항과 새로운 소식을 만나보세요 :)</div>
	</div>

	<%-- 서칭 처리--%>
	<div class="notice-searching-box">
	<form action="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice" method="post" style="display: inline;">
		<select name="search">
			<option style="font-size:13px;" value="n_title" <%if(search.equals("n_title")){ %>selected="selected"<%} %>selected>&nbsp;제목&nbsp;</option>
			<option style="font-size:13px;" value="h_name" <%if(search.equals("h_name")){ %>selected="selected"<%} %> >&nbsp;작성자&nbsp;</option>
			<option style="font-size:13px;" value="n_content" <%if(search.equals("n_content")){ %>selected="selected"<%} %>>&nbsp;내용&nbsp;</option>
		</select>
		<input type="text" name="keyword" value="<%=keyword%>" placeholder="공지사항을 검색하세요."> 
		<button type="submit" style="font-size:15px;">검색</button>		
	</form>

	</div>
	<%-- [글쓰기]버튼 : 관리자에게만 [글쓰기] 권한 부여  --%>
	<% if (loginHewon!=null && loginHewon.gethStatus()==9) { %>	
		<span style="position: relative; margin-top:5px;"><button type="button" style="font-size:15px;" onclick="location.href='<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_write';">글쓰기</button></span>
	<% } %>

	<%-- 공지사항 list --%>
	<%if(totalNotice==0){ %>
		<div style="text-align: center; font-size: 20px;">검색된 공지사항 글이 없습니다.</div>
	<%} else{%>
	
		<%if(!noticeList.isEmpty()){ %>
		<div style="text-align: center; font-size: 20px; margin-bottom: 5px;">총 <%=totalNotice %>개의 공지사항 글이 있습니다.</div>
		<%} %>
		
		<%-- 페이징 처리--%>
		<div class="notice-paging-box">
		<% if(StartPage>blockSize) { %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=StartPage-blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[이전]</a>
		<% } else{ %>
			<span style="color: gray;">[이전]</span>
		<%} %>
		
		<%for(int i=StartPage; i<=endPage; i++) {%>
			<% if(pageNum!=i){%>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=i%>&search=<%=search%>&keyword=<%=keyword%>">[<%=i %>]</a>
			<%} else {%>
				<span style="font-weight: 900">[<%=i %>]</span>
			<%} %>
		<%} %>
		
		<%if(endPage!=totalPage){ %>
			<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice&pageNum=<%=StartPage+blockSize%>&search=<%=search%>&keyword=<%=keyword%>">[다음]</a>
		<%} else{ %>
			<span style="color: gray;">[다음]</span>
		<%} %>
		</div>		
		<%-- 공지사항출력 --%>
		<div class="notice-list-area">
		<%for(NoticeDTO notice:noticeList){ %>
			<% if(notice.getnStatus()==1){ %>
			<div class="notice-list-box">
		 	<a href="<%=request.getContextPath()%>/index.jsp?workgroup=board&work=notice_detail&nCode=<%=notice.getnCode()%>&pageNum=<%=pageNum%>&search=<%=search%>&keyword=<%=keyword%>">		
		 	<div class="notice-thumbnail-image">
		 		<img src="<%=request.getContextPath()%>/board/notice_image/<%=notice.getnImage()%>">
		 	</div>
		 	<div class="notice-thumbnail-title">
		 		<%=notice.getnTitle() %>
		 	</div>
		 	</a>
		 	</div>
		 	<%} %>
		<% } %> 	
		</div>
	<%} %>
	
	

</div>




