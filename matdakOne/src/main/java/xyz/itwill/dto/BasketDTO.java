package xyz.itwill.dto;
/*
 이름    널?       유형           
----- -------- ------------ 
B_NO  NOT NULL NUMBER(20)   --장바구니 번호 (시퀀스 이용)
B_PNO NOT NULL NUMBER(10)   //PRODUCT 테이블 FK  P_NO     -- 상품번호
B_ID  NOT NULL VARCHAR2(20) //HEWON 테이블 FK  H_ID       -- 회원아이디 
B_NUM NOT NULL NUMBER(10)   -- 상품 수량
 */
/**
 * @author JaeHee La
 *
 */
public class BasketDTO {
	private int bNo;
	private int bPno;
	private String bId;
	private int bNum;
	//PRODUCT테이블에 상품명을 저장하기 위한 필드 (컬럼값에는 없음)
	private String bPname;
	//PRODUCT테이블에 상품이미지를 저장하기 위한 필드 (컬럼값에는 없음)
	private String bPimage;
	//PRODUCT테이블에 상품가격을 저장하기 위한 필드 (컬럼값에는 없음)
	private int bPprice;
	
	public BasketDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getbNo() {
		return bNo;
	}

	public void setbNo(int bNo) {
		this.bNo = bNo;
	}

	public int getbPno() {
		return bPno;
	}

	public void setbPno(int bPno) {
		this.bPno = bPno;
	}

	public String getbId() {
		return bId;
	}

	public void setbId(String bId) {
		this.bId = bId;
	}

	public int getbNum() {
		return bNum;
	}

	public void setbNum(int bNum) {
		this.bNum = bNum;
	}

	public String getbPname() {
		return bPname;
	}

	public void setbPname(String bPname) {
		this.bPname = bPname;
	}

	public String getbPimage() {
		return bPimage;
	}

	public void setbPimage(String bPimage) {
		this.bPimage = bPimage;
	}

	public int getbPprice() {
		return bPprice;
	}

	public void setbPprice(int bPprice) {
		this.bPprice = bPprice;
	}


	
	
}
