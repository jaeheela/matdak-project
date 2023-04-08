package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.entity.Hewon;

public class HewonDAO extends JdbcDAO{
	private static HewonDAO _dao;	
	private HewonDAO() {
		// TODO Auto-generated constructor stub
	}	
	static {
		_dao=new HewonDAO();
	}	
	public static HewonDAO getDAO() {
		return _dao;
	}
	
	//insertHewon(hewon) - 회원가입
	public int insertHewon(Hewon hewon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into HEWON values(?,?,?,?,?,?,?,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hewon.gethId());
			pstmt.setString(2, hewon.gethPw());
			pstmt.setString(3, hewon.gethName());
			pstmt.setString(4, hewon.gethEmail());
			pstmt.setString(5, hewon.gethPhone());
			pstmt.setString(6, hewon.gethPostcode());
			pstmt.setString(7, hewon.gethAddr());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertHewon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateHewon(hewon) - 회원정보변경
	public int updateHewon(Hewon hewon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update HEWON set H_PW=?,H_NAME=?,H_EMAIL=?,H_PHONE=?,H_POSTCODE=?,H_ADDR=? where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hewon.gethPw());
			pstmt.setString(2, hewon.gethName());
			pstmt.setString(3, hewon.gethEmail());
			pstmt.setString(4, hewon.gethPhone());
			pstmt.setString(5, hewon.gethPostcode());
			pstmt.setString(6, hewon.gethAddr());
			pstmt.setString(7, hewon.gethId());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateHewon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatehStatus(hId,hStatus) - 회원상태 변경 /0:삭제 1:일반 9:관리자
	public int updatehStatus(String hId, int hStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update HEWON set H_STATUS=? where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, hStatus);
			pstmt.setString(2, hId);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatehStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//selectHewonByhId(hId) - 아이디를 전달받아 회원정보 출력
	public Hewon selectHewonByhId(String hId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Hewon hewon=null;
		try {
			con=getConnection();
			
			String sql="select * from HEWON where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hId);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				hewon=new Hewon();
				hewon.sethId(rs.getString("H_ID"));
				hewon.sethPw(rs.getString("H_PW"));
				hewon.sethName(rs.getString("H_NAME"));
				hewon.sethEmail(rs.getString("H_EMAIL"));
				hewon.sethPhone(rs.getString("H_PHONE"));
				hewon.sethPostcode(rs.getString("H_POSTCODE"));
				hewon.sethAddr(rs.getString("H_ADDR"));
				hewon.sethStatus(rs.getInt("H_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectHewonByhId() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return hewon;
	}
	
	//selectHewonByhId(hId)  이메일과 이름을 전달받아 회원정보 출력
	public Hewon selectHewonByhEmailhName(String hEmail, String hName) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Hewon hewon=null;
		try {
			con=getConnection();
			
			String sql="select * from HEWON where H_NAME=? and H_EMAIL=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hName);
			pstmt.setString(2, hEmail);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				hewon=new Hewon();
				hewon.sethId(rs.getString("H_ID"));
				hewon.sethPw(rs.getString("H_PW"));
				hewon.sethName(rs.getString("H_NAME"));
				hewon.sethEmail(rs.getString("H_EMAIL"));
				hewon.sethPhone(rs.getString("H_PHONE"));
				hewon.sethPostcode(rs.getString("H_POSTCODE"));
				hewon.sethAddr(rs.getString("H_ADDR"));
				hewon.sethStatus(rs.getInt("H_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectHewonByhEmailhName() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return hewon;
	}

	//selectHewonList() - 회원목록 출력
	public List<Hewon> selectHewonList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Hewon> hewonList=new ArrayList<>();
		try {
			con=getConnection();
			
			String sql="select * from HEWON order by H_ID";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Hewon hewon=new Hewon();
				hewon.sethId(rs.getString("H_ID"));
				hewon.sethPw(rs.getString("H_PW"));
				hewon.sethName(rs.getString("H_NAME"));
				hewon.sethEmail(rs.getString("H_EMAIL"));
				hewon.sethPhone(rs.getString("H_PHONE"));
				hewon.sethPostcode(rs.getString("H_POSTCODE"));
				hewon.sethAddr(rs.getString("H_ADDR"));
				hewon.sethStatus(rs.getInt("H_STATUS"));
				hewonList.add(hewon);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectHewonList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return hewonList;
	}
	
}