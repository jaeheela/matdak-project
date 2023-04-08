package xyz.itwill.dto;
/*
이름        널?       유형             
--------- -------- -------------- 
R_CODE    NOT NULL NUMBER(4)      - 리뷰번호(식별자)
R_ID               VARCHAR2(50)   - 리뷰작성자 아이디 - 회원테이블참조
R_JNO              NUMBER(20)     - 리뷰할 상품 - 주문테이블 참조
R_CONTENT          VARCHAR2(2000) - 리뷰 내용
R_DATE             DATE           - 리뷰 작성날짜
R_STATUS           NUMBER(1)      - 리뷰글 상태 0:삭제 1:일반 2:비밀
R_IMAGE            VARCHAR2(2000) - 리뷰이미지파일첨부
R_STAR             NUMBER(1)      - 리뷰별점 1 ~ 5
 */
public class ReviewDTO {
	int rCode;
	String rId;
	int rJno; //제품리뷰할 주문번호
	int rPno; //제품이미지 클릭 시 해당 카테고리로 가기 위해 상품코드 저장
	String rContent;
	String rDate;
	int rStatus;
	String rImage;
	int rStar;
	String rPimg; //product 테이블에서 값 가져와서 출력하기 위해 추가
	String rPname;
	int rDone;
	
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}

	public int getrCode() {
		return rCode;
	}

	public void setrCode(int rCode) {
		this.rCode = rCode;
	}

	public String getrId() {
		return rId;
	}

	public void setrId(String rId) {
		this.rId = rId;
	}

	public int getrJno() {
		return rJno;
	}

	public void setrJno(int rJno) {
		this.rJno = rJno;
	}

	public int getrPno() {
		return rPno;
	}

	public void setrPno(int rPno) {
		this.rPno = rPno;
	}

	public String getrContent() {
		return rContent;
	}

	public void setrContent(String rContent) {
		this.rContent = rContent;
	}

	public String getrDate() {
		return rDate;
	}

	public void setrDate(String rDate) {
		this.rDate = rDate;
	}

	public int getrStatus() {
		return rStatus;
	}

	public void setrStatus(int rStatus) {
		this.rStatus = rStatus;
	}

	public String getrImage() {
		return rImage;
	}

	public void setrImage(String rImage) {
		this.rImage = rImage;
	}

	public int getrStar() {
		return rStar;
	}

	public void setrStar(int rStar) {
		this.rStar = rStar;
	}

	public String getrPimg() {
		return rPimg;
	}

	public void setrPimg(String rPimg) {
		this.rPimg = rPimg;
	}

	public String getrPname() {
		return rPname;
	}

	public void setrPname(String rPname) {
		this.rPname = rPname;
	}

	public int getrDone() {
		return rDone;
	}

	public void setrDone(int rDone) {
		this.rDone = rDone;
	}
	
	
}