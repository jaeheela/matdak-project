<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--<%@include file="/security/admin_check.jspf" %>  --%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;			
	}

	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	int pNo=Integer.parseInt(multipartRequest.getParameter("pNo"));
	String currentpImg=multipartRequest.getParameter("currentpImg");
	String currentpInfo=multipartRequest.getParameter("currentpInfo");
	String pCate=multipartRequest.getParameter("pCate");
	String pName=multipartRequest.getParameter("pName");
	String pImg=multipartRequest.getFilesystemName("pImg");
	String pInfo=multipartRequest.getFilesystemName("pInfo");
	int pStock=Integer.parseInt(multipartRequest.getParameter("pStock"));
	int pPrice=Integer.parseInt(multipartRequest.getParameter("pPrice"));
	
	ProductDTO product=new ProductDTO();
	product.setpNo(pNo);
	product.setpCate(pCate);
	product.setpName(pName);
	if(pImg==null) {//전달된 대표이미지 파일이 없는 경우 - 대표이미지 미변경
		product.setpImg(currentpImg);		
	} else {//전달된 대표이미지 파일이 있는 경우 - 대표이미지 변경
		product.setpImg(pImg);
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

	ProductDAO.getDAO().updateProduct(product);
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=product_detail&pNo="+product.getpNo()+"';");
	out.println("</script>");
%>  