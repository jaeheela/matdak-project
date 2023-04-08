package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.HewonDTO;
import xyz.itwill.dto.JumunDTO;
import xyz.itwill.dto.NoticeDTO;

public class AdminDAO extends JdbcDAO {
	
	//싱글톤 패턴 
	public static AdminDAO _dao;
	
	public AdminDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new AdminDAO();
	}
	
	public static AdminDAO getDAO() {
		return _dao;
	}
	
	
		//상태를 전달받아 Notice 테이블에 저장된 해당 상태의 모든 제품정보를 검색하여 반환하는 메소드
		// => Notice 테이블에 저장된 제품정보를 검색하여 반환
		public List<NoticeDTO> selectNoticeList(int nStatus) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<NoticeDTO> NoticeList=new ArrayList<>();
			try {
				con=getConnection();
				
				//동적 SQL 기능을 사용하여 매개변수에 저장된 값에 따라 다른 SQL 명령이 전달되어
				//실행되도록 설정
				if(nStatus==1) {
					String sql="select N_CODE, N_ID,N_TITLE,N_STATUS,N_DATE from Notice where n_status=1 order by n_code desc";
					pstmt=con.prepareStatement(sql);
				} 
				else if(nStatus==0) {
					String sql="select N_CODE, N_ID,N_TITLE,N_STATUS,N_DATE from Notice where n_status=0 order by n_code desc";
					pstmt=con.prepareStatement(sql);
				} 
				
				else {
					String sql="select N_CODE, N_ID,N_TITLE,N_STATUS,N_DATE from Notice order by n_code desc";
					pstmt=con.prepareStatement(sql);
				}
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					NoticeDTO Notice=new NoticeDTO();
					Notice.setnCode(rs.getInt("N_CODE"));
					Notice.setnId(rs.getString("N_ID"));
					Notice.setnTitle(rs.getString("N_TITLE"));
					Notice.setnStatus(rs.getInt("N_STATUS"));
					Notice.setnDate("N_DATE");
					NoticeList.add(Notice);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return NoticeList;
		}

		//주문번호를 전달받아 Jumun 테이블에 저장된 해당 상태의 모든 제품정보를 검색하여 반환하는 메소드
		// => Jumun 테이블에 저장된 제품정보를 검색하여 반환
		public List<JumunDTO> selectJumunList(String Jno) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<JumunDTO> JumunList=new ArrayList<>();
			try {
				con=getConnection();
				String sql="select J_NO, J_ID, J_JNAME, J_STATUS, J_DATE from Jumun order by J_NO";
				pstmt=con.prepareStatement(sql);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JumunDTO Jumun=new JumunDTO();
					Jumun.setjNo(rs.getInt("J_NO"));
					Jumun.setjId(rs.getString("J_ID"));
					Jumun.setjTp(rs.getInt("J_TITLE"));
					Jumun.setjStatus(rs.getInt("J_STATUS"));
					Jumun.setjDate("N_DATE");
					JumunList.add(Jumun);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectNoticeList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return JumunList;
		}



	//5.
	//글번호(nCode)를 전달받아 NOTICE 테이블에 저장된 해당 글번호의 공지사항 글을 
	//검색하여 반환하는 메소드
	public NoticeDTO selectNotice(String nId) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select * from notice where n_id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, nId);
			
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



//2.	
//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달
//받아 NOTICE 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
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
//1.
	//검색 관련 정보를 전달받아 NOTICE 테이블에 저장된 
	//특정 게시글의 갯수를 검색하여 반환하는 메소드
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
	



//아이디를 전달받아 hewon 테이블에 저장된 해당 아이디의 회원정보를 검색하여 반환하는 메소드
	public HewonDTO selectHewonId(String email,String name) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		HewonDTO hewon=null;
		try {
			con=getConnection();
			
			String sql="select * from hewon where H_EMAIL=? and H_NAME=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, email);
			pstmt.setString(2, name);
			
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
	//아이디를 전달받아 hewon 테이블에 저장된 해당 아이디의 회원정보를 검색하여 반환하는 메소드
		public HewonDTO selectHewonPw(String email,String id,String name) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			HewonDTO hewon=null;
			try {
				con=getConnection();
				
				String sql="select * from hewon where H_EMAIL=? and H_id=? and H_name=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, email);
				pstmt.setString(2, id);
				pstmt.setString(3, name);
				
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
		//1.
		//검색 관련 정보를 전달받아 NOTICE 테이블에 저장된 
		//특정 게시글의 갯수를 검색하여 반환하는 메소드
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
					System.out.println("[에러]selectNoticeCount() 메서드의 SQL 오류 = "+e.getMessage());
				} finally {
					close(con, pstmt, rs);
				}
				return count;
			}
		
		



}
