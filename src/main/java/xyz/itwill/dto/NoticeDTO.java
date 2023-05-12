package xyz.itwill.dto;
/*
이름        널?       유형             
--------- -------- -------------- 
N_CODE    NOT NULL NUMBER(4)      
N_ID               VARCHAR2(50)   
N_CONTENT          VARCHAR2(2000) 
N_DATE             DATE           
N_LOOK             NUMBER(10)     
N_STATUS           NUMBER(1)      
N_IMAGE            VARCHAR2(2000) 
N_TITLE            VARCHAR2(40)   

 */
public class NoticeDTO {
	int nCode;
	String nId;
	String nWriter;  //작성자 - HEWON테이블에서 join하여 가져오기
	String nContent;
	String nDate;
	int nLook;
	int nStatus;
	String nImage;
	String nTitle;
	
	public NoticeDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getnCode() {
		return nCode;
	}

	public void setnCode(int nCode) {
		this.nCode = nCode;
	}

	public String getnId() {
		return nId;
	}

	public void setnId(String nId) {
		this.nId = nId;
	}

	public String getnWriter() {
		return nWriter;
	}

	public void setnWriter(String nWriter) {
		this.nWriter = nWriter;
	}

	public String getnContent() {
		return nContent;
	}

	public void setnContent(String nContent) {
		this.nContent = nContent;
	}

	public String getnDate() {
		return nDate;
	}

	public void setnDate(String nDate) {
		this.nDate = nDate;
	}

	public int getnLook() {
		return nLook;
	}

	public void setnLook(int nLook) {
		this.nLook = nLook;
	}

	public int getnStatus() {
		return nStatus;
	}

	public void setnStatus(int nStatus) {
		this.nStatus = nStatus;
	}

	public String getnImage() {
		return nImage;
	}

	public void setnImage(String nImage) {
		this.nImage = nImage;
	}

	public String getnTitle() {
		return nTitle;
	}

	public void setnTitle(String nTitle) {
		this.nTitle = nTitle;
	}

	
}
