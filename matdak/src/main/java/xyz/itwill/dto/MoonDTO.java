package xyz.itwill.dto;
/*
이름        널?       유형             
--------- -------- -------------- 
M_CODE    NOT NULL NUMBER(4)      
M_ID               VARCHAR2(20)   
M_TITLE            VARCHAR2(20)   
M_CONTENT          VARCHAR2(2000) 
M_DATE             DATE           
M_STATUS           NUMBER(4)      
M_LOOK             NUMBER(20)     
M_IP               VARCHAR2(20)   
M_REF              NUMBER(4)      
M_RESTEP           NUMBER(4)      
M_RELEVEL          NUMBER(4)    
 */
public class MoonDTO {
	int mCode;
	String mId;
	String mWriter;
	String mTitle;
	String mContent;
	String mDate;
	int mStatus;
	int mLook;
	String mIp;
	int mRef;
	int mRestep;
	int mRelevel;
	
	public MoonDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getmCode() {
		return mCode;
	}

	public void setmCode(int mCode) {
		this.mCode = mCode;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public String getmWriter() {
		return mWriter;
	}

	public void setmWriter(String mWriter) {
		this.mWriter = mWriter;
	}

	public String getmTitle() {
		return mTitle;
	}

	public void setmTitle(String mTitle) {
		this.mTitle = mTitle;
	}

	public String getmContent() {
		return mContent;
	}

	public void setmContent(String mContent) {
		this.mContent = mContent;
	}

	public String getmDate() {
		return mDate;
	}

	public void setmDate(String mDate) {
		this.mDate = mDate;
	}

	public int getmStatus() {
		return mStatus;
	}

	public void setmStatus(int mStatus) {
		this.mStatus = mStatus;
	}

	public int getmLook() {
		return mLook;
	}

	public void setmLook(int mLook) {
		this.mLook = mLook;
	}

	public String getmIp() {
		return mIp;
	}

	public void setmIp(String mIp) {
		this.mIp = mIp;
	}

	public int getmRef() {
		return mRef;
	}

	public void setmRef(int mRef) {
		this.mRef = mRef;
	}

	public int getmRestep() {
		return mRestep;
	}

	public void setmRestep(int mRestep) {
		this.mRestep = mRestep;
	}

	public int getmRelevel() {
		return mRelevel;
	}

	public void setmRelevel(int mRelevel) {
		this.mRelevel = mRelevel;
	}

}