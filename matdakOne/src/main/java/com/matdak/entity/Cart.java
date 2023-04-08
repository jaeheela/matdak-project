package com.matdak.entity;
/*
이름        널?       유형           
--------- -------- ------------ 
C_HID     NOT NULL VARCHAR2(20) - 회원아이디 / pk,fk
C_PNO     NOT NULL NUMBER(10)   - 상품번호 /fk
C_ACCOUNT NOT NULL NUMBER(10)   - 장바구니 담은 상품수량
*/
public class Cart {
	private String cHId;
	private int cPno;
	private int cAccount;
	public Cart() {
		// TODO Auto-generated constructor stub
	}
	public String getcHId() {
		return cHId;
	}
	public void setcHId(String cHId) {
		this.cHId = cHId;
	}
	public int getcPno() {
		return cPno;
	}
	public void setcPno(int cPno) {
		this.cPno = cPno;
	}
	public int getcAccount() {
		return cAccount;
	}
	public void setcAccount(int cAccount) {
		this.cAccount = cAccount;
	}
}
