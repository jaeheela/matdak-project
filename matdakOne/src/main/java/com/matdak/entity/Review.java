package com.matdak.entity;
/*
이름        널?       유형             
--------- -------- -------------- 
R_NO      NOT NULL NUMBER(4)      - 리뷰번호 / pk, 시퀀스
R_HID     NOT NULL VARCHAR2(20)   - 회원아이디 / fk
R_JNO     NOT NULL NUMBER(10)     - 주문상품번호 / fk
R_CONTENT NOT NULL VARCHAR2(2000) - 리뷰 컨텐츠
R_DATE    NOT NULL DATE           - 리뷰 작성날짜
R_LOOK    NOT NULL NUMBER(4)      - 리뷰 조회수
R_STATUS  NOT NULL NUMBER(1)      - 리뷰글 상태 / 0:삭제 1:일반 2:비밀
R_IMG              VARCHAR2(2000) - 리뷰 이미지
R_STAR    NOT NULL NUMBER(1)      - 리뷰 별점 /1 ~ 5
*/
public class Review {
	int rNo;
	String rHid;
	int rJno; 
	String rContent;
	String rDate;
	int rLook;
	int rStatus;
	String rImg;
	int rStar;
	public Review() {
		// TODO Auto-generated constructor stub
	}
	public int getrNo() {
		return rNo;
	}
	public void setrNo(int rNo) {
		this.rNo = rNo;
	}
	public String getrHid() {
		return rHid;
	}
	public void setrHid(String rHid) {
		this.rHid = rHid;
	}
	public int getrJno() {
		return rJno;
	}
	public void setrJno(int rJno) {
		this.rJno = rJno;
	}
	public String getrContent() {
		return rContent;
	}
	public void setrContent(String rContent) {
		this.rContent = rContent;
	}
	public String getrDate() {
		return rDate;
	}
	public void setrDate(String rDate) {
		this.rDate = rDate;
	}
	public int getrLook() {
		return rLook;
	}
	public void setrLook(int rLook) {
		this.rLook = rLook;
	}
	public int getrStatus() {
		return rStatus;
	}
	public void setrStatus(int rStatus) {
		this.rStatus = rStatus;
	}
	public String getrImg() {
		return rImg;
	}
	public void setrImg(String rImg) {
		this.rImg = rImg;
	}
	public int getrStar() {
		return rStar;
	}
	public void setrStar(int rStar) {
		this.rStar = rStar;
	}
}
