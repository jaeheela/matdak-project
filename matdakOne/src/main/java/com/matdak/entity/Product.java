package com.matdak.entity;
/*
이름       널?       유형            
-------- -------- ------------- 
P_NO     NOT NULL NUMBER(10)    - 상품번호 /pk, 시퀀스
P_NAME   NOT NULL VARCHAR2(100) - 상품명
P_IMG1   NOT NULL VARCHAR2(500) - 상품메인이미지
P_IMG2            VARCHAR2(500) - 상품상세이미지
P_PRICE  NOT NULL NUMBER(10)    - 상품가격
P_CATE   NOT NULL VARCHAR2(10)  - 상품카테고리
P_STOCK  NOT NULL NUMBER(4)     - 상품재고량
P_STATUS NOT NULL NUMBER(1)     - 상품상태 / 0:삭제 1:존재, 2:베스트
P_DATE   NOT NULL DATE          - 상품등록일 / SYSDATE
*/
public class Product {
	private int pNo;
	private String pName;
	private String pImg1;
	private String pImg2;
	private int pPrice;
	private String pCate;
	private int pStock;
	private int pStatus;
	private String pDate;
	public Product() {
		// TODO Auto-generated constructor stub
	}
	public int getpNo() {
		return pNo;
	}
	public void setpNo(int pNo) {
		this.pNo = pNo;
	}
	public String getpName() {
		return pName;
	}
	public void setpName(String pName) {
		this.pName = pName;
	}
	public String getpImg1() {
		return pImg1;
	}
	public void setpImg1(String pImg1) {
		this.pImg1 = pImg1;
	}
	public String getpImg2() {
		return pImg2;
	}
	public void setpImg2(String pImg2) {
		this.pImg2 = pImg2;
	}
	public int getpPrice() {
		return pPrice;
	}
	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}
	public String getpCate() {
		return pCate;
	}
	public void setpCate(String pCate) {
		this.pCate = pCate;
	}
	public int getpStock() {
		return pStock;
	}
	public void setpStock(int pStock) {
		this.pStock = pStock;
	}
	public int getpStatus() {
		return pStatus;
	}
	public void setpStatus(int pStatus) {
		this.pStatus = pStatus;
	}
	public String getpDate() {
		return pDate;
	}
	public void setpDate(String pDate) {
		this.pDate = pDate;
	}
}
