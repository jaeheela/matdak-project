<%@page import="xyz.itwill.dao.BasketDAO"%>
<%@page import="xyz.itwill.dto.HewonDTO"%>
<%@page import="xyz.itwill.dto.BasketDTO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	HewonDTO loginHewon  =(HewonDTO)session.getAttribute("loginHewon");

	//���ް��� ��ȯ�޾� ���� (��ǰ ��ȣ, ����)
	int bNum=Integer.parseInt(request.getParameter("result"));   //�������� product ���̺� ���� 
	int bPno=Integer.parseInt(request.getParameter("pNo"));
	//���̵� ���� 
	String id = loginHewon.gethId();
	
	//System.out.println("bNum ="+bNum);
	//System.out.println("bPno ="+bPno);
	
	
	//BASKETDTO ��ü�� �����Ͽ� ���������� �ʵ尪 ����
	BasketDTO basket = new BasketDTO();
	basket.setbId(id);
	basket.setbPno(bPno);
	basket.setbNum(bNum);
	

	//basket ��ü�� ���޹޾� BOARD ���̺� �����ϴ� DAO Ŭ������ �޼ҵ� ȣ��
	BasketDAO.getDAO().insertBasket(basket);


	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=basket&jumun_list';");
	out.println("</script>");
%>