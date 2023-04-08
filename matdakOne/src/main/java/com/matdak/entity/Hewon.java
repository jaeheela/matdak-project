package com.matdak.entity;
/*
이름         널?       유형            
---------- -------- ------------- 
H_ID       NOT NULL VARCHAR2(20)  - 회원아이디 / pk
H_PW       NOT NULL VARCHAR2(50)  - 회원비밀번호
H_NAME     NOT NULL VARCHAR2(20)  - 회원이름
H_EMAIL             VARCHAR2(50)  - 회원이메일
H_PHONE    NOT NULL VARCHAR2(50)  - 회원전화번호
H_POSTCODE          VARCHAR2(20)  - 회원우편번호
H_ADDR              VARCHAR2(100) - 회원주소
H_STATUS   NOT NULL NUMBER(1)     - 회원상태 / 0:삭제 1:일반 9:관리자
*/
public class Hewon {
	private String hId;
	private String hPw;
	private String hName;
	private String hEmail;
	private String hPhone;
	private String hPostcode;
	private String hAddr;
	private int hStatus;
	public Hewon() {
		// TODO Auto-generated constructor stub
	}
	public String gethId() {
		return hId;
	}
	public void sethId(String hId) {
		this.hId = hId;
	}
	public String gethPw() {
		return hPw;
	}
	public void sethPw(String hPw) {
		this.hPw = hPw;
	}
	public String gethName() {
		return hName;
	}
	public void sethName(String hName) {
		this.hName = hName;
	}
	public String gethEmail() {
		return hEmail;
	}
	public void sethEmail(String hEmail) {
		this.hEmail = hEmail;
	}
	public String gethPhone() {
		return hPhone;
	}
	public void sethPhone(String hPhone) {
		this.hPhone = hPhone;
	}
	public String gethPostcode() {
		return hPostcode;
	}
	public void sethPostcode(String hPostcode) {
		this.hPostcode = hPostcode;
	}
	public String gethAddr() {
		return hAddr;
	}
	public void sethAddr(String hAddr) {
		this.hAddr = hAddr;
	}
	public int gethStatus() {
		return hStatus;
	}
	public void sethStatus(int hStatus) {
		this.hStatus = hStatus;
	}
}
