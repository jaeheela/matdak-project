package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.entity.Cart;
import com.matdak.entity.Hewon;
import com.matdak.entity.Product;


public class CartDAO extends JdbcDAO {
	public static CartDAO _dao;
	public CartDAO() {
		// TODO Auto-generated constructor stub
	}	
	static {
		_dao = new CartDAO();
	}
	public static CartDAO getDAO() {
		return _dao;
	}

	//insertCart(cart) - 장바구니 등록
	public int insertCart(Cart cart) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into CART values(?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cart.getcHId());
			pstmt.setInt(2, cart.getcPno());
			pstmt.setInt(3, cart.getcAccount());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateCart(cart) - 장바구니 수량변경
	public int updateCart(Cart cart) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="update CART set C_ACCOUNT=? where C_HID=? and C_PNO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cart.getcAccount());
			pstmt.setString(2, cart.getcHId());
			pstmt.setInt(3, cart.getcPno());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateCart() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//deleteCart(cHid,cPno) - 상품번호와 회원아이디를 전달받아 장바구니 한개삭제
	public int deleteCart(String cHid,int cPno) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from CART where C_HID=? and C_PNO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, cPno);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteCartBycPno() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//deleteCartList(cHid) - 회원아이디를 전달받아 장바구니 전체삭제
	public int deleteCartList(String cHid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="delete from CART where C_HID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, cHid);

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteCartList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

}

