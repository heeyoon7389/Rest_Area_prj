package restAreaInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import restAreaDbConnection.DbConnection;

public class RestAreaInfoDAO {
	private static RestAreaInfoDAO raiDAO;
	
	private RestAreaInfoDAO() {
		
	}
	
	public static RestAreaInfoDAO getInstance() {
		if(raiDAO == null) {
			raiDAO = new RestAreaInfoDAO();
		}//end if
		return raiDAO;
	}//getInstance
	
	public RestAreaInfoVO selectRestAreaInfo(String raNum) throws SQLException {
		RestAreaInfoVO raVO = null;
		DbConnection dbCon = DbConnection.getInstance();
		//1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//2.
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String selectRestAreaInfo = "";
			pstmt = con.prepareStatement(selectRestAreaInfo);
			//4.
			pstmt.setString(0, selectRestAreaInfo);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				raVO = new RestAreaInfoVO();
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		return raVO;
	}
	
	public int updateFavoriteRestArea(String memberId, String raNum) throws SQLException {
		int cnt = 0;
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		
		//2.
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String updateFavorite = "";
			pstmt = con.prepareStatement(updateFavorite);
			//4.
			
			//5.
			pstmt.executeUpdate();
		} finally {
			dbCon.closeCon(null, pstmt, con);
		}
		return cnt;
	}
}
