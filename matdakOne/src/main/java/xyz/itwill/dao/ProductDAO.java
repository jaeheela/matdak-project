package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.BestDTO;
import xyz.itwill.dto.NoticeDTO;
import xyz.itwill.dto.ProductDTO;

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
	
	public List<ProductDTO> selectMainList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> mainList=new ArrayList<>();
		try {
			con=getConnection();
			String sql="select * from product order by p_no";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO main=new ProductDTO();
				main.setpNo(rs.getInt("p_no"));
				main.setpName(rs.getString("p_name"));
				main.setpImg(rs.getString("p_img"));
				main.setpPrice(rs.getInt("p_price"));
				main.setpInfo(rs.getString("p_info"));
				main.setpStock(rs.getInt("p_stock"));
				mainList.add(main);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMainList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return mainList;
	}
	
	//1.추가
	//검색 관련 정보를 전달받아 RPRDUCT 테이블에 저장된 
	//특정 게시글의 갯수를 검색하여 반환하는 메소드
		public int selectProductCount(String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();

				if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
					if(search.equals("ALL")||search.equals("")) {
						String sql="select count(*) from product where p_status<>0";
						pstmt=con.prepareStatement(sql);						
					} else {
						String sql="select count(*) from product where p_cate ='"+search+"'and p_status<>0";
						pstmt=con.prepareStatement(sql);							
					}

				} else {//검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록
					
					if(search.equals("ALL")) {
						String sql="select count(*) from product where p_name like '%'||?||'%' and p_status<>0";						
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, keyword);
					} else {
						String sql="select count(*) from product where p_cate ='"+search+"' and "
								+ "p_name like '%'||?||'%' and p_status<>0";
						pstmt=con.prepareStatement(sql);
						pstmt.setString(1, keyword);
					}				
				}
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectProductCount() 메서드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}
	
	//2.추가
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달
	//받아 NOTICE 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList = new ArrayList<ProductDTO>();
		try {
			con=getConnection();
                   
			//동적 SQL(Dynamic SQL)
			if(keyword.equals("")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
				if(search.equals("ALL") || search.equals("")) {
					String sql= "select * from (select rownum rn, temp.* from "
							+ "(select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status " 
							+"from product where p_status<>0 order by p_name)temp) "
							+ "where rn between ? and ?";			
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);
				} else  {
					String sql= "select * from (select rownum rn, temp.* from "
							+ "(select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status " 
							+"from product where p_status<>0 and p_cate='"+search+"'order by p_name)temp) "
							+ "where rn between ? and ?";			
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);					
				} 
				

			} else { //검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록				
				if(search.equals("ALL")) {
					String sql="select * from (select rownum rn, temp.* from "
							+ "(select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status "
							+ "from product where p_status<>0 and p_name like '%'||?||'%' "
							+ "order by p_name)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);	
				} else {
					String sql="select * from (select rownum rn, temp.* from "
							+ "(select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status "
							+ "from product where p_status<>0 and p_cate='"+search+"' and p_name like '%'||?||'%' "
							+ "order by p_name)temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);
				}		
			}
          
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO product = new ProductDTO();
				product.setpNo(rs.getInt("p_no"));
				product.setpName(rs.getString("p_name"));
				product.setpImg(rs.getString("p_img"));
				product.setpPrice(rs.getInt("p_price"));
				product.setpInfo(rs.getString("p_info"));
				product.setpCate(rs.getString("p_cate"));
				product.setpStock(rs.getInt("p_stock"));
				product.setpStatus(rs.getString("p_status"));
				productList.add(product);  //List 객체의 요소로 추가 반드시
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;	
	}		
	
	//검색 관련 정보를 전달받아 PRODUCT 테이블에 저장된 특정 상품 갯수를 검색하여 반환하는 메소드
	public int selectProductCountSearch(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from product";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from product where p_status="
						+search+" and p_name like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCountSearch() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//검색 관련 정보를 전달받아 PRODUCT 테이블에 저장된 특정 상품 갯수를 검색하여 반환하는 메소드
	public int selectProductCountKeyword(String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from product";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from product where p_name like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCountKeyword() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//PRODUCT 테이블의 P_STATUS와 검색 관련 정보를 전달받아 PRODUCT 테이블에 저장된 특정 상품 갯수를 검색하여 반환하는 메소드
	public int selectProductCountKeyword(ProductDTO product, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from product where p_status=?";
				pstmt=con.prepareStatement(sql);
			} else if(product.getpStatus().equals("1")) {
				String sql="select count(*) from product where p_status=1 and p_name like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			} else {
				String sql="select count(*) from product where p_status=? and p_name like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCountKeyword() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
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
	
	
	//관리자 페이지 사용
	
	//제품정보를 전달받아 PRODUCT 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into product values(?,?,?,?,?,?,?,1,sysdate)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, product.getpNo());
			pstmt.setString(2, product.getpName());
			pstmt.setString(3, product.getpImg());
			pstmt.setInt(4, product.getpPrice());
			pstmt.setString(5, product.getpInfo());
			pstmt.setString(6, product.getpCate());
			pstmt.setInt(7, product.getpStock());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
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
				product.setpRegdate(rs.getString("P_REGDATE"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return product;
	}
	
	//제품정보를 전달받아 PRODUCT 테이블에 저장된 해당 제품정보를 변경하고 변경행의 갯수를 반환하는 메소드.
	public int updateProduct(ProductDTO product) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="update product set P_CATE=?,P_NAME=?,P_IMG=?,P_INFO=?,P_STOCK=?,P_PRICE=? where P_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, product.getpCate());
			pstmt.setString(2, product.getpName());
			pstmt.setString(3, product.getpImg());
			pstmt.setString(4, product.getpInfo());
			pstmt.setInt(5, product.getpStock());
			pstmt.setInt(6, product.getpPrice());
			//pstmt.setString(7, product.getpStatus());
			pstmt.setInt(7, product.getpNo());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateProduct() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	public int updatepStatus(int pNo, int pStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update product set P_STATUS=? where P_NO=?";
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
	
	
	
	//카테고리
	//카테고리를 전달받아 PRODUCT 테이블에 저장된 특정 상품 갯수를 검색하여 반환하는 메소드
	public int selectProductCountpCate(String pCate) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(pCate.equals("ALL")) {
				String sql="select count(*) from product";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from product where p_cate=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCountpCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}

	//카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 모든 제품정보를 검색하여 반환하는 메소드
	// => PRODUCT 테이블에 저장된 모든 제품정보를 검색하여 반환
	public List<ProductDTO> selectProductListpCate(String pCate) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		try {
			con=getConnection();
			
			if(pCate.equals("ALL")) {
				String sql="select * from product order by p_no";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select * from product where p_cate=? order by p_no";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
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
				product.setpRegdate(rs.getString("P_REGDATE"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListpCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}

	//검색 관련 정보와 카테고리를 전달받아 PRODUCT 테이블에 저장된 해당 카테고리의 상품 갯수를 검색하여 반환하는 메소드
	public int selectProductCountKeywordpCate(String pCate, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select count(*) from product where p_cate=?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
			} else {
				String sql="select count(*) from product where p_cate=?"
						+" and p_name like '%'||?||'%'";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
				pstmt.setString(2, keyword);
			}
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductCountSearchpCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 PRODUCT 테이블에 저장된 
	//특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductListKeywordpCate(int startRow, int endRow, String pCate, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		try {
			con=getConnection();
			if(keyword.equals("")) {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " where p_cate=? order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
				
			} else {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status from product"
						+ " where p_cate=? and p_name like '%'||?||'%'"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
				pstmt.setString(2, keyword);
				pstmt.setInt(3, startRow);
				pstmt.setInt(4, endRow);
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
				product.setpStatus(rs.getString("P_STATUS"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListKeywordpCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}
	
	//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달받아 PRODUCT 테이블에 저장된 
	//특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
	public List<ProductDTO> selectProductListKeywordpCate(int startRow, int endRow, String pCate) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ProductDTO> productList=new ArrayList<>();
		try {
			con=getConnection();
			
			if(pCate.equals("ALL")) {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status,p_regdate from product"
						+ " order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
			} else {
				String sql="select * from"
						+ " (select rownum rn,temp.* from (select p_no,p_name,p_img,p_price,p_info,p_cate,p_stock,p_status,p_regdate from product"
						+ " where p_cate=? order by p_no) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, pCate);
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
				product.setpStatus(rs.getString("P_STATUS"));
				product.setpRegdate(rs.getString("P_REGDATE"));
				productList.add(product);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectProductListKeywordpCate() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return productList;
	}

}
