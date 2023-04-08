<%@page import="xyz.itwill.dto.MoonDTO"%>
<%@page import="xyz.itwill.dao.MoonDAO"%>
<%@page import="xyz.itwill.util.Utility"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@include file="/security/login_check.jspf" %>  
<%
	//비정상적인 요청에 대한 응답 처리
	if(request.getMethod().equals("GET")){
		out.println("<script type='text/javascript'>");
		out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=error&work=error_400';");
		out.println("</script>");
		return;
	}

	//전달값을 반환받아 저장 (7개)
	int mRef = Integer.parseInt(request.getParameter("mRef"));
	int mRestep = Integer.parseInt(request.getParameter("mRestep"));
	int mRelevel = Integer.parseInt(request.getParameter("mRelevel"));
	String pageNum = request.getParameter("pageNum");
	String mTitle = Utility.escapeTag(request.getParameter("mTitle"));	
	String mContent = Utility.escapeTag(request.getParameter("mContent"));	
	int mStatus = 1;
	if(request.getParameter("mStatus")!=null){
		mStatus = Integer.parseInt(request.getParameter("mStatus"));
	}
	
	//MOON_SEQ 시퀀스의 다음값(자동 증가값)을 검색하여 반환하는 DAO 클래스의 메소드 호출
	// => 게시글(새글 또는 답글)의 글번호(MOON테이블의 mCode 컬럼값)로 저장하기 위해 필요
	// => [새글인 경우]에는 게시글의 그룹번호(MOON테이블의 REF 컬럼값)로 저장하기 위해 필요
	int mCode = MoonDAO.getDAO().selectNextNum();
	
	String mIp = request.getRemoteAddr();	
	//System.out.println("ip = "+mIp);

	//새글과 답글을 구분하여 BOARD 테이블의 컬럼값으로 저장될 변수값 변경
	// => board_write.jsp 문서에서 hidden 타입으로 전달된 값이 저장된 ref, reStep, reLevel 변수값
	//(새글 - 초기값, 답글 - 부모글) 변경
	if(mRef==0){ //새글인 경우
		mRef=mCode; //초기값으로 변경
	} else{ //답글인 경우
		MoonDAO.getDAO().updatemRestep(mRef, mRestep);
		mRestep++;
		mRelevel++;				
	}
	
	//객체에 삽입 처리
	MoonDTO moon = new MoonDTO();
	moon.setmCode(mCode);
	moon.setmId(loginHewon.gethId());
	moon.setmTitle(mTitle);
	moon.setmRef(mRef);
	moon.setmRestep(mRestep);
	moon.setmRelevel(mRelevel);
	moon.setmContent(mContent);
	moon.setmIp(mIp);
	moon.setmStatus(mStatus);

	//테이블에 삽입
	MoonDAO.getDAO().insertMoon(moon);
	
	//페이지 이동
	out.println("<script type='text/javascript'>");
	out.println("location.href='"+request.getContextPath()+"/index.jsp?workgroup=board&work=moon&pageNum="+pageNum+"';");
	out.println("</script>");
%>