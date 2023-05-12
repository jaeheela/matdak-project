<%@page import="xyz.itwill.dao.AdminPDAO"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 제품정보를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 변경하고 제품정보 출력페이지
(product_detail.jsp)로 이동하기 위한 URL 주소를 클라이언트에게 전달하는 JSP 문서 - 제품번호 전달 --%>
<%-- => 제품 관련 이미지가 전달된 경우 기존 이미지를 삭제하고 새로운 이미지를 서버 디렉토리에 저장 --%>
<%-- => 관리자만 요청 가능한 JSP 문서 --%>
<%@include file="/security/admin_check.jspf" %>
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}
	//전달받은 파일을 서버하기 위한 서버 디렉토리의 시스템 경로를 반환받아 저장
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	
	//[multipart/form-data]를 처리하기 위한 MultipartRequest 객체 생성
	// => 사용자로부터 입력받아 전달된 모든 파일을 서버 디렉토리에 자동으로 저장 - 파일 업로드
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	//전달값과 업로드된 파일명을 반환받아 저장
	int pNo=Integer.parseInt(multipartRequest.getParameter("pNo"));
	String currentpImg=multipartRequest.getParameter("currentpImg");
	String currentpInfo=multipartRequest.getParameter("currentpInfo");
	String pCate=multipartRequest.getParameter("pCate");
	String pName=multipartRequest.getParameter("pName");
	String pImg=multipartRequest.getFilesystemName("pImg");
	String pInfo=multipartRequest.getFilesystemName("pInfo");
	int pStock=Integer.parseInt(multipartRequest.getParameter("pStock"));
	int pPrice=Integer.parseInt(multipartRequest.getParameter("pPrice"));
	
	//ProductDTO 객체를 생성하여 전달값과 업로드 파일명으로 필드값 변경
	ProductDTO product=new ProductDTO();
	product.setpNo(pNo);
	product.setpCate(pCate);
	product.setpName(pName);
	if(pImg==null) {//전달된 대표이미지 파일이 없는 경우 - 대표이미지 미변경
		product.setpImg(currentpImg);		
	} else {//전달된 대표이미지 파일이 있는 경우 - 대표이미지 변경
		product.setpImg(pImg);
		//서버 디렉토리에 저장된 기존 제품의 대표이미지 파일 삭제
		new File(saveDirectory, currentpImg).delete();
	}
	if(pInfo==null) {//전달된 상세이미지 파일이 없는 경우 - 상세이미지 미변경
		product.setpInfo(currentpInfo);		
	} else {//전달된 상세이미지 파일이 있는 경우 - 상세이미지 변경
		product.setpInfo(pInfo);
		//서버 디렉토리에 저장된 기존 제품의 상세이미지 파일 삭제
		new File(saveDirectory, currentpInfo).delete();
	}
	product.setpStock(pStock);
	product.setpPrice(pPrice);

	//제품정보를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 변경하는 DAO 클래스의 메소드 호출
	ProductDAO.getDAO().updateProduct(product);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=product_detail&pNo="+product.getpNo()+"';");
	out.println("</script>");
%>  