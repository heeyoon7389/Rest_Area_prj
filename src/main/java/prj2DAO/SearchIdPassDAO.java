package prj2DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class SearchIdPassDAO {

	private static SearchIdPassDAO sipDAO;
	private boolean check;
	
	private SearchIdPassDAO() {
		
	}
	
	public static SearchIdPassDAO getInstance() {
		if(sipDAO == null) {
			sipDAO = new SearchIdPassDAO();
		}//end if
		return sipDAO;
	}//getInstance
	
	/**
	 * 아이디 찾기
	 * @param name
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public String selectId(String name, String email) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		String id = null;

		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");

			// 3. 쿼리문 생성객체 얻기
			String DupId = 
					" select MEM_ID from member where name=? and email=? ";

			pstmt = con.prepareStatement(DupId);

			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, name);
			pstmt.setString(2, email);

			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if (rs.next()) {
	            // 결과가 존재하면 아이디를 가져옴
	            id = rs.getString("MEM_ID");
	        }
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} // end finally
		return id;
	}// selectId
	
	public boolean selectUserPass(String id, String name, String email) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();

		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");

			// 3. 쿼리문 생성객체 얻기
			String DupId = 
					" select pass from member where mem_id=? and name=? and email=? ";

			pstmt = con.prepareStatement(DupId);

			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setString(3, email);

			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			check = rs.next();	
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} // end finally
		return check;
	}// selectDupId
	
	/**
	 * 임시비밀번호로 update하기
	 * @param name
	 * @param email
	 * @return
	 * @throws SQLException
	 */
	public void updateTempPass(String tempPass, String id, String name, String email) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		
		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");
			
			// 3. 쿼리문 생성객체 얻기
			String updateTempPass = 
					" update member set pass = ? where mem_id=? and name=? and email=? ";
			
			pstmt = con.prepareStatement(updateTempPass);
			
			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, tempPass);
			pstmt.setString(2, id);
			pstmt.setString(3, name);
			pstmt.setString(4, email);
			
			// 5. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally {
			dbCon.closeCon(null, pstmt, con);
		} // end finally
	}// updateTempPass
}