package com.matdak.dto;

import lombok.Data;

@Data
public class Review {
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
}
