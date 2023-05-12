package xyz.itwill.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

//JDBC 기능을 제공하는 DAO 클래스가 상속받기 위해 작성된 부모 클래스
// => 객체 생성이 목적이 아닌 상속으로 목적으로 작성된 클래스 - 추상클래스로 작성하는 것을 권장
// => WAS 프로그램에 등록된 자원을 얻어와 DataSource 객체를 반환받아 저장 - 정적영역을 이용해 1번만 실행
// => DataSource 객체로부터 Connection 객체를 제공받아 반환하는 메소드
// => 매개변수로 JDBC 관련 객체를 제공받아 제거하는 메소드

public abstract class JdbcDAO {
	
	//1.
	//WAS 프로그램에 등록된 자원을 얻어와 DataSource 객체를 반환받아 저장 - 정적영역을 이용해 1번만 실행
	private static DataSource dataSource; //Connection이 미리 10개 생성됨
	
	static { //메모리가 로딩되면 자동으로 아래의 명령 실행되어 객체 만들어짐
		try {
			dataSource = (DataSource)new InitialContext().lookup("java:comp/env/jdbc/oracle");
		}catch (NamingException e) {
			e.printStackTrace();
		}
	}

	//2.
	//DataSource 객체로부터 Connection 객체를 제공받아 반환하는 메소드
	public Connection getConnection() throws SQLException {
		return dataSource.getConnection();
	}
	
	//3.
	//매개변수로 JDBC 관련 객체를 제공받아 제거하는 메소드
	public void close(Connection con) {
		try {
			if(con!=null) con.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void close(Connection con, PreparedStatement pstmt) {
		try {
			if(con!=null) con.close();
			if(pstmt!=null) pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void close(Connection con, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(con!=null) con.close();
			if(pstmt!=null) pstmt.close();
			if(rs!=null) rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	
	
}

