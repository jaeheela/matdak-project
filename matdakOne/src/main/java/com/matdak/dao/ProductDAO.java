package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.entity.Product;


public class ProductDAO extends JdbcDAO {
	private static ProductDAO _dao;
	private ProductDAO() {
		// TODO Auto-generated constructor stub
	}	
	static {
		_dao=new ProductDAO();
	}	
	public static ProductDAO getDAO() {
		return _dao;
	}
	
	//insertProduct(product) - 상품등록
	public int insertProduct(Product product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into PRODUCT values(product_seq.nextval,?,?,?,?,?,?,1,SYSDATE)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpName());
			pstmt.setString(2, product.getpImg1());
			pstmt.setString(3, product.getpImg2());
			pstmt.setInt(4, product.getpPrice());
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
	
	//updateProduct(product) - 상품변경
	public int updateProduct(Product product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="update PRODUCT set P_NAME=?,P_IMG1=?,P_IMG2=?,P_PRICE=?,P_CATE=?,P_STOCK=? where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpName());
			pstmt.setString(2, product.getpImg1());
			pstmt.setString(3, product.getpImg2());
			pstmt.setInt(4, product.getpPrice());
			pstmt.setString(5, product.getpCate());
			pstmt.setInt(6, product.getpStock());
			pstmt.setInt(7, product.getpNo());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
			
	
	//updatepStatus(pNo,pStatus) - 상품상태변경 -  0:삭제 1:존재, 2:베스트
	public int updatepStatus(int pNo, int pStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update PRODUCT set P_STATUS=? where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pStatus);
			pstmt.setInt(2, pNo);
			
			rows=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			System.out.println("[에러]updatepStatus() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//selectProductBypNo(pNo) - 상품번호 전달받아 상품 출력
	public Product selectProductBypNo(int pNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		Product product=null;
		try {
			con=getConnection();
			
			String sql="select * from PRODUCT where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, pNo);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				product=new Product();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg1(rs.getString("P_IMG1"));
				product.setpImg2(rs.getString("P_IMG2"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getInt("P_STATUS"));
				product.setpDate(rs.getString("P_DATE"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductBypNo() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	

	//ProductCountBypCate(pCate,keyword) - 검색어와 카테고리 전달받아 총 갯수 출력
	public int ProductCountBypCate(String pCate, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			if(keyword.equals("")) {//검색 기능 미사용
				if(pCate.equals("ALL")||pCate.equals("")) {
					String sql="select count(*) from PRODUCT where P_STATUS<>0";
					pstmt=con.prepareStatement(sql);						
				} else {
					String sql="select count(*) from PRODUCT where P_CATE ='"+pCate+"'and P_STATUS<>0";
					pstmt=con.prepareStatement(sql);							
				}

			} else {//검색 기능 사용
				
				if(pCate.equals("ALL")) {
					String sql="select count(*) from PRODUCT where P_NAME like '%'||?||'%' and P_STATUS<>0";						
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				} else {
					String sql="select count(*) from PRODUCT where P_CATE ='"+pCate+"' and P_NAME like '%'||?||'%' and P_STATUS<>0";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}				
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]ProductCountBypCate() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
		
	//selectProductListBypCate(pCate)- 카테고리 전달받아 상품리스트 출력
	public List<Product> selectProductListBypCate(String pCate) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Product> productList=new ArrayList<>();
		try {
			con=getConnection();
			
			if(pCate.equals("ALL")) {
				String sql="select * from PRODUCT where P_STATUS<>0  order by P_NO desc";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select * from PRODUCT where P_CATE=? and P_STATUS<>0 order by p_no";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
			}		
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				Product product=new Product();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg1(rs.getString("P_IMG1"));
				product.setpImg2(rs.getString("P_IMG2"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getInt("P_STATUS"));
				product.setpDate(rs.getString("P_DATE"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListBypCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//selectProductListBypCate(startRow,endRow,pCate,keyword) - 행번호, 검색어, 카테고리를 전달받아 원하는 갯수만큼 출력 
	public List<Product> selectProductListBypCate(int startRow, int endRow, String pCate, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<Product> productList = new ArrayList<Product>();
		try {
			con=getConnection();
                   
			if(keyword.equals("")) { //검색 기능 미사용
				if(pCate.equals("ALL") || pCate.equals("")) {
					String sql= "select * from (select rownum rn, temp.* from (select * from PRODUCT where P_STATUS<>0 order by P_NAME)temp) where rn between ? and ?";			
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);
				} else  {
					String sql= "select * from (select rownum rn, temp.* from (select * from PRODUCT where P_STATUS<>0 and P_CATE='"+pCate+"'order by P_NAME)temp) where rn between ? and ?";			
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);					
				} 
				

			} else { //검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록				
				if(pCate.equals("ALL")) {
					String sql="select * from (select rownum rn, temp.* from (select * from PRODUCT where P_STATUS<>0 and P_NAME like '%'||?||'%' order by P_NAME)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else {
					String sql="select * from (select rownum rn, temp.* from (select * from PRODUCT where P_STATUS<>0 and P_CATE='"+pCate+"' and P_NAME like '%'||?||'%' order by P_NAME)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);
				}		
			}
          
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				Product product = new Product();
				product.setpNo(rs.getInt("P_NO"));
				product.setpName(rs.getString("P_NAME"));
				product.setpImg1(rs.getString("P_IMG1"));
				product.setpImg2(rs.getString("P_IMG2"));
				product.setpPrice(rs.getInt("P_PRICE"));
				product.setpCate(rs.getString("P_CATE"));
				product.setpStock(rs.getInt("P_STOCK"));
				product.setpStatus(rs.getInt("P_STATUS"));
				product.setpDate(rs.getString("P_DATE"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListBypCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;	
	}	

	
}
