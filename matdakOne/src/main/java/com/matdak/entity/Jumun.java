package com.matdak.entity;
/*
이름          널?       유형            
----------- -------- ------------- 
J_NO        NOT NULL NUMBER(10)    - 주문상품 번호 /pk, 시퀀스
J_HID       NOT NULL VARCHAR2(20)  - 회원아이디 / fk
J_PNO       NOT NULL NUMBER(10)   - 상품번호 / fk
J_DATE      NOT NULL DATE          - 주문상품의 날짜 / SYSDATE
J_PRICE     NOT NULL NUMBER(10)    - 주문상품의 한개의 가격
J_ACCOUNT   NOT NULL NUMBER(10)    - 주문상품의 수량
J_TOTAL     NOT NULL NUMBER(10)    - 주문상품의 총금액
J_WAY       NOT NULL VARCHAR2(20)  - 주문상품의 결제수단
J_NAME      NOT NULL VARCHAR2(20)  - 주문상품의 작성자명
J_PHONE     NOT NULL VARCHAR2(50)  - 주문상품의 전화번호
J_POSTCODE  NOT NULL VARCHAR2(20)  - 주문상품의 우편번호
J_ADDR      NOT NULL VARCHAR2(100) - 주문상품의 주소
J_STATUS    NOT NULL NUMBER(1)     - 주문상품의 상태 / 주문완료:1 , 환불:0
J_RSTATUS   NOT NULL NUMBER(1)     - 주문상품의 리뷰상태 /리뷰작성완료:1 , 리뷰작성미완료:0
J_DELSTATUS NOT NULL NUMBER(10)    - 주문상품의 배송상태 / 배송완료:1, 미배송:0
*/
public class Jumun {
	private int jNo;
	private String jHid;
	private int jPno;
	private String jDate;
	private int jPrice;
	private int jAcoount;
	private int jTotal;
	private String jWay;
	private String jName;
	private String jPhone;
	private String jPostcode;
	private String jAddr;
	private int jStatus;
	private int jRstatus;
	private int jDelstatus;
	public Jumun() {
		// TODO Auto-generated constructor stub
	}
	public int getjNo() {
		return jNo;
	}
	public void setjNo(int jNo) {
		this.jNo = jNo;
	}
	public String getjHid() {
		return jHid;
	}
	public void setjHid(String jHid) {
		this.jHid = jHid;
	}
	public int getjPno() {
		return jPno;
	}
	public void setjPno(int jPno) {
		this.jPno = jPno;
	}
	public String getjDate() {
		return jDate;
	}
	public void setjDate(String jDate) {
		this.jDate = jDate;
	}
	public int getjPrice() {
		return jPrice;
	}
	public void setjPrice(int jPrice) {
		this.jPrice = jPrice;
	}
	public int getjAcoount() {
		return jAcoount;
	}
	public void setjAcoount(int jAcoount) {
		this.jAcoount = jAcoount;
	}
	public int getjTotal() {
		return jTotal;
	}
	public void setjTotal(int jTotal) {
		this.jTotal = jTotal;
	}
	public String getjWay() {
		return jWay;
	}
	public void setjWay(String jWay) {
		this.jWay = jWay;
	}
	public String getjName() {
		return jName;
	}
	public void setjName(String jName) {
		this.jName = jName;
	}
	public String getjPhone() {
		return jPhone;
	}
	public void setjPhone(String jPhone) {
		this.jPhone = jPhone;
	}
	public String getjPostcode() {
		return jPostcode;
	}
	public void setjPostcode(String jPostcode) {
		this.jPostcode = jPostcode;
	}
	public String getjAddr() {
		return jAddr;
	}
	public void setjAddr(String jAddr) {
		this.jAddr = jAddr;
	}
	public int getjStatus() {
		return jStatus;
	}
	public void setjStatus(int jStatus) {
		this.jStatus = jStatus;
	}
	public int getjRstatus() {
		return jRstatus;
	}
	public void setjRstatus(int jRstatus) {
		this.jRstatus = jRstatus;
	}
	public int getjDelstatus() {
		return jDelstatus;
	}
	public void setjDelstatus(int jDelstatus) {
		this.jDelstatus = jDelstatus;
	}
}
