package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.BasketDTO;

//장바구니 DAO 클래스 
public class BasketDAO extends JdbcDAO {
	
	//싱글톤 패턴 
	public static BasketDAO _dao;
	
	public BasketDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new BasketDAO();
	}
	
	public static BasketDAO getDAO() {
		return _dao;
	}
	
	//insertBasket(BasketDTO basket)
	public int insertBasket(BasketDTO basket) {
		Connection con = null;
	    PreparedStatement pstmt = null;
	    int rows =0;
	    
	    try {
	      con = getConnection();
	      
	      String sql = "insert into basket values(basket_seq.nextval,?,?,?)";
	      
	      pstmt = con.prepareStatement(sql);
	      pstmt.setInt(1, basket.getbPno());                 //상품번호
	      pstmt.setString(2, basket.getbId());               //회원 아이디
	      pstmt.setInt(3, basket.getbNum());                 //수량
	      
	      rows = pstmt.executeUpdate();
	      		      		      
	    } catch (SQLException e) {
	      System.out.println("[에러]insertBasket() 메소드의 SQL 오류 = "+e.getMessage());
	      
	    } finally {
	      close(con, pstmt);
	    }
	    return rows;
	}
		 
	//추가
	//selectBasket(int bNo)
	public BasketDTO selectBasket(int bNo){
		Connection con = null;
		PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    BasketDTO basket= null;
    
	    try {
	      con = getConnection();
	      
	      String sql = "select b_no,b_pno,b_id,b_num,p_name,p_img,p_price from basket join product on p_no=b_pno where b_no=?";
	      
	      pstmt = con.prepareStatement(sql);
	      pstmt.setInt(1, bNo);
	      
	      rs = pstmt.executeQuery();
	      
	      /*
	      	private int bNo;
			private int bPno;
			private String bId;
			private int bNum;
			//PRODUCT테이블에 상품명을 저장하기 위한 필드 (컬럼값에는 없음)
			private String bPname;
			//PRODUCT테이블에 상품이미지를 저장하기 위한 필드 (컬럼값에는 없음)
			private String bPimag;
			//PRODUCT테이블에 상품가격을 저장하기 위한 필드 (컬럼값에는 없음)
			private String bPprice; 
	       */
	      
	      while(rs.next()) {
	        basket = new BasketDTO();
	        basket.setbNo(rs.getInt("b_no"));
	        basket.setbPno(rs.getInt("b_pno"));
			basket.setbId(rs.getString("b_id"));
			basket.setbNum(rs.getInt("b_num"));
			basket.setbPname(rs.getString("p_name"));
			basket.setbPimage(rs.getString("p_img"));
			basket.setbPprice(rs.getInt("p_price"));
			}
	      
	    }catch (SQLException e) {
	      System.out.println("[에러]selectBasket() 메소드의 SQL 오류 = "+e.getMessage());
	      
	    }finally {
			close(con, pstmt, rs);
		}
	    return basket;
	    
	  }
	  
	//추가
	//selectBasketCount(String id)
	public int selectBasketCount(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
		
			  String sql="select count(*) from basket where b_id=?";
			  pstmt=con.prepareStatement(sql);
			  pstmt.setString(1, id);
			
			  rs=pstmt.executeQuery();
			
			  if(rs.next()) {
				  count=rs.getInt(1);
			  }
		  } catch (SQLException e) {
			  System.out.println("[에러]selectBasketCount() 메서드의 SQL 오류 = "+e.getMessage());
			  } finally {
				  close(con, pstmt, rs);
			  }
			  return count;
		  }
	  
	//추가
	//selectBasketCountTwo(String id)
	public List<BasketDTO> selectBasketCountTwo(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BasketDTO> basketList = new ArrayList<>();
		try {
			con=getConnection();
		
			String sql="select b_no,b_pno,b_id,b_num,p_name,p_img,p_price "
		+ "from basket join product on p_no=b_pno where b_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
		
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
			    BasketDTO basket = new BasketDTO();
			    basket.setbNo(rs.getInt("b_no"));
			basket.setbPno(rs.getInt("b_pno"));
			basket.setbId(rs.getString("b_id"));
			basket.setbNum(rs.getInt("b_num"));
			basket.setbPname(rs.getString("p_name"));
			basket.setbPimage(rs.getString("p_img"));
			basket.setbPprice(rs.getInt("p_price"));
			basketList.add(basket);
			}  
		} catch (SQLException e) {
			System.out.println("[에러]selectBasketCountTwo() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return basketList;
	}
	  
	  
	//selectBasketList(String id)
	//아이디를 전달받아 Basket 테이블에 있는 장바구니 list를 검색해 반환하는 메소드 
	public List<BasketDTO> selectBasketList(String id){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<BasketDTO> basketList = new ArrayList<>();

		try {
			con = getConnection();

			String sql = "select b_no,b_id,b_pno,b_num from basket where b_id=? order by b_no ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			while(rs.next()) {
				BasketDTO basket = new BasketDTO();
				basket.setbNo(rs.getInt("b_no"));
				basket.setbId(rs.getString("b_id"));
				basket.setbPno(rs.getInt("b_pno"));
				basket.setbNum(rs.getInt("b_num")); 
				basketList.add(basket);
			}  
		} catch (SQLException e) {
			System.out.println("[에러]selectBasketList() 메소드의 SQL 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return basketList;
	}
	
	//제품 번호를 전달받아 해당 장바구니 정보를 삭제하고 삭제행의 개수를 반환하는 메소드 
	
	//deleteBasket(int bNo)
	public int deleteBasket(int bNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;

		try {
			con = getConnection();

			String sql = "delete from basket where b_no=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bNo);

			rows= pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]deleteBasket() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}

