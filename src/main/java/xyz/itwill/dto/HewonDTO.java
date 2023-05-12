package xyz.itwill.dto;

/*
이름         널?       유형            
---------- -------- ------------- 
H_ID       NOT NULL VARCHAR2(20)  
H_PW       NOT NULL VARCHAR2(50)  
H_ADDR     NOT NULL VARCHAR2(100) 
H_EMAIL    NOT NULL VARCHAR2(50)  
H_PHONE    NOT NULL VARCHAR2(50)  
H_NAME     NOT NULL VARCHAR2(20)  
H_STATUS   NOT NULL NUMBER(1)     
H_POSTCODE NOT NULL VARCHAR2(20)  

 */

public class HewonDTO {
	private String hId;
	private String hPw;
	private String hAddr1;
	private String hAddr2;
	private String hEmail;
	private String hPhone;
	private String hName;
	private String hPostcode;
	private int hStatus;
	
	public HewonDTO() {
		
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

	public String gethAddr1() {
		return hAddr1;
	}

	public void sethAddr1(String hAddr1) {
		this.hAddr1 = hAddr1;
	}

	public String gethAddr2() {
		return hAddr2;
	}

	public void sethAddr2(String hAddr2) {
		this.hAddr2 = hAddr2;
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

	public String gethName() {
		return hName;
	}

	public void sethName(String hName) {
		this.hName = hName;
	}

	public String gethPostcode() {
		return hPostcode;
	}

	public void sethPostcode(String hPostcode) {
		this.hPostcode = hPostcode;
	}

	public int gethStatus() {
		return hStatus;
	}

	public void sethStatus(int hStatus) {
		this.hStatus = hStatus;
	}
}

