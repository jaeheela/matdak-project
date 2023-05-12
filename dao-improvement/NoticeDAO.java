package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.NoticeDTO;

public class NoticeDAO extends JdbcDAO {
	private static NoticeDAO _dao;
	
	private NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}
	
	//selectNoticeCount(String search, String keyword)
	public int selectNoticeCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select count(*) from notice where n_status<>0";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록
				String sql="select count(*) from notice join hewon on notice.n_id=hewon.h_id"
						+ " where "+search+" like '%'||?||'%' and n_status<>0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//selectNoticeList(int startRow, int endRow, String search, String keyword)
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
                   
			//동적 SQL(Dynamic SQL)
			if(keyword.equals("")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
						+ "from notice join hewon on notice.n_id=hewon.h_id where n_status<>0 "
						+ "order by n_code desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} else { //검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
						+ "from notice join hewon on notice.n_id=hewon.h_id "
						+ " where "+search+" like '%'||?||'%' and n_status<>0 "
						+ "order by n_code desc)temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2,startRow);
				pstmt.setInt(3,endRow);			
			}
          
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setnCode(rs.getInt("n_code"));
				notice.setnId(rs.getString("n_id"));
				notice.setnWriter(rs.getString("h_name"));
				notice.setnContent(rs.getString("n_content"));
				notice.setnDate(rs.getString("n_date"));
				notice.setnLook(rs.getInt("n_look"));
				notice.setnStatus(rs.getInt("n_status"));
				notice.setnImage(rs.getString("n_image"));
				notice.setnTitle(rs.getString("n_title"));
				noticeList.add(notice);  //List 객체의 요소로 추가 반드시
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;	
	}	
		
	//selectNextNum()
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextnum=0;
		try {
			con=getConnection();
			
			String sql="select notice_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextnum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextnum;
	}	

	//insertNotice(NoticeDTO notice)
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into notice values(?,?,?,sysdate,0,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getnCode());
			pstmt.setString(2, notice.getnId());
			pstmt.setString(3, notice.getnContent());
			pstmt.setInt(4, notice.getnStatus());
			pstmt.setString(5, notice.getnImage());
			pstmt.setString(6, notice.getnTitle());
		
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
		
	//selectNotice(int nCode)
	public NoticeDTO selectNotice(int nCode) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select n_code, n_id, h_name,n_content,n_date,n_look,n_status,n_image,n_title"
					+ " from notice join hewon on notice.n_id=hewon.h_id where n_code=?"; //단일행 다중컬럼
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, nCode);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				notice=new NoticeDTO();
				notice.setnCode(rs.getInt("n_code"));
				notice.setnId(rs.getString("n_id"));
				notice.setnWriter(rs.getString("h_name"));
				notice.setnContent(rs.getString("n_content"));
				notice.setnDate(rs.getString("n_date"));
				notice.setnLook(rs.getInt("n_look"));
				notice.setnStatus(rs.getInt("n_status"));
				notice.setnImage(rs.getString("n_image"));
				notice.setnTitle(rs.getString("n_title"));			
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNotice() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}	

	//updatenLook(int nCode) 
	public int updatenLook(int nCode) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set n_look=n_look+1 where n_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, nCode);
			
			rows=pstmt.executeUpdate();		
		} catch (SQLException e) {
			System.out.println("[에러]updatenLook() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//updateNotice(NoticeDTO notice) 
	public int updateNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set n_title=?, n_content=?, n_image=?  where n_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, notice.getnTitle());
			pstmt.setString(2, notice.getnContent());
			pstmt.setString(3, notice.getnImage());
			pstmt.setInt(4, notice.getnCode());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNotice() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatenStatus(int nCode, int nStatus)
	public int updatenStatus(int nCode, int nStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set n_status=? where n_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, nStatus);
			pstmt.setInt(2, nCode);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatenStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//admin
	//selectNoticeList(int startRow, int endRow, String search, String keyword,int nStatus)
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow, String search, String keyword,int nStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<NoticeDTO> noticeList = new ArrayList<NoticeDTO>();
		try {
			con=getConnection();
	        if(keyword.equals("")) {
			//동적 SQL(Dynamic SQL)
			if(nStatus==0) {  
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
						+ "from notice join hewon on notice.n_id=hewon.h_id and n_status=0  "
						+ "order by n_code desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if(nStatus==1) {  
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
						+ "from notice join hewon on notice.n_id=hewon.h_id and n_status=1 "
						+ "order by n_code desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			
			
			else if(nStatus==10) {  
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
						+ "from notice join hewon on notice.n_id=hewon.h_id "
						+ "order by n_code desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
	        }
			else {
				//동적 SQL(Dynamic SQL)
				if(nStatus==0) {  
					String sql="select * from (select rownum rn, temp.* from "
							+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
							+ "from notice join hewon on notice.n_id=hewon.h_id and n_status=0 and n_id like '%'||?||'%' "
							+ "order by n_code desc)temp) where rn between ? and ?";	
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);
				} 
				else if(nStatus==1) {  
					String sql="select * from (select rownum rn, temp.* from "
							+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
							+ "from notice join hewon on notice.n_id=hewon.h_id and n_status=1 and n_id like '%'||?||'%'"
							+ "order by n_code desc)temp) where rn between ? and ?";	
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);
				} 
				
				
				else if(nStatus==10) {  
					String sql="select * from (select rownum rn, temp.* from "
							+ "(select n_code,n_id,h_name,n_content,n_date,n_look,n_status,n_image,n_title "
							+ "from notice join hewon on notice.n_id=hewon.h_id  and n_id like '%'||?||'%'"
							+ "order by n_code desc)temp) where rn between ? and ?";	
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1,keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);
				} 
		        
	     
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeDTO notice = new NoticeDTO();
				notice.setnCode(rs.getInt("n_code"));
				notice.setnId(rs.getString("n_id"));
				notice.setnWriter(rs.getString("h_name"));
				notice.setnContent(rs.getString("n_content"));
				notice.setnDate(rs.getString("n_date"));
				notice.setnLook(rs.getInt("n_look"));
				notice.setnStatus(rs.getInt("n_status"));
				notice.setnImage(rs.getString("n_image"));
				notice.setnTitle(rs.getString("n_title"));
				noticeList.add(notice);  //List 객체의 요소로 추가 반드시
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return noticeList;	
	}
	
	//admin
	//selectNoticeCount(String search, String keyword,int nStatus) 
	public int selectNoticeCount(String search, String keyword,int nStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
			if(nStatus==1) {
				String sql="select count(*) from notice where n_Status=1";
				pstmt=con.prepareStatement(sql);
				
			} 
			else if(nStatus==0){
				String sql="select count(*) from notice where n_Status=0";
				pstmt=con.prepareStatement(sql);
			} 
			else {
				String sql="select count(*) from notice ";
				pstmt=con.prepareStatement(sql);
			}
			}
			else {
				if(nStatus==1) {
					String sql="select count(*) from notice where n_Status=1 and n_id like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				} 
				else if(nStatus==0){
					String sql="select count(*) from notice where n_Status=0 and n_id like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				} 
				else {
					String sql="select count(*) from notice where n_id like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
				}
			
			
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
}
