<%@page import="com.matdak.dto.ReviewDTO"%>
<%@page import="com.matdak.dao.ReviewDAO"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 변경된 리뷰글을 전달받아 REVIEW 테이블에 해당 리뷰글로 변경하고 review.jsp로
이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 - 리뷰 번호 전달 --%> 
<%-- 리뷰 관련 이미지가 전달된 경우 기존 이미지를 삭제하고 새로운 이미지로 서버 디렉토리에 저장 --%>

<%-- => 로그인 사용자 중 리뷰 작성자만 요청 가능한 JSP 문서 --%>
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
    	
    	
    	
    	//전달값과 업로드된 파일명을 반환받아 저장
    	int rCode = Integer.parseInt(multipartRequest.getParameter("rCode"));
    	String currentImage = multipartRequest.getFilesystemName("currentImage");
    	
    	int rJno = Integer.parseInt(multipartRequest.getParameter("rJno"));
    	int rStar = Integer.parseInt(multipartRequest.getParameter("rStar"));
    	String rContent = Utility.escapeTag(multipartRequest.getParameter("rContent"));	
    	String rImage = multipartRequest.getFilesystemName("rImage");	
    	int rStatus = 1;
    	if(multipartRequest.getParameter("rStatus")!=null){
    		rStatus = Integer.parseInt(multipartRequest.getParameter("rStatus"));
    	}

    	//수정된 값들로 필드값 변경
    	//ReviewDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
    	ReviewDTO review = new ReviewDTO();
    	review.setrCode(rCode);
    	review.setrJno(rJno);
    	review.setrStar(rStar);
    	review.setrImage(rImage);
    	review.setrContent(rContent);
    	review.setrStatus(rStatus);  //일반글:1, 비밀글:2
    	if(rImage==null){//수정안한경우
    		review.setrImage(currentImage); //기존이미지 그대로 사용
    	} else{
    		review.setrImage(rImage); //바꾼이미지 사용
    		new File(saveDirectory,currentImage).delete(); //서버디렉토리에 저장된 기존이미지 삭제
    	}

    	//공지사항 글을 전달받아 REVIEW 테이블에 수정하는 DAO 클래스의 메소드 호출
    	int rows = ReviewDAO.getDAO().updateReview(review);

    	
    	//페이지 이동
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=review';");
    	out.println("</script>");
  %>
