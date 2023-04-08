package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.NoticeDTO;
import xyz.itwill.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO {
	private static ReviewDAO _dao;
	
	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	
	public static ReviewDAO getDAO() {
		return _dao;
	}

	//1.
	//검색 관련 정보를 전달받아 REVIEW 테이블에 저장된 
	//특정 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectReviewCount(String reveiwSearch, String reviewKeyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(reviewKeyword.equals("")) {//검색 키워드가 없을 경우
				if(reveiwSearch.equals("")) {//검색대상 없음
					String sql = "select count(*) from review where r_status<>0";					
					pstmt=con.prepareStatement(sql);
				} else if(reveiwSearch.equals("highDate")) {
					String sql = "select count(*) from review where r_status<>0 order by r_date desc";	
					pstmt=con.prepareStatement(sql);					
				} else if(reveiwSearch.equals("lowDate")) {
					String sql = "select count(*) from review where r_status<>0 order by r_date";			
					pstmt=con.prepareStatement(sql);					
				} else if(reveiwSearch.equals("highStar")) {
					String sql = "select count(*) from review where r_status<>0 order by r_star desc";	
					pstmt=con.prepareStatement(sql);							
				} else if(reveiwSearch.equals("lowStar")) {
					String sql = "select count(*) from review where r_status<>0 order by r_star";	
					pstmt=con.prepareStatement(sql);							
				}
			}else {//검색 키워드가 있을 경우
				if(reveiwSearch.equals("")) {//검색대상 없음
					String sql = "select count(*) from review where r_content like '%'||?||'%' and r_status<>0";					
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
				} else if(reveiwSearch.equals("highDate")) {
					String sql = "select count(*) from review where r_content like '%'||?||'%' and "
							+ "r_status<>0 order by r_date desc";	
					pstmt=con.prepareStatement(sql);	
					pstmt.setString(1, reviewKeyword);
				} else if(reveiwSearch.equals("lowDate")) {
					String sql = "select count(*) from review where r_content like '%'||?||'%' and "
							+ "r_status<>0 order by r_date";			
					pstmt=con.prepareStatement(sql);	
					pstmt.setString(1, reviewKeyword);
				} else if(reveiwSearch.equals("highStar")) {
					String sql = "select count(*) from review where r_content like '%'||?||'%' and "
							+ "r_status<>0 order by r_star desc";	
					pstmt=con.prepareStatement(sql);				
					pstmt.setString(1, reviewKeyword);
				} else if(reveiwSearch.equals("lowStar")) {
					String sql = "select count(*) from review where r_content like '%'||?||'%' and "
							+ "r_status<>0 order by r_star";	
					pstmt=con.prepareStatement(sql);		
					pstmt.setString(1, reviewKeyword);
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
	//받아 NOTICE 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ReviewDTO> selectReviewList(int startRow, int endRow, String reviewSearch, String reviewKeyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> reviewList = new ArrayList<ReviewDTO>();
		try {
			con=getConnection();
            			
			if(reviewKeyword.equals("")) {//검색 키워드가 없을 경우
				if(reviewSearch.equals("")) {//검색대상 없음
					String sql = "select * from (select rownum rn, temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_status<>0 "
							+ "order by r_code desc)temp) where rn between ? and ?";
					
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);
				} else if(reviewSearch.equals("highDate")) {
					String sql = "select * from (select rownum rn, temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_status<>0 "
							+ "order by r_date desc)temp) where rn between ? and ?";	
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);					
				} else if(reviewSearch.equals("lowDate")) {
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_status<>0 "
							+ "order by r_date)temp) where rn between ? and ?";			
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);					
				} else if(reviewSearch.equals("highStar")) {
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_status<>0 "
							+ "order by r_star desc)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);							
				} else if(reviewSearch.equals("lowStar")) {
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_status<>0 "
							+ "order by r_star)temp) where rn between ? and ?";										
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);							
				}
			}else {//검색 키워드가 있을 경우
				if(reviewSearch.equals("")) {//검색대상 없음
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_content like '%'||?||'%' "
							+ "and r_status<>0 order by r_code desc)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else if(reviewSearch.equals("highDate")) {
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_content like '%'||?||'%' "
							+ "and r_status<>0 order by r_date desc)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else if(reviewSearch.equals("lowDate")) {
					String sql = "select * from (select rownum rn,temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_content like '%'||?||'%' "
							+ "and r_status<>0 order by r_date)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else if(reviewSearch.equals("highStar")) {
					String sql = "select * from (select rownum rn, temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_content like '%'||?||'%' "
							+ "and r_status<>0 order by r_star desc)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else if(reviewSearch.equals("lowStar")) {
					String sql = "select * from (select rownum rn, temp.* from "
							+ "(select r_code,r_id,r_content,r_date,r_status,r_image,r_star,r_jno,p_no,p_name,p_img "
							+ "from review join jumun on j_no=r_Jno join product on j_pno=p_no where r_content like '%'||?||'%' "
							+ "and r_status<>0 order by r_star)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, reviewKeyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				}
			}
			          
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO review = new ReviewDTO();
				review.setrCode(rs.getInt("r_code"));
				review.setrId(rs.getString("r_id"));
				review.setrContent(rs.getString("r_content"));
				review.setrDate(rs.getString("r_date"));
				review.setrStatus(rs.getInt("r_status"));
				review.setrImage(rs.getString("r_image"));
				review.setrStar(rs.getInt("r_star"));
				review.setrStar(rs.getInt("r_star"));
				review.setrPno(rs.getInt("p_no"));
				review.setrJno(rs.getInt("r_jno")); //제품리뷰할 주문번호
				review.setrPimg(rs.getString("p_img"));
				review.setrPname(rs.getString("p_name"));
				reviewList.add(review);  //List 객체의 요소로 추가 반드시
			}
		}catch (SQLException e) {
			System.out.println("[에러]selectReviewList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return reviewList;	
	}			
		
	//3.
	//REVIEW_SEQ 시퀀스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextnum=0;
		try {
			con=getConnection();
			
			String sql="select review_seq.nextval from dual";
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

	//4.
	//리뷰 글을 전달받아 REVIEW 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
		public int insertRview(ReviewDTO review) {
			Connection con=null;
			PreparedStatement pstmt=null;
			int rows=0;
			try {
				con=getConnection();
				
				String sql="insert into review values(?,?,?,?,sysdate,?,?,?,?)";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, review.getrCode());
				pstmt.setString(2, review.getrId());
				pstmt.setInt(3, review.getrJno());
				pstmt.setString(4, review.getrContent());
				pstmt.setInt(5, review.getrStatus());
				pstmt.setString(6, review.getrImage());
				pstmt.setInt(7, review.getrStar());
				pstmt.setInt(8, review.getrDone());
			
				rows=pstmt.executeUpdate();
			} catch (SQLException e) {
				System.out.println("[에러]insertRview() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt);
			}
			return rows;
		}
		
	//5.
	//리뷰글번호(rCode)를 전달받아 REVIEW 테이블에 저장된 해당 번호의 리뷰글을 
	//검색하여 반환하는 메소드 - 리뷰수정하기 위해 필요
	public ReviewDTO selectReview(int rCode) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO review=null;
		try {
			con=getConnection();
			
			String sql="select r_code,r_id,r_jno,r_content,r_date,r_status,r_image,r_star,r_done "
					+ "from review where r_code=?"; //단일행 다중컬럼
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rCode);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				review=new ReviewDTO();
				review.setrCode(rs.getInt("r_code"));
				review.setrId(rs.getString("r_id"));
				review.setrJno(rs.getInt("r_jno"));
				review.setrContent(rs.getString("r_content"));
				review.setrDate(rs.getString("r_date"));
				review.setrStatus(rs.getInt("r_status"));
				review.setrImage(rs.getString("r_image"));		
				review.setrStar(rs.getInt("r_star"));	
				review.setrDone(rs.getInt("r_done"));	
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return review;
	}	

	//6.
	//리뷰글을 전달받아 REVIEW 테이블에 저장된 해당 게시글을 변경하고 
	//변경행의 갯수를 반환하는 메소드
	public int updateReview(ReviewDTO review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set r_content=?, r_image=?, r_status=?, r_star=?, r_jno=? where r_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getrContent());
			pstmt.setString(2, review.getrImage());
			pstmt.setInt(3, review.getrStatus());
			pstmt.setInt(4, review.getrStar());
			pstmt.setInt(5, review.getrJno());
			pstmt.setInt(6, review.getrCode());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//7.
	//글번호와 글상태를 전달받아 REVIEW 테이블에 저장된 해당 글번호의 게시글에 대한 상태를 
	//변경하고 변경행의 갯수를 반환하는 메소드
	// 0 (삭제글), 1(일반글), 2(비밀글)
	public int updaterStatus(int rCode, int rStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update review set r_status=? where r_code=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rCode);
			pstmt.setInt(2, rStatus);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updaterStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//admin
	//selectReviewCount(String search, String keyword,int rStatus)
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
	
	//admin
	//selectReviewList(int startRow, int endRow, String search, String keyword,int rStatus)
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
