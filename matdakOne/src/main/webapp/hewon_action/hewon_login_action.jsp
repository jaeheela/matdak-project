<%@page import="com.matdak.entity.Hewon"%>
<%@page import="com.matdak.dao.HewonDAO"%>
<%@page import="com.matdak.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 로그인처리 --%>    
<%
 	if(request.getMethod().equals("GET")) {
 		out.println("<script type='text/javascript'>");
 		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
 		out.println("</script>");
 		return;
 	}	

   	String hId=request.getParameter("hId");
   	String hPw=Utility.encrypt(request.getParameter("hPw"));
	Hewon hewon=HewonDAO.getDAO().selectHewonByhId(hId);
        	
   	if(hewon==null || hewon.gethStatus()==0) {
   		session.setAttribute("message", "입력한 아이디가 존재하지 않습니다.");
   		session.setAttribute("hId", hId);
   		out.println("<script type='text/javascript'>");
   		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=hewon_login';");
   		out.println("</script>");
   		return;
   	}
        	
   	if(!hewon.gethPw().equals(hPw)) {
   		session.setAttribute("message", "입력한 아이디가 잘못 되었거나 비밀번호가 맞지 않습니다.");
   		session.setAttribute("hId", hId);
   		out.println("<script type='text/javascript'>");
   		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=hewon&work=hewon_login';");
   		out.println("</script>");
   		return;
   	}
   	
	session.setAttribute("loginHewon", HewonDAO.getDAO().selectHewonByhId(hId));      	
   	String returnUrl=(String)session.getAttribute("returnUrl");
    	
    if(returnUrl==null) {//요청 페이지가 없는 경우
   		out.println("<script type='text/javascript'>");
   		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=main&work=main_page';");
   		out.println("</script>");
    } else {//요청 페이지가 있는 경우
   		session.removeAttribute("returnUrl");
   		out.println("<script type='text/javascript'>");
   		out.println("location.href='"+returnUrl+"';");
   		out.println("</script>");
    }
%>







