package prj2DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import prj2VO.LoginVO;

public class LoginDAO {

	private static LoginDAO lgDAO;
	
	private LoginDAO() {
		
	}//LoginDAO
	
	public static LoginDAO getInstance() {
		if (lgDAO == null) {
			lgDAO = new LoginDAO();
		} // end if
		return lgDAO;
	}// getInstance
	
	public LoginVO selectMembership(String userId, String userPass) throws SQLException {
		LoginVO lgVO = null;

		DbConnection dbCon = DbConnection.getInstance();

		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");

			// 3. 쿼리문 생성객체 얻기
			String searchMem = 
					" select MEM_ID, PASS, NAME, NICK, EMAIL from member "
					+ " where mem_id=? and pass=? "
					+ " AND (SUSPEND_FLAG IS NULL OR SUSPEND_FLAG != '1') "
					+ " AND (WITHDRAW_FLAG IS NULL OR WITHDRAW_FLAG != '1') ";

			pstmt = con.prepareStatement(searchMem);

			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, userId);
			pstmt.setString(2, userPass);

			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			while (rs.next()) {
				lgVO = new LoginVO(rs.getString("MEM_ID"), rs.getString("PASS"), rs.getString("NAME"),
		                rs.getString("NICK"), rs.getString("EMAIL"));
			} // end while
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} // end finally
		return lgVO;
	}// selectMembership
}
