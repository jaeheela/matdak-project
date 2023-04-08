package com.matdak.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.matdak.dto.BoardDTO;
import com.matdak.entity.Board;

public class BoardDAO extends JdbcDAO{
	public static BoardDAO _dao;
	public BoardDAO() {
		// TODO Auto-generated constructor stub
	}	
	static {
		_dao = new BoardDAO();
	}
	public static BoardDAO getDAO() {
		return _dao;
	}
	
	//insertBoard(board) - 게시판 등록
	public int insertBoard(Board board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="insert into BOARD values(board_seq.nextval,?,?,?,?,SYSDATE,1,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getbHid());
			pstmt.setString(2, board.getbCate());
			pstmt.setString(3, board.getbTitle());
			pstmt.setString(4, board.getbContent());
			pstmt.setInt(5, board.getbStatus());
			pstmt.setString(6, board.getbImg());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updateBoard(board) - 게시판 변경
	public int updateBoard(Board board) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="update BOARD set B_TITLE=?, B_CONTENT=?, B_IMG=? where B_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, board.getbTitle());
			pstmt.setString(2, board.getbContent());
			pstmt.setString(3, board.getbImg());

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateBoard() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//updatebStatus(bNo,bStatus) - 게시판상태 변경 / 0:삭제 1:일반 2:비밀
	public int updatebStatus(int bNo, int bStatus) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
					
			String sql="update BOARD set B_STATUS=? where B_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bStatus);
			pstmt.setInt(2, bNo);

			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatebStatus() 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//updatebLook(bNo) - 게시판조회수 +1
	public int updatebLook(int bNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update BOARD set B_LOOK=B_LOOK+1 where B_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bNo);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updatebLook() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}	
	
	//selectBoardBybNo(bNo) - 게시글번호를 전달받아 게시글 출력
	public BoardDTO selectBoardBybNo(int bNo) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		BoardDTO boardDTO=null;
		Board board=null;
		try {
			con=getConnection();
			
			String sql="select B_NO,B_HID,B_CATE,B_TITLE,B_CONTENT,B_DATE,B_LOOK,B_STATUS,B_IMG,H_NAME from BOARD join HEWON on B_HID=H_ID where B_NO=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, bNo);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				boardDTO=new BoardDTO();
				board=new Board();
				board.setbNo(rs.getInt("B_NO"));
				board.setbHid(rs.getString("B_HID"));
				board.setbCate(rs.getString("B_CATE"));
				board.setbTitle(rs.getString("B_TITLE"));
				board.setbContent(rs.getString("B_CONTENT"));
				board.setbDate(rs.getString("B_DATE"));
				board.setbLook(rs.getInt("B_LOOK"));
				board.setbStatus(rs.getInt("B_STATUS"));
				board.setbImg(rs.getString("B_IMG"));				
				boardDTO.setWriter(rs.getString("H_NAME"));
				boardDTO.setBoard(board);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectBoardBybNo() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return boardDTO;
	}
	
	/*
	 	//selectMoonCount(search,keyword)
	public int selectMoonCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();

			if(keyword.equals("")) {
				String sql="select count(*) from moon where m_status<>0";
				pstmt=con.prepareStatement(sql);
			} else {
				String sql="select count(*) from moon join hewon on h_id=m_id"
						+ " where "+search+" like '%'||?||'%' and m_status<>0";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonCount() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//selectMoonList(startRow,endRow,search,keyword)
	public List<MoonDTO> selectMoonList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MoonDTO> moonList=new ArrayList<MoonDTO>();
		try {
			con=getConnection();

			if(keyword.equals("")) {
				String sql="select * from (select rownum rn,temp.* from (select m_code,m_id, "
					+ "h_name,m_title,m_content,m_date,m_status,m_look,m_ip,m_ref,m_restep,m_relevel "
					+ "from moon join hewon on m_id=h_id"
					+ " order by m_ref desc, m_restep) temp) where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn,temp.* from (select m_code,m_id, "
						+ "h_name,m_title,m_content,m_date,m_status,m_look,m_ip,m_ref,m_restep,m_relevel "
						+ "from moon join hewon on m_id=h_id where "+search+" like '%'||?||'%' and m_status<>0"
						+ " order by m_ref desc, m_restep) temp) where rn between ? and ?";
					pstmt=con.prepareStatement(sql);
					pstmt.setString(1, keyword);
					pstmt.setInt(2, startRow);
					pstmt.setInt(3, endRow);
			}
			
			rs=pstmt.executeQuery();
					
			while(rs.next()) {
				MoonDTO moon=new MoonDTO();
				moon.setmCode(rs.getInt("m_code"));
				moon.setmId(rs.getString("m_id"));
				moon.setmWriter(rs.getString("h_name"));
				moon.setmTitle(rs.getString("m_title"));
				moon.setmContent(rs.getString("m_content"));
				moon.setmDate(rs.getString("m_date"));
				moon.setmStatus(rs.getInt("m_status"));
				moon.setmLook(rs.getInt("m_look"));
				moon.setmIp(rs.getString("m_ip"));
				moon.setmRef(rs.getInt("m_ref"));
				moon.setmRestep(rs.getInt("m_restep"));
				moon.setmRelevel(rs.getInt("m_relevel"));	
				moonList.add(moon);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMoonList() 메서드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return moonList;
	}
	 * */
	

}
