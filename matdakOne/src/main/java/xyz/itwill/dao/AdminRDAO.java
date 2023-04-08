package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ReviewDTO;
import xyz.itwill.dto.ReviewDTO;
import xyz.itwill.dto.ReviewDTO;

public class AdminRDAO extends JdbcDAO {
	
	//싱글톤 패턴 
	public static AdminRDAO _dao;
	
	public AdminRDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new AdminRDAO();
	}
	
	public static AdminRDAO getDAO() {
		return _dao;
	}

	//1.
		//검색 관련 정보를 전달받아 Review 테이블에 저장된 
		//특정 게시글의 갯수를 검색하여 반환하는 메소드
			public int selectReviewCount(String search, String keyword,int rStatus) {
				Connection con=null;
				PreparedStatement pstmt=null;
				ResultSet rs=null;
				int count=0;
				try {
					con=getConnection();
					if(keyword.equals("")) {
					if(rStatus==1) {
						String sql="select count(*) from Review where R_Status=1";
						pstmt=con.prepareStatement(sql);
					} 
					else if(rStatus==0){
						String sql="select count(*) from Review where R_Status=0";
						pstmt=con.prepareStatement(sql);
					} 
					else {
						String sql="select count(*) from Review ";
						pstmt=con.prepareStatement(sql);
					}
				}
					else {
						if(rStatus==1) {
							String sql="select count(*) from Review where R_Status=1 and R_id like '%'||?||'%'";
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
							
						} 
						else if(rStatus==0){
							String sql="select count(*) from Review where R_Status=0 and R_id like '%'||?||'%'";
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
						} 
						else {
							String sql="select count(*) from Review where R_id like '%'||?||'%'";
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
						}
					}
					
					rs=pstmt.executeQuery();
					
					if(rs.next()) {
						count=rs.getInt(1);
					}
				} catch (SQLException e) {
					System.out.println("[에러]selectReviewCount() 메서드의 SQL 오류 = "+e.getMessage());
				} finally {
					close(con, pstmt, rs);
				}
				return count;
			}
		
			//2.	
			//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달
			//받아 Review 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
			public List<ReviewDTO> selectReviewList(int startRow, int endRow, String search, String keyword,int rStatus) {
				Connection con=null;
				PreparedStatement pstmt=null;
				ResultSet rs=null;
				List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
				try {
					con=getConnection();
			              
					//동적 SQL(Dynamic SQL)
					if(keyword.equals("")) {
					if(rStatus==0) {  
						String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
								+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
								+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=0 and r_id like"
								+ "order by r_code desc)temp) where rn between ? and ?";	
						pstmt=con.prepareStatement(sql);
						pstmt.setInt(1,startRow);
						pstmt.setInt(2,endRow);
					} 
					else if(rStatus==1) {  
						String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
								+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
								+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=1 "
								+ "order by r_code desc)temp) where rn between ? and ?";	
						pstmt=con.prepareStatement(sql);
						pstmt.setInt(1,startRow);
						pstmt.setInt(2,endRow);
					} 
					else if(rStatus==2) {  
						String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
								+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
								+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=2 "
								+ "order by r_code desc)temp) where rn between ? and ?";	
						pstmt=con.prepareStatement(sql);
						pstmt.setInt(1,startRow);
						pstmt.setInt(2,endRow);
					} 
					
					
					else if(rStatus==10) {  
						String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
								+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
								+ "from Review join hewon on Review.r_id=hewon.h_id "
								+ "order by r_code desc)temp) where rn between ? and ?";	
						pstmt=con.prepareStatement(sql);
						pstmt.setInt(1,startRow);
						pstmt.setInt(2,endRow);
					} 
				}
					if(keyword.equals("")) {
						if(rStatus==0) {  
							String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
									+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
									+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=0 and r_id like '%'||?||'%'"
									+ "order by r_code desc)temp) where rn between ? and ?";	
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
							pstmt.setInt(2,startRow);
							pstmt.setInt(3,endRow);
						} 
						else if(rStatus==1) {  
							String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
									+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
									+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=1 and r_id like '%'||?||'%'"
									+ "order by r_code desc)temp) where rn between ? and ?";	
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
							pstmt.setInt(2,startRow);
							pstmt.setInt(3,endRow);
						} 
						else if(rStatus==2) {  
							String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
									+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
									+ "from Review join hewon on Review.r_id=hewon.h_id and r_status=2 and r_id like '%'||?||'%'"
									+ "order by r_code desc)temp) where rn between ? and ?";	
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
							pstmt.setInt(2,startRow);
							pstmt.setInt(3,endRow);
						} 
						
						
						else if(rStatus==10) {  
							String sql="select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE from (select rownum rn, temp.* from "
									+ "(select R_CODE, R_ID,R_CONTENT,R_STATUS,R_DATE "
									+ "from Review join hewon on Review.r_id=hewon.h_id where r_id like '%'||?||'%'"
									+ "order by r_code desc)temp) where rn between ? and ?";	
							pstmt=con.prepareStatement(sql);
							pstmt.setString(1, keyword);
							pstmt.setInt(2,startRow);
							pstmt.setInt(3,endRow);
						} 
					}
					rs=pstmt.executeQuery();
					
					while(rs.next()) {
						ReviewDTO review=new ReviewDTO();
						review.setrCode(rs.getInt("R_CODE"));
						review.setrId(rs.getString("R_ID"));
						review.setrContent(rs.getString("R_CONTENT"));
						review.setrStatus(rs.getInt("R_STATUS"));
						review.setrDate(rs.getString("R_DATE"));

						reviewList.add(review);	}
				} catch (SQLException e) {
					System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = "+e.getMessage());
				} finally {
					close(con, pstmt, rs);
				}
				return reviewList;	
			}		
	
	
	
}
	
