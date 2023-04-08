package xyz.itwill.dto;

/*
이름      널?       유형            
------- -------- ------------- 
P_NO    NOT NULL NUMBER(10)    
P_NAME  NOT NULL VARCHAR2(20)  
P_IMG   NOT NULL VARCHAR2(500) 
P_PRICE NOT NULL NUMBER(20)    
P_INFO  NOT NULL VARCHAR2(500) 
P_CATE  NOT NULL VARCHAR2(10)  
P_STOCK NOT NULL NUMBER(10)
P_STATUS		 VARCHAR2(20) 		
P_REGDATE		 DATE
*/
public class ProductDTO {
	private int pNo;
	private String pName;
	private String pImg;
	private int pPrice;
	private String pInfo;
	private String pCate;
	private int pStock;
	private String pStatus;
	private String pRegdate;

	public ProductDTO() {
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

	public String getpImg() {
		return pImg;
	}

	public void setpImg(String pImg) {
		this.pImg = pImg;
	}

	public int getpPrice() {
		return pPrice;
	}

	public void setpPrice(int pPrice) {
		this.pPrice = pPrice;
	}

	public String getpInfo() {
		return pInfo;
	}

	public void setpInfo(String pInfo) {
		this.pInfo = pInfo;
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

	public String getpStatus() {
		return pStatus;
	}

	public void setpStatus(String pStatus) {
		this.pStatus = pStatus;
	}
	
	public String getpRegdate() {
		return pRegdate;
	}

	public void setpRegdate(String pRegdate) {
		this.pRegdate = pRegdate;
	}
}