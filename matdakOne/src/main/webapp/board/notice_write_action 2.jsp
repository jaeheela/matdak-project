<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matdak.dao.NoticeDAO"%>
<%@page import="com.matdak.dto.NoticeDTO"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 공지사항을 전달받아 NOTICE 테이블에 삽입하고 게시글목록 출력페이지로
이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 --%> 

<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>  
<%
  //비정상적인 요청에 대한 응답 처리
    	if(request.getMethod().equals("GET")){
    		out.println("<script type='text/javascript'>");
    		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
    		out.println("</script>");
    		return;
    	}

    	//파일을 저장하기 위한 서버 디렉토리의 파일 시스템 경로 반환받아 저장
    	String saveDirectory = request.getServletContext().getRealPath("board/notice_image");
    	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 
    	30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    	
    	
    	
    	//전달값을 반환받아 저장
    	String nImage = multipartRequest.getFilesystemName("nImage");
    	String nTitle = Utility.escapeTag(multipartRequest.getParameter("nTitle"));	
    	String nContent = Utility.escapeTag(multipartRequest.getParameter("nContent"));


    	//NOTICE_SEQ 시퀀스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
    	// => 게시글의 번호를 저장하기 위해 필요
    	int nCode = NoticeDAO.getDAO().selectNextNum();

    	
    	//NoticeDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
    	NoticeDTO notice = new NoticeDTO();
    	notice.setnCode(nCode);
    	notice.setnId(loginHewon.gethId());
    	notice.setnImage(nImage);
    	notice.setnTitle(nTitle);
    	notice.setnContent(nContent);
    	notice.setnStatus(1); //게시글:1, 삭제글:0

    	
    	//공지사항 글을 전달받아 NOTICE 테이블에 삽입하는 DAO 클래스의 메소드 호출
    	int rows = NoticeDAO.getDAO().insertNotice(notice);
    	
    	//제품이 삽입되지 않은 경우 서버디렉토리에 업로드되어 저장된 제품 관련 이미지 파일 삭제
    	if(rows<=0){
    		new File(saveDirectory,nImage).delete();
    	}
    	
    	//페이지 이동
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=notice';");
    	out.println("</script>");
  %>
