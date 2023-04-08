<%@page import="java.io.File"%>
<%@page import="xyz.itwill.dao.ProductDAO"%>
<%@page import="xyz.itwill.dto.ProductDTO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@include file="/security/admin_check.jspf" %>  --%>
<%
	if(request.getMethod().equals("GET")) {
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;	
	}
	String saveDirectory=request.getServletContext().getRealPath("/product_image");
	
	MultipartRequest multipartRequest=new MultipartRequest(request, saveDirectory
			, 30*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	
	int pNo=Integer.parseInt(multipartRequest.getParameter("pNo"));
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
	product.setpImg(pImg);
	product.setpInfo(pInfo);
	product.setpStock(pStock);
	product.setpPrice(pPrice);
	
	int rows=ProductDAO.getDAO().insertProduct(product);
	
	if(rows<=0) { //PRODUCT 테이블에 제품정보가 삽입되지 않은 경우
		new File(saveDirectory, pImg).delete();
		new File(saveDirectory, pInfo).delete();
	}
	
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=admin&work=product_manager';");
	out.println("</script>");
%>	