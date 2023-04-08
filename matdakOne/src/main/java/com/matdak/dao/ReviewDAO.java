package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.dto.ReviewDTO;
import com.matdak.entity.Review;

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
	 
	//insertReview(review) - 리뷰글 삽입
	public int insertReview(Review review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into REVIEW values(review_seq.nextval,?,?,?,sysdate,1,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getrHid());
			pstmt.setInt(2, review.getrJno());
			pstmt.setString(3, review.getrContent());
			pstmt.setInt(4, review.getrStatus());
			pstmt.setString(5, review.getrImg());
			pstmt.setInt(6, review.getrStar());
		
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertRview() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//updateReview(review) - 리뷰글 변경
	public int updateReview(Review review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update REVIEW set R_CONTENT=?, R_STATUS=?, R_STAR=?, R_IMG=? where R_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, review.getrContent());
			pstmt.setInt(2, review.getrStatus());
			pstmt.setInt(3, review.getrStar());
			pstmt.setString(4, review.getrImg());
			pstmt.setInt(5, review.getrNo());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReview() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updaterStatus(rNo,rStatus) - 리뷰글 상태 변경 /0:삭제 1:일반 2:비밀
	public int updaterStatus(int rNo, int rStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update REVIEW set R_STATUS=? where R_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rStatus);
			pstmt.setInt(2, rNo);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updaterStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//selectReviewByrNo(rNo) - 글번호를 전달받아 리뷰글 출력
	public Review selectReviewByrNo(int rNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO reviewDTO=null;
		Review review=null;
		try {
			con=getConnection();
			
			String sql="select R_NO,R_HID,R_JNO,R_CONTENT,R_DATE,R_LOOK,R_STATUS,R_IMG,R_STAR,H_NAME from REVIEW join HEWON on R_HID=H_ID where R_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, rNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				reviewDTO=new ReviewDTO();
				review=new Review();
				review.setrNo(rs.getInt("R_NO"));
				review.setrHid(rs.getString("R_HID"));
				review.setrJno(rs.getInt("R_JNO"));
				review.setrContent(rs.getString("R_CONTENT"));
				review.setrDate(rs.getString("R_DATE"));
				review.setrLook(rs.getInt("R_LOOK"));
				review.setrStatus(rs.getInt("R_STATUS"));
				review.setrImg(rs.getString("R_IMG"));		
				review.setrStar(rs.getInt("R_STAR"));	
				reviewDTO.setReview(review);
				reviewDTO.setWriter(rs.getString("H_NAME"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewByrNo() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return review;
	}	


	
	
	/*
	이름        널?       유형             
	--------- -------- -------------- 
	R_NO      NOT NULL NUMBER(4)      - 리뷰번호 / pk, 시퀀스
	R_HID     NOT NULL VARCHAR2(20)   - 회원아이디 / fk
	R_JNO     NOT NULL NUMBER(10)     - 주문상품번호 / fk
	R_CONTENT NOT NULL VARCHAR2(2000) - 리뷰 컨텐츠
	R_DATE    NOT NULL DATE           - 리뷰 작성날짜
	R_LOOK    NOT NULL NUMBER(4)      - 리뷰 조회수
	R_STATUS  NOT NULL NUMBER(1)      - 리뷰글 상태 / 0:삭제 1:일반 2:비밀
	R_IMG              VARCHAR2(2000) - 리뷰 이미지
	R_STAR    NOT NULL NUMBER(1)      - 리뷰 별점 /1 ~ 5
	*/

	
	
		
	/*
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
	*/
	
}
