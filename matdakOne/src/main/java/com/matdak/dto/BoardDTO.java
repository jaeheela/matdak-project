package com.matdak.dto;

import com.matdak.entity.Board;

public class BoardDTO {
	private Board board;
	private String writer;
	public BoardDTO() {
		// TODO Auto-generated constructor stub
	}
	public Board getBoard() {
		return board;
	}
	public void setBoard(Board board) {
		this.board = board;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
}
