<%@page import="java.io.File"%>
<%@page import="com.matdak.dao.ProductDAO"%>
<%@page import="com.matdak.dto.Product"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품정보를 전달받아 PRODUCT 테이블에 삽입하고 제품목록 출력페이지(product_manager.jsp)로 
이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 --%>
<%-- => 제품 관련 이미지는 서버 디렉토리에 저장하고 PRODUCT 테이블에서는 업로드 처리된 이미지 파일명 저장 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%-- 입력페이지에서 전달된 [multipart/form-data]를 처리하기 위해 cos 라이브러리(cos.jar)의 MultipartRequest 클래스 사용 --%>
<%@include file="/security/admin_check.jspf" %>
<%
//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	//전달받은 파일을 저장하기 위한 서버 디렉토리의 파일 시스템 경로를 반환받아 저장
	// => 작업디렉토리(WorkSpace)가 아닌 웹디렉토리(WebApps)의 파일 시스템 경로 반환
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	
	//[multipart/form-data]를 처리하기 위한 MultipartRequest 객체 생성
	// => 사용자로부터 입력받아 전달된 모든 파일을 서버 디렉토리에 자동으로 저장 - 파일 업로드
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
	, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드된 파일명을 반환받아 저장
	int pNo=Integer.parseInt(multipartRequest.getParameter("pNo"));
	String pCate=multipartRequest.getParameter("pCate");
	String pName=multipartRequest.getParameter("pName");
	String pImg=multipartRequest.getFilesystemName("pImg");
	String pInfo=multipartRequest.getFilesystemName("pInfo");
	int pStock=Integer.parseInt(multipartRequest.getParameter("pStock"));
	int pPrice=Integer.parseInt(multipartRequest.getParameter("pPrice"));
	
	//int pNo = AdminPDAO.getDAO().selectNextNum();
	
	//ProductDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
	Product product=new Product();
	product.setpNo(pNo);
	product.setpCate(pCate);
	product.setpName(pName);
	product.setpImg(pImg);
	product.setpInfo(pInfo);
	product.setpStock(pStock);
	product.setpPrice(pPrice);
	
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하는 DAO 클래스의 메소드 호출
	int rows=ProductDAO.getDAO().insertProduct(product);
	
	if(rows<=0) { //PRODUCT 테이블에 제품정보가 삽입되지 않은 경우
		new File(saveDirectory, pImg).delete();
		new File(saveDirectory, pInfo).delete();
	}
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=product_manager';");
	out.println("</script>");
%>	