<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.matdak.dao.NoticeDAO"%>
<%@page import="com.matdak.dto.NoticeDTO"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 변경된 공지사항을 전달받아 NOTICE 테이블에 해당 공지사항으로 변경하고 해당 공지사항 페이지로
이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 - 공지사항 번호 전달 --%> 
<%-- 공지사항 관련 이미지가 전달된 경우 기존 이미지를 삭제하고 새로운 이미지로 서버 디렉토리에 저장 --%>

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
    	
    	//전달받은 파일을 저장하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
    	String saveDirectory = request.getServletContext().getRealPath("board/notice_image");
    	
    	//사용자로부터 입력받아 전달된 모든 파일을 서버 디렉토리에 자동으로 저장 - 파일 업로드
    	MultipartRequest multipartRequest = new MultipartRequest(request, saveDirectory, 
    	30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
    		
    	
    	//전달값과 업로드된 파일명을 반환받아 저장
    	int nCode = Integer.parseInt(multipartRequest.getParameter("nCode"));
    	String currentImage = multipartRequest.getParameter("currentImage");
    	
    	String search = multipartRequest.getParameter("search");
    	String keyword = multipartRequest.getParameter("keyword");
    	String pageNum = multipartRequest.getParameter("pageNum");
    	
    	String nImage = multipartRequest.getFilesystemName("nImage");
    	String nTitle = Utility.escapeTag(multipartRequest.getParameter("nTitle"));	
    	String nContent = Utility.escapeTag(multipartRequest.getParameter("nContent"));
    	
    	//System.out.println("4.search= "+search);
    	//System.out.println("currentImage= "+currentImage);
    	//System.out.println("nImage= "+nImage);
    	//System.out.println("keyword= "+keyword);
    	//System.out.println("pageNum= "+pageNum);
    	//System.out.println("=======");
    	
    	//수정된 값들로 필드값 변경
    	//NoticeDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
    	NoticeDTO notice = new NoticeDTO();
    	notice.setnCode(nCode);
    	notice.setnTitle(nTitle);
    	notice.setnContent(nContent);
    	if(nImage==null){//수정안한경우
    		notice.setnImage(currentImage); //기존이미지 그대로 사용
    	} else{
    		notice.setnImage(nImage); //바꾼이미지 사용
    		new File(saveDirectory,currentImage).delete(); //서버디렉토리에 저장된 기존이미지 삭제
    	}

    	
    	//공지사항 글을 전달받아 수정하는 DAO 클래스의 메소드 호출
    	NoticeDAO.getDAO().updateNotice(notice);
    	
    	//페이지 이동
    	out.println("<script type='text/javascript'>");
    	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=notice_detail&nCode="+nCode+"&pageNum="+pageNum+"&search="+search+"&keyword="+keyword+"';");
    	out.println("</script>");
  %>
