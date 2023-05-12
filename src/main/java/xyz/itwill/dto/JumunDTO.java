package xyz.itwill.dto;
/*
 이름         널?       유형            
---------- -------- ------------- 
J_NO       NOT NULL NUMBER(20)    
J_PNO      NOT NULL NUMBER(20)     //PRODUCT테이블 P_NO참조
J_ID       NOT NULL VARCHAR2(20)   //HEWON테이블 H_ID참조
J_NUM      NOT NULL NUMBER(10)     //basket 테이블 b_num 참조
J_TP       NOT NULL NUMBER(10)    
J_DATE     NOT NULL DATE          
J_STATUS   NOT NULL NUMBER(1)       //준비중:0/배송중:1/ 배송완료:2
J_JNAME    NOT NULL VARCHAR2(10)  
J_PHONE    NOT NULL VARCHAR2(15)  
J_POSTCODE NOT NULL VARCHAR2(10)  
J_OADDR1   NOT NULL VARCHAR2(100) 
J_OADDR2   NOT NULL VARCHAR2(100) 
J_OMESG             VARCHAR2(200) 
J_OPAY     NOT NULL VARCHAR2(20)  
J_BNO     			NUMBER         
 */
public class JumunDTO {
	private int jNo;
	private int jPno;
	private String jId;
	private int jNum;
	private int jTp;
	private String jDate;
	private int jStatus;
	private String jJname;
	private String jPhone;
	private String jPostcode;
	private String jOaddr1;
	private String jOaddr2;
	private String jOmesg;
	private String jOpay;
	private int jBno;
	private int jPpno;
	private String jPname;
	private int jPprice;
	private String jPimg;
	private String jPcate;
	
	public JumunDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getjNo() {
		return jNo;
	}

	public void setjNo(int jNo) {
		this.jNo = jNo;
	}

	public int getjPno() {
		return jPno;
	}

	public void setjPno(int jPno) {
		this.jPno = jPno;
	}

	public String getjId() {
		return jId;
	}

	public void setjId(String jId) {
		this.jId = jId;
	}

	public int getjNum() {
		return jNum;
	}

	public void setjNum(int jNum) {
		this.jNum = jNum;
	}

	public int getjTp() {
		return jTp;
	}

	public void setjTp(int jTp) {
		this.jTp = jTp;
	}

	public String getjDate() {
		return jDate;
	}

	public void setjDate(String jDate) {
		this.jDate = jDate;
	}

	public int getjStatus() {
		return jStatus;
	}

	public void setjStatus(int jStatus) {
		this.jStatus = jStatus;
	}

	public String getjJname() {
		return jJname;
	}

	public void setjJname(String jJname) {
		this.jJname = jJname;
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

	public String getjOaddr1() {
		return jOaddr1;
	}

	public void setjOaddr1(String jOaddr1) {
		this.jOaddr1 = jOaddr1;
	}

	public String getjOaddr2() {
		return jOaddr2;
	}

	public void setjOaddr2(String jOaddr2) {
		this.jOaddr2 = jOaddr2;
	}

	public String getjOmesg() {
		return jOmesg;
	}

	public void setjOmesg(String jOmesg) {
		this.jOmesg = jOmesg;
	}

	public String getjOpay() {
		return jOpay;
	}

	public void setjOpay(String jOpay) {
		this.jOpay = jOpay;
	}

	public int getjBno() {
		return jBno;
	}

	public void setjBno(int jBno) {
		this.jBno = jBno;
	}

	public int getjPpno() {
		return jPpno;
	}

	public void setjPpno(int jPpno) {
		this.jPpno = jPpno;
	}

	public String getjPname() {
		return jPname;
	}

	public void setjPname(String jPname) {
		this.jPname = jPname;
	}

	public int getjPprice() {
		return jPprice;
	}

	public void setjPprice(int jPprice) {
		this.jPprice = jPprice;
	}

	public String getjPimg() {
		return jPimg;
	}

	public void setjPimg(String jPimg) {
		this.jPimg = jPimg;
	}

	public String getjPcate() {
		return jPcate;
	}

	public void setjPcate(String jPcate) {
		this.jPcate = jPcate;
	}
}