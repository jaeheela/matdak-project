package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.entity.Cart;
import com.matdak.entity.Jumun;

public class JumunDAO extends JdbcDAO {
	public static JumunDAO _dao;
	public JumunDAO() {
		// TODO Auto-generated constructor stub
	}
	static {
		_dao = new JumunDAO();
	}
	public static JumunDAO getDAO() {
		return _dao;
	}

	//insertJumun(jumun) - 주문상품 등록
	public int insertJumun(Jumun jumun) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into JUMUN values(jumun_seq.next_val,?,?,SYSDATE,?,?,?,?,?,?,?,?,1,0,0)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, jumun.getjHid());
			pstmt.setInt(2, jumun.getjPno());
			pstmt.setInt(3, jumun.getjPrice());
			pstmt.setInt(4, jumun.getjAcoount());
			pstmt.setInt(5, jumun.getjTotal());
			pstmt.setString(6, jumun.getjWay());
			pstmt.setString(7, jumun.getjName());
			pstmt.setString(8, jumun.getjPhone());
			pstmt.setString(9, jumun.getjPostcode());
			pstmt.setString(10, jumun.getjAddr());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertJumun() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatejStatus(jNo,jStatus) - 주문상품의 상태변경 -  / 주문완료:1 , 환불:0
	public int updatejStatus(int jNo, int jStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update JUMUN set J_STATUS=? where J_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, jStatus);
			pstmt.setInt(2, jNo);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updatejStatus() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatejRstatus(jNo,jStatus) - 주문상품의 리뷰상태변경 -  /리뷰작성완료:1 , 리뷰작성미완료:0
	public int updatejRstatus(int jNo, int jRstatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update JUMUN set J_RSTATUS=? where J_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, jRstatus);
			pstmt.setInt(2, jNo);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updatejRstatus() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatejDelstatus(jNo,jDelstatus) - 주문상품의 배송상태변경 - / 배송완료:1, 미배송:0
	public int updatejDelstatus(int jNo, int jDelstatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update JUMUN set J_DELSTATUS=? where J_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, jDelstatus);
			pstmt.setInt(2, jNo);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updatejDelstatus() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
}