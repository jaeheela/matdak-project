package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.HewonDTO;

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
	
	//insertHewon(HewonDTO hewon)
	public int insertHewon(HewonDTO hewon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into hewon values(?,?,?,?,?,?,?,?,1)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hewon.gethId());
			pstmt.setString(2, hewon.gethPw());
			pstmt.setString(3, hewon.gethEmail());
			pstmt.setString(4, hewon.gethPhone());
			pstmt.setString(5, hewon.gethName());
			pstmt.setString(6, hewon.gethPostcode());
			pstmt.setString(7, hewon.gethAddr1());
			pstmt.setString(8, hewon.gethAddr2());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertStudent() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateLastLogin(String id)
	public int updateLastLogin(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update hewon set last_login=sysdate where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateLastLogin() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateHewon(HewonDTO hewon)
	public int updateHewon(HewonDTO hewon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update hewon set H_PW=?,H_NAME=?,h_Email=?,H_PHONE=?,H_POSTCODE=?"
					+ ",H_ADDR1=?,H_ADDR2=? where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, hewon.gethPw());
			pstmt.setString(2, hewon.gethName());
			pstmt.setString(3, hewon.gethEmail());
			pstmt.setString(4, hewon.gethPhone());
			pstmt.setString(5, hewon.gethPostcode());
			pstmt.setString(6, hewon.gethAddr1());
			pstmt.setString(7, hewon.gethAddr2());
			pstmt.setString(8, hewon.gethId());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatehewon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateStatus(String id, int status)
	public int updateStatus(String id, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update hewon set H_STATUS=? where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//selectHewon(String id) 
	public HewonDTO selectHewon(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		HewonDTO hewon=null;
		try {
			con=getConnection();
			
			String sql="select * from hewon where H_ID=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				hewon=new HewonDTO();
				hewon.sethId(rs.getString("H_ID"));
				hewon.sethPw(rs.getString("H_PW"));
				hewon.sethName(rs.getString("H_NAME"));
				hewon.sethEmail(rs.getString("H_Email"));
				hewon.sethPhone(rs.getString("H_PHONE"));
				hewon.sethPostcode(rs.getString("H_POSTCODE"));
				hewon.sethAddr1(rs.getString("H_ADDR1"));
				hewon.sethAddr2(rs.getString("H_ADDR2"));
				hewon.sethStatus(rs.getInt("H_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectHewon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return hewon;
	}
	
	//selectHewonCount(String keyword)
	public int selectHewonCount(String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from hewon";
				pstmt=con.prepareStatement(sql);
			}
			else {
					String sql="select count(*) from hewon where h_id like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectHewonCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//selectHewonList()
	public List<HewonDTO> selectHewonList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<HewonDTO> hewonList=new ArrayList<>();
		try {
			con=getConnection();
			
			String sql="select * from hewon order by h_id";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				HewonDTO hewon=new HewonDTO();
				hewon.sethId(rs.getString("h_id"));
				hewon.sethPw(rs.getString("h_pw"));
				hewon.sethName(rs.getString("h_name"));
				hewon.sethEmail(rs.getString("h_email"));
				hewon.sethPhone(rs.getString("h_phone"));
				hewon.sethPostcode(rs.getString("h_postcode"));
				hewon.sethAddr1(rs.getString("h_addr1"));
				hewon.sethAddr2(rs.getString("h_addr2"));
				hewon.sethStatus(rs.getInt("h_status"));
				hewonList.add(hewon);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selecthewonList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return hewonList;
	}
	
	//selectHewonList(int startRow, int endRow, String keyword)
	public List<HewonDTO> selectHewonList(int startRow, int endRow, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<HewonDTO> hewonList = new ArrayList<HewonDTO>();
		try {
			con=getConnection();
	        if(keyword.equals("")) {
			//동적 SQL(Dynamic SQL)
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from hewon "
						+ "order by h_id desc) temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);	
	        }
			else {
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from hewon where h_id like '%'||?||'%'  "
						+ "order by h_id desc) temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1,keyword);
				pstmt.setInt(2,startRow);
				pstmt.setInt(3,endRow);	
	        }
	     
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				HewonDTO hewon=new HewonDTO();
				hewon.sethId(rs.getString("H_ID"));
				hewon.sethPw(rs.getString("H_PW"));
				hewon.sethName(rs.getString("H_NAME"));
				hewon.sethEmail(rs.getString("H_Email"));
				hewon.sethPhone(rs.getString("H_PHONE"));
				hewon.sethPostcode(rs.getString("H_POSTCODE"));
				hewon.sethAddr1(rs.getString("H_ADDR1"));
				hewon.sethAddr2(rs.getString("H_ADDR2"));
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

	//deleteHewon(String id) - 미사용
	public int deleteHewon(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from hewon where h_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deletehewon() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}