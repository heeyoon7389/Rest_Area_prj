package restAreaDbConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DbConnection {
	private static DbConnection dbCon;
	
	private DbConnection() {
		
	}
	
	public static DbConnection getInstance() {
		if(dbCon == null) {
			dbCon = new DbConnection();
		}
		return dbCon;
	}//getInstance
	
	public Connection getConn(String dbcpName) throws SQLException{
		Connection con = null;
//		String dbcpName = "jdbc/restarea";
		//1. JNDI 사용객체 생성
		try {
			Context ctx = new InitialContext();
			//2. DBCP에서 DataSource
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/"+dbcpName);
			//3. DataSource에서 Connection 얻기
			con = ds.getConnection();
		}catch (NamingException ne) {
			ne.printStackTrace();
		}
		return con;
	}// getConn
	
	public Connection getConn() throws SQLException{
		Connection con = null;
//		String dbcpName = "jdbc/restarea";
		//1. JNDI 사용객체 생성
		try {
			Context ctx = new InitialContext();
			//2. DBCP에서 DataSource
			DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/restarea");
			//3. DataSource에서 Connection 얻기
			con = ds.getConnection();
		}catch (NamingException ne) {
			ne.printStackTrace();
		}
		return con;
	}// getConn
	
	
	public void closeCon(ResultSet rs, PreparedStatement pstmt, Connection con) throws SQLException {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		} finally {
			if (con != null) {
				con.close();
			}
		}
	}
	
}
