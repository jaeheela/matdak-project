package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.BestDTO;
import xyz.itwill.dto.ProductDTO;

public class BestDAO extends JdbcDAO {
	private static BestDAO _dao;
	
	private BestDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new BestDAO();
	}
	
	public static BestDAO getDAO() {
		return _dao;
	}
	
	//BEST 테이블에 저장된 모든 상품을 검색
	public List<BestDTO> selectBestList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<BestDTO> bestList=new ArrayList<>();
		try {
			con=getConnection();
			String sql="select * from best order by bt_no";
			pstmt=con.prepareStatement(sql);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				BestDTO best=new BestDTO();
				best.setBtNo(rs.getInt("bt_no"));
				best.setBtName(rs.getString("bt_name"));
				best.setBtImg(rs.getString("bt_img"));
				best.setBtPrice(rs.getInt("bt_price"));
				best.setBtInfo(rs.getString("bt_info"));
				best.setBtStock(rs.getInt("bt_stock"));
				bestList.add(best);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectBestList() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return bestList;
	}
	
	//제품번호를 전달받아 BEST 테이블에 저장된 해당 제품번호의 제품정보를 검색하여 반환하는 메소드
	public BestDTO selectBest(int BtNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BestDTO best=null;
		try {
			con=getConnection();
			String sql="select * from best where BT_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, BtNo);
			rs=pstmt.executeQuery();
			if(rs.next()) {
				best=new BestDTO();
				best.setBtNo(rs.getInt("bt_no"));
				best.setBtName(rs.getString("bt_name"));
				best.setBtImg(rs.getString("bt_img"));
				best.setBtPrice(rs.getInt("bt_price"));
				best.setBtInfo(rs.getString("bt_info"));
				best.setBtStock(rs.getInt("bt_stock"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectBest() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return best;
	}
}