package com.matdak.dto;

import lombok.Data;

@Data
public class Notice {
	int nCode;
	String nId;
	String nWriter;  //작성자 - HEWON테이블에서 join하여 가져오기
	String nContent;
	String nDate;
	int nLook;
	int nStatus;
	String nImage;
	String nTitle;
}
