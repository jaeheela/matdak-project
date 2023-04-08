package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import xyz.itwill.dto.JumunDTO;

public class JumunDAO extends JdbcDAO {
	//싱글톤 패턴 
	public static JumunDAO _dao;
	
	public JumunDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao = new JumunDAO();
	}
	
	public static JumunDAO getDAO() {
		return _dao;
	}
	
	
	//주문정보(객체)를 전달받아 JUMUN 테이블에 삽입하는 DAO 클래스의 메소드 호출 
	public int insertJumun(JumunDTO jumun) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows =0;

		try {
			con = getConnection();

			//순서 : 식별자 상품번호 아이디 수량 총 금액 날짜 상태 이름 휴대폰 우편번호 기본주소 상세주소 배송메세지 결제수단 배송비
			String sql = "insert into jumun values(jumun_seq.nextval,?,?,?,?,sysdate,?,?,?,?,?,?,?,?,0)";

			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,jumun.getjPno() );
			pstmt.setString(2,jumun.getjId() );
			pstmt.setInt(3, jumun.getjNum() );
			pstmt.setInt(4, jumun.getjTp());
			pstmt.setInt(5,jumun.getjStatus() );
			pstmt.setString(6,jumun.getjJname() );
			pstmt.setString(7, jumun.getjPhone());
			pstmt.setString(8, jumun.getjPostcode() );
			pstmt.setString(9, jumun.getjOaddr1() );
			pstmt.setString(10, jumun.getjOaddr2() );
			pstmt.setString(11, jumun.getjOmesg() );
			pstmt.setInt(12, jumun.getjBno() );

			rows = pstmt.executeUpdate();

		} catch (SQLException e) {
			System.out.println("[에러]insertJumun() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	 
	 //아이디와 주문상태를 전달받아 jumun 테이블에 저장된 해당 아이디의 주문 내역에서 
	 //회원주문내역을 변경하고 개수를 반환하는 메소드 
	public int updatejStatus(int jno, int jStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();

			String sql="update jumun set j_status=? where j_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, jno);
			pstmt.setInt(2, jStatus);
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatejStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	 
	 
    //순서 : 식별자 상품번호 아이디 수량 총 금액 날짜 상태 이름 휴대폰 우편번호 기본주소 상세주소 배송메세지 결제수단 배송비
	 //아이디를 전달받아 jumun 테이블에 있는 주문 정보를 검색해 반환하는 메소드 
	public JumunDTO selectJumun (String jid) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		JumunDTO jumun=null;
		try {
			con=getConnection();

			String sql="select * from jumun where j_id=? ";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, jid);

			rs=pstmt.executeQuery();

			if(rs.next()) {
				jumun=new JumunDTO();
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
				jumun.setjBno(rs.getInt("j_bno"));
			}

		} catch (SQLException e) {
			System.out.println("[에러]selectJumun() 메서드의 SQL 오류 = "+e.getMessage());

		} finally {
			close(con, pstmt, rs);
		}
		return jumun;
	}


	public List<JumunDTO> selectJumunList(String jid){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<JumunDTO> jumunList = new ArrayList<>();

		try {
			con = getConnection();

			String sql = "select j_no,j_pno,j_id,j_num,j_tp,j_date,j_status,j_jname,j_phone,j_postcode,j_oaddr1,j_oaddr2,j_omesg,j_opay,j_bno,"
					+ " p_no,p_name,p_price,p_img,p_cate from jumun join product on j_pno=p_no where j_id=?  ";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, jid);

			rs = pstmt.executeQuery();

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
				jumun.setjBno(rs.getInt("j_bno"));
				jumun.setjPpno(rs.getInt("p_no"));
				jumun.setjPname(rs.getString("p_name"));
				jumun.setjPprice(rs.getInt("p_price"));
				jumun.setjPimg(rs.getString("p_img"));
				jumun.setjPcate(rs.getString("p_cate"));

				jumunList.add(jumun);
			}  
		}catch (SQLException e) {
			System.out.println("[에러]selectJumunList() 메소드의 SQL 오류 = "+e.getMessage());

		}finally {
			close(con, pstmt, rs);
		}
		return jumunList;
	} 
	
	//admin
	//selectJumunCount(String search, String keyword)
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
	
	//admin
	//selectJumunList(int startRow, int endRow, String search, String keyword)
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