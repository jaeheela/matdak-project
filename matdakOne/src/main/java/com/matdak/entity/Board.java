package com.matdak.entity;
/*
이름        널?       유형             
--------- -------- -------------- 
B_NO      NOT NULL NUMBER(4)      - 게시판 번호 / pk, 시퀀스
B_HID     NOT NULL VARCHAR2(20)   - 회원 아이디 / fk
B_CATE    NOT NULL VARCHAR2(10)   - 게시판 카테고리 / notice, moon
B_TITLE   NOT NULL VARCHAR2(20)   - 게시판 타이틀
B_CONTENT NOT NULL VARCHAR2(2000) - 게시판 컨텐츠
B_DATE    NOT NULL DATE           - 게시판 작성날짜 / SYSDATE
B_LOOK    NOT NULL NUMBER(4)      - 게시판 조회수
B_STATUS  NOT NULL NUMBER(1)      - 게시판 상태 / 0:삭제 1:일반 2:비밀
B_IMG              VARCHAR2(2000) - 게시판 이미지
*/
public class Board {
	int bNo;
	String bHid;
	String bCate;
	String bTitle;
	String bContent;
	String bDate;
	int bLook;
	int bStatus;
	String bImg;
	public Board() {
		// TODO Auto-generated constructor stub
	}
	public int getbNo() {
		return bNo;
	}
	public void setbNo(int bNo) {
		this.bNo = bNo;
	}
	public String getbHid() {
		return bHid;
	}
	public void setbHid(String bHid) {
		this.bHid = bHid;
	}
	public String getbCate() {
		return bCate;
	}
	public void setbCate(String bCate) {
		this.bCate = bCate;
	}
	public String getbTitle() {
		return bTitle;
	}
	public void setbTitle(String bTitle) {
		this.bTitle = bTitle;
	}
	public String getbContent() {
		return bContent;
	}
	public void setbContent(String bContent) {
		this.bContent = bContent;
	}
	public String getbDate() {
		return bDate;
	}
	public void setbDate(String bDate) {
		this.bDate = bDate;
	}
	public int getbLook() {
		return bLook;
	}
	public void setbLook(int bLook) {
		this.bLook = bLook;
	}
	public int getbStatus() {
		return bStatus;
	}
	public void setbStatus(int bStatus) {
		this.bStatus = bStatus;
	}
	public String getbImg() {
		return bImg;
	}
	public void setbImg(String bImg) {
		this.bImg = bImg;
	}
}
