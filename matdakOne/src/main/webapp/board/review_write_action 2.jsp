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
<%@include file="/security/login_url.jspf" %>  

<%
  //비정상적인 요청에 대한 응답 처리
    	if(request.getMethod().equals("GET")){
    		out.println("<script type='text/javascript'>");
    		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
    		out.println("</script>");
    		return;
    	}

    	//파일을 저장하기 위한 서버 디렉토리의 파일 시스템 경로 반환받아 저장
    	String saveDirectory = request.getServletContext().getRealPath("board/review_image");
    	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 
    	30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    	
    	
    	
    	//전달값을 반환받아 저장
    	int rJno = Integer.parseInt(multipartRequest.getParameter("rJno"));
    	int rStar = Integer.parseInt(multipartRequest.getParameter("rStar"));
    	String rContent = Utility.escapeTag(multipartRequest.getParameter("rContent"));	
    	String rImage = multipartRequest.getFilesystemName("rImage");
    	int rStatus = 1;
    	if(multipartRequest.getParameter("rStatus")!=null){
    		rStatus = Integer.parseInt(multipartRequest.getParameter("rStatus"));
    	}
    	int rDone = Integer.parseInt(multipartRequest.getParameter("rDone"));


    	//REVIEW_SEQ 시퀀스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
    	// => 게시글의 번호를 저장하기 위해 필요
    	int rCode = ReviewDAO.getDAO().selectNextNum();

    	
    	//ReviewDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
    	ReviewDTO review = new ReviewDTO();
    	review.setrCode(rCode);
    	review.setrId(loginHewon.gethId());
    	review.setrJno(rJno);
    	review.setrContent(rContent);
    	review.setrStar(rStar);
    	review.setrImage(rImage);
    	review.setrStatus(rStatus); //일반글:1, 비밀글:2
    	review.setrDone(rDone); //리뷰작성완료:1
    	
    	//공지사항 글을 전달받아 NOTICE 테이블에 삽입하는 DAO 클래스의 메소드 호출
    	int rows = ReviewDAO.getDAO().insertRview(review);
    		
    	/*
    	//제품이 삽입되지 않은 경우 서버디렉토리에 업로드되어 저장된 제품 관련 이미지 파일 삭제
    	//제품 삽입 필수조건이 아니기 때문에 필요없음
    	if(rows<=0){
    		new File(saveDirectory,rImage).delete();
    	}
    	*/
    	
    	//페이지 이동
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review';");
    	out.println("</script>");
  %>
