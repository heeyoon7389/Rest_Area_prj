package prj2.mgt.login.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import restAreaDbConnection.DbConnection;
import prj2.mgt.login.vo.ManagerVO;

public class MgtLoginDAO {
	
	private static MgtLoginDAO mlDAO;
	
	private MgtLoginDAO() {
	} // MgtLoginDAO
	
	public static MgtLoginDAO getInstance() {
		if(mlDAO == null) {
			mlDAO = new MgtLoginDAO();
		} // end if
		return mlDAO;
	} // getInstance
	
	/**
	 * 관리자 로그인
	 * @param id
	 * @param pass
	 * @return
	 */
	public ManagerVO selectOneMgtLogin(String id, String pass) throws SQLException{
		ManagerVO mVO = null;
		
		// 1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");
		
			// 3. 쿼리문 생성 객체 얻기
			String selectOneMgtLogin = "select name, nick from manager where (manager_id=? and pass=?)";
			pstmt = con.prepareStatement(selectOneMgtLogin);
			
			// 4. 바인드 변수에 값 설정
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
		
			// 5. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {				// 쿼리문 실행했을 때 조회 결과가 있다면
				mVO = new ManagerVO();
				mVO.setName(rs.getString("name"));
				mVO.setNick(rs.getString("nick"));
			} // end if
		} finally {
			dbCon.closeCon(null, pstmt, con);
		} // end finally 	
		return mVO;
	} // selectOneMgtLogin

} // class
