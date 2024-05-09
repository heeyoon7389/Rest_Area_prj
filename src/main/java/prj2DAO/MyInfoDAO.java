package prj2DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import prj2VO.MemJoinVO;

public class MyInfoDAO {
	
	private static MyInfoDAO miDAO;
	
	private MyInfoDAO() {
		
	}
	
	public static MyInfoDAO getInstance() {
		if(miDAO == null) {
			miDAO = new MyInfoDAO();
		}//end if
		return miDAO;
	}//getInstance
	
	public void updateMyInfo(MemJoinVO mjVO) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		
		// 1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			// 2. 커넥션 얻기
			con = dbCon.getConn("jdbc/restarea");
			
			// 3. 쿼리문 생성객체 얻기
			String updateMyInfo = 
					" update member set pass=?, name=?, nick=?, email=? where mem_id = ? ";
			
			pstmt = con.prepareStatement(updateMyInfo);
			
			// 4. 바인드 변수에 값넣기
			pstmt.setString(1, mjVO.getPassword());
			pstmt.setString(2, mjVO.getName());
			pstmt.setString(3, mjVO.getNick());
			pstmt.setString(4, mjVO.getEmail());
			pstmt.setString(5, mjVO.getId());
			
			// 5. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally {
			dbCon.closeCon(null, pstmt, con);
		} // end finally
	}// updateTempPass
}
