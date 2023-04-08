package com.matdak.dto;

import com.matdak.entity.Review;

public class ReviewDTO {
	private Review review;
	private String writer;
	public ReviewDTO() {
		// TODO Auto-generated constructor stub
	}
	public Review getReview() {
		return review;
	}
	public void setReview(Review review) {
		this.review = review;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
}
