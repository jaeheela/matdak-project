package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.HewonDTO;
import xyz.itwill.dto.JumunDTO;
import xyz.itwill.dto.ProductDTO;

public class AdminJDAO extends JdbcDAO{
private static AdminJDAO _dao;
	
	private AdminJDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new AdminJDAO();
	}
	
	public static AdminJDAO getDAO() {
		return _dao;
	}
	

	//1.
	//검색 관련 정보를 전달받아 jumun 테이블에 저장된 
	//특정 게시글의 갯수를 검색하여 반환하는 메소드
		public int selectJumunCount(String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			int count=0;
			try {
				con=getConnection();

				if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
					String sql="select count(*) from jumun "; // where j_status<>1은 우선 예외 0번이 기본.
					pstmt=con.prepareStatement(sql);
				} else {//검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록
					String sql="select count(*) from jumun where j_id like '%'||?||'%'";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
				}
				
				rs=pstmt.executeQuery();
				
				if(rs.next()) {
					count=rs.getInt(1);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectjumunCount() 메서드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return count;
		}
		
		//2.	
		//검색 관련 정보 및 요청 페이지에 대한 시작 게시글의 행번호와 종료 게시글의 행번호를 전달
		//받아 PRODUCT 테이블에 저장된 특정 게시글에서 해당 범위의 게시글만을 검색하여 반환하는 메소드
		public List<JumunDTO> selectJumunList(int startRow, int endRow, String search, String keyword) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<JumunDTO> jumunList = new ArrayList<>();
			try {
				con=getConnection();
	                   
				//동적 SQL(Dynamic SQL)
				if(keyword.equals("")) { //검색 기능을 사용하지 않은 경우 - 삭제글은 검색되지 않도록
					String sql="select * from (select rownum rn, temp.* from (select * from jumun " //where j_status<>1
							+ "order by j_no desc)temp) where rn between ? and ?";	
					pstmt=con.prepareStatement(sql);
					pstmt.setInt(1,startRow);
					pstmt.setInt(2,endRow);
				}
			
				else { //검색 기능을 사용한 경우 - 삭제글은 검색되지 않도록
					String sql="select * from (select rownum rn, temp.* from (select * from jumun where j_id like '%'||?||'%' "// and j_status<>1
							+ "order by j_no desc)temp) where rn between ? and ?" ;
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2,startRow);
					pstmt.setInt(3,endRow);			
				}
	       
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					JumunDTO jumun=new JumunDTO();
					jumun.setjNo(rs.getInt("j_no"));
					jumun.setjPno(rs.getInt("j_pno"));
					jumun.setjId(rs.getString("j_id"));
					jumun.setjNum(rs.getInt("j_num"));
					jumun.setjTp(rs.getInt("j_tp"));
					jumun.setjDate(rs.getString("j_date"));
					jumun.setjStatus(rs.getInt("j_status"));
					jumun.setjJname(rs.getString("j_jname"));
					jumun.setjPhone(rs.getString("j_phone"));
					jumun.setjPostcode(rs.getString("j_postcode"));
					jumun.setjOaddr1(rs.getString("j_oaddr1"));
					jumun.setjOaddr2(rs.getString("j_oaddr2"));
					jumun.setjOmesg(rs.getString("j_omesg"));
					jumun.setjOpay(rs.getString("j_opay"));
					jumun.setjBno(rs.getInt("j_Bno"));
					jumunList.add(jumun);
				}
				
			} catch (SQLException e) {
				System.out.println("[에러]selectjumunList() 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return jumunList;	
		}	
			
		
		
}
