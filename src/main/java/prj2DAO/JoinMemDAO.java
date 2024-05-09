package prj2DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import prj2VO.MemJoinVO;

public class JoinMemDAO {

	private static JoinMemDAO jmDAO;
	private boolean check;
	
	private JoinMemDAO() {
		
	}
	
	public static JoinMemDAO getInstance() {
		if(jmDAO == null) {
			jmDAO = new JoinMemDAO();
		}//end if
		return jmDAO;
	}//getInstance
	
	/**
	 * 회원 추가
	 * @param lgVO
	 * @throws SQLException
	 */
	public void insertMemberShip(MemJoinVO mjVO) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();

		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");
			
			// 3. 쿼리문 생성객체 얻기
			String insertMember = 
					" INSERT INTO MEMBER (MEM_ID, PASS, NAME, NICK, EMAIL) values(?,?,?,?,?) ";
			pstmt = con.prepareStatement(insertMember);
			
			// 4. 바인드변수에 값 설정
			pstmt.setString(1, mjVO.getId());
			pstmt.setString(2, mjVO.getPassword());
			pstmt.setString(3, mjVO.getName());
			pstmt.setString(4, mjVO.getNick());
			pstmt.setString(5, mjVO.getEmail());
			
			// 5. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
		} finally {
			// 6. 연결 끊기
			dbCon.closeCon(null, pstmt, con);
		} // end finally
	}//insertMemberShip
	
	
	/**
	 * 아이디 중복 확인
	 * @param userId
	 * @return
	 * @throws SQLException
	 */
	public boolean selectDupId(String userId) throws SQLException {
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
					" select mem_id from member where mem_id=? ";

			pstmt = con.prepareStatement(DupId);

			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, userId);

			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			check = rs.next();	
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} // end finally
		return check;
	}// selectDupId
	
	/**
	 * 닉네임 중복 확인
	 * @param userNick
	 * @return
	 * @throws SQLException
	 */
	public boolean selectDupNick(String userNick) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();

		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");

			// 3. 쿼리문 생성객체 얻기
			String DupNick = 
					" select nick from member where nick=? ";

			pstmt = con.prepareStatement(DupNick);

			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, userNick);

			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			check = rs.next();	
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} // end finally
		return check;
	}// selectDupId
}
