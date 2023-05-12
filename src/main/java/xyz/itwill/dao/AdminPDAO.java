package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.ProductDTO;

public class AdminPDAO extends JdbcDAO {
	private static AdminPDAO _dao;
	
	private AdminPDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new AdminPDAO();
	}
	
	public static AdminPDAO getDAO() {
		return _dao;
	}
	
	//제품번호를 전달받아 PRODUCT 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 반환하는 메소드
	public ProductDTO selectProduct(int pNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductDTO product=null;
		try {
			con=getConnection();
			
			String sql="select * from product where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new ProductDTO();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg(rs.getString("P_IMG"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpInfo(rs.getString("P_INFO"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getString("P_STATUS"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	

	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 PRODUCT 테이블에 저장된 
	//특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductListSearch(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			
			/* search 값이 0일 경우 모든 상품 중에 검색되도록
			} else if(search=="0") {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " where p_status="+search+",1,2,3,4,5 and p_name like '%'||?||'%'"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			*/
				
			} else {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " where p_status="+search+" and p_name like '%'||?||'%'"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg(rs.getString("P_IMG"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpInfo(rs.getString("P_INFO"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getString("P_STATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListSearch() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 PRODUCT 테이블에 저장된 
	//특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductListKeyword(int startRow, int endRow, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " where p_name like '%'||?||'%'"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg(rs.getString("P_IMG"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpInfo(rs.getString("P_INFO"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getString("P_STATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListKeyword() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
		
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into product values(product_seq.nextval,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpName());
			pstmt.setString(2, product.getpImg());
			pstmt.setInt(3, product.getpPrice());
			pstmt.setString(4, product.getpInfo());
			pstmt.setString(5, product.getpCate());
			pstmt.setInt(6, product.getpStock());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//제품정보를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 변경하고 변경행의 갯수를 반환하는 메소드.
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();		
			String sql="update product set P_CATE=?,P_NAME=?,P_IMG=?,P_PRICE=?,P_INFO=?,P_STOCK=? where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpCate());
			pstmt.setString(2, product.getpName());
			pstmt.setString(3, product.getpImg());
			pstmt.setInt(4, product.getpPrice());
			pstmt.setString(5, product.getpInfo());
			pstmt.setInt(6, product.getpStock());
			pstmt.setInt(7, product.getpNo());
			System.out.println("pNo= "+product.getpNo());
			System.out.println("pStock= "+product.getpStock());
		
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//1.
	//검색 관련 정보를 전달받아 product 테이블에 저장된 
	//특정 게시글의 갯수를 검색하여 반환하는 메소드
		public int selectProductCount(String search, String keyword,String category) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
				try {
					con=getConnection();

					if(category.equals("ALL")) {
						String sql="select count(*) from product";
						pstmt=con.prepareStatement(sql);
					} 
					 else if(category.equals("DAKGASM")) {
						String sql="select count(*) from product where p_cate='DAKGASM'";
						pstmt=con.prepareStatement(sql);
					}  
					 else if(category.equals("ANSIM")) {
						String sql="select count(*) from product where p_cate='ANSIM'";
						pstmt=con.prepareStatement(sql);
					} 
					 else if(category.equals("DOSIRAK")) {
							String sql="select count(*) from product where p_cate='DOSIRAK'";
							pstmt=con.prepareStatement(sql);
						} 
					 else if(category.equals("INSTANT")) {
							String sql="select count(*) from product where p_cate='INSTANT'";
							pstmt=con.prepareStatement(sql);
						} 
					 else if(category.equals("DESSERT")) {
							String sql="select count(*) from product where p_cate='DESSERT'";
							pstmt=con.prepareStatement(sql);
						} 
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectproductCount() 메서드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
				}
			
			
//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 모든 제품정보를 검색하여 반환하는 메소드
// => PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환
public List<ProductDTO> selectProductList(String category) {
	Connection con=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	List<ProductDTO> productList=new ArrayList<>();
	try {
		con=getConnection();
		
		//동적 SQL 기능을 사용하여 매개변수에 저장된 값에 따라 다른 SQL 명령이 전달되어
		//실행되도록 설정
		if(category.equals("ALL")) {
			String sql="select * from product order by p_no desc ";
			pstmt=con.prepareStatement(sql);
		} 
		
		else {
			String sql="select * from product where p_cate=? order by p_no desc";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, category);
		}
		
		rs=pstmt.executeQuery();
		
		while(rs.next()) {
			ProductDTO product=new ProductDTO();
			product.setpNo(rs.getInt("P_NO"));
			product.setpName(rs.getString("P_NAME"));
			product.setpImg(rs.getString("P_IMG"));
			product.setpPrice(rs.getInt("P_PRICE"));
			product.setpInfo(rs.getString("P_INFO"));
			product.setpCate(rs.getString("P_CATE"));
			product.setpStock(rs.getInt("P_STOCK"));
			product.setpStatus(rs.getString("P_STATUS"));
			productList.add(product);
		}
	} catch (SQLException e) {
		System.out.println("[에러]selectProductList() 메소드의 SQL 오류 = "+e.getMessage());
	} finally {
		close(con, pstmt, rs);
	}
	return productList;
}


//8.
//글번호와 글상태를 전달받아 product 테이블에 저장된 해당 글번호의 게시글에 대한 상태를 
//변경하고 변경행의 갯수를 반환하는 메소드
// 0 (삭제글), 1(일반글)
public int updatepStatus(int pNo,String pStatus) {
	Connection con=null;
	PreparedStatement pstmt=null;
	int rows=0;
	try {
		con=getConnection();
		
		String sql="update product set P_STATUS=0 where P_NO=?";
		pstmt=con.prepareStatement(sql);
		pstmt.setString(1, pStatus);
		pstmt.setInt(2, pNo);
		rows=pstmt.executeUpdate();
	} catch (SQLException e) {
		System.out.println("[에러]updatenStatus() 메소드의 SQL 오류 = "+e.getMessage());
	} finally {
		close(con, pstmt);
	}
	return rows;
}
//BOARD_SEQ 시퀸스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select product_seq.nextval from dual";
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
	
	//2.	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달
	//받아 product 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductList(int startRow, int endRow, String search, String keyword,String category) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con=getConnection();
                   
			//동적 SQL(Dynamic SQL)
			if(category.equals("DAKGASM")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product where P_CATE='DAKGASM' "
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if (category.equals("ALL")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product "
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if (category.equals("ANSIM")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product where P_CATE='ANSIM'"
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if (category.equals("DOSIRAK")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product where P_CATE='DOSIRAK'"
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if (category.equals("INSTANT")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product where P_CATE='INSTANT'"
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			else if (category.equals("DESSERT")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from product where P_CATE='DESSERT'"
						+ "order by P_NO desc)temp) where rn between ? and ?";	
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1,startRow);
				pstmt.setInt(2,endRow);
			} 
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product=new ProductDTO();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg(rs.getString("P_IMG"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpInfo(rs.getString("P_INFO"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getString("P_STATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectproductList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;	
	}		
		
}
