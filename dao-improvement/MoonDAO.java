package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.MoonDTO;

public class MoonDAO extends JdbcDAO {
	private static MoonDAO _dao;
	
	private MoonDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new MoonDAO();
	}
	
	public static MoonDAO getDAO() {
		return _dao;
	}

	//selectMoonCount(String search, String keyword)
	public int selectMoonCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			if(keyword.equals("")) {
				String sql="select count(*) from moon where m_status<>0";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from moon join hewon on h_id=m_id"
						+ " where "+search+" like '%'||?||'%' and m_status<>0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//selectMoonList(int startRow, int endRow, String search, String keyword)
	public List<MoonDTO> selectMoonList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MoonDTO> moonList=new ArrayList<MoonDTO>();
		try {
			con=getConnection();

			if(keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from (select m_code,m_id, "
					+ "h_name,m_title,m_content,m_date,m_status,m_look,m_ip,m_ref,m_restep,m_relevel "
					+ "from moon join hewon on m_id=h_id"
					+ " order by m_ref desc, m_restep) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from (select m_code,m_id, "
						+ "h_name,m_title,m_content,m_date,m_status,m_look,m_ip,m_ref,m_restep,m_relevel "
						+ "from moon join hewon on m_id=h_id where "+search+" like '%'||?||'%' and m_status<>0"
						+ " order by m_ref desc, m_restep) temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
					
			while(rs.next()) {
				MoonDTO moon=new MoonDTO();
				moon.setmCode(rs.getInt("m_code"));
				moon.setmId(rs.getString("m_id"));
				moon.setmWriter(rs.getString("h_name"));
				moon.setmTitle(rs.getString("m_title"));
				moon.setmContent(rs.getString("m_content"));
				moon.setmDate(rs.getString("m_date"));
				moon.setmStatus(rs.getInt("m_status"));
				moon.setmLook(rs.getInt("m_look"));
				moon.setmIp(rs.getString("m_ip"));
				moon.setmRef(rs.getInt("m_ref"));
				moon.setmRestep(rs.getInt("m_restep"));
				moon.setmRelevel(rs.getInt("m_relevel"));	
				moonList.add(moon);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonList() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moonList;
	}
	
	//selectNextNum
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select moon_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//insertMoon(MoonDTO moon)
	public int insertMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			String sql="insert into moon values(?,?,?,?,sysdate,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, moon.getmCode());
			pstmt.setString(2, moon.getmId());
			pstmt.setString(3, moon.getmTitle());
			pstmt.setString(4, moon.getmContent());
			pstmt.setInt(5, moon.getmStatus());
			pstmt.setInt(6, moon.getmLook());
			pstmt.setString(7, moon.getmIp());
			pstmt.setInt(8, moon.getmRef());
			pstmt.setInt(9, moon.getmRestep());
			pstmt.setInt(10, moon.getmRelevel());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertMoon() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatemRestep(int mRef, int mRestep)
	public int updatemRestep(int mRef, int mRestep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update moon set m_restep=m_restep+1 where m_ref=? and m_restep>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mRef);
			pstmt.setInt(2, mRestep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatemRestep() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
		
	//selectMoon(int mCode)
	public MoonDTO selectMoon(int mCode) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		MoonDTO moon=null;
		try {
			con=getConnection();
			
			String sql="select m_code,m_id,h_name,m_title,m_content,m_date,m_status,"
					+ "m_look,m_ip,m_ref,m_restep,m_relevel from moon join hewon "
					+ "on m_id=h_id where m_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mCode);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				moon=new MoonDTO();
				moon.setmCode(rs.getInt("m_code"));
				moon.setmId(rs.getString("m_id"));
				moon.setmWriter(rs.getString("h_name"));
				moon.setmTitle(rs.getString("m_title"));
				moon.setmContent(rs.getString("m_content"));
				moon.setmDate(rs.getString("m_date"));
				moon.setmStatus(rs.getInt("m_status"));
				moon.setmLook(rs.getInt("m_look"));
				moon.setmIp(rs.getString("m_ip"));
				moon.setmRef(rs.getInt("m_ref"));
				moon.setmRestep(rs.getInt("m_restep"));
				moon.setmRelevel(rs.getInt("m_relevel"));	
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoon() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moon;
	}
	
	//updatemLook(int mCode)
	public int updatemLook(int mCode) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update moon set m_look=m_look+1 where m_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mCode);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatemLook() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateMoon(MoonDTO moon)
	public int updateMoon(MoonDTO moon) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update moon set m_title=?,m_content=?,m_status=? where m_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, moon.getmTitle());
			pstmt.setString(2, moon.getmContent());
			pstmt.setInt(3, moon.getmStatus());
			pstmt.setInt(4, moon.getmCode());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMoon() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatemStatus(int mCode, int mStatus)
	public int updatemStatus(int mCode, int mStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update moon set m_status=? where m_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, mStatus);
			pstmt.setInt(2, mCode);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatemStatus() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
}