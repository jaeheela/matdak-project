package com.matdak.dto;

import lombok.Data;

@Data
public class Product {
	private int pNo;
	private String pName;
	private String pImg;
	private int pPrice;
	private String pInfo;
	private String pCate;
	private int pStock;
	private String pStatus;
	private String pRegdate;
}
