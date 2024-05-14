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
			StringBuilder selectRestAreaInfo = new StringBuilder()
					.append("select ra_name, addr ")
					.append("from Rest_area ")
					.append("where ra_num =?");
			pstmt = con.prepareStatement(selectRestAreaInfo.toString());
			//4.
			pstmt.setString(1, raNum);
			
			rs = pstmt.executeQuery();
			RestAreaInfoVO raiVO = null;
			if(rs.next()) {
				RestAreaInfoVO raiVOBuilder = raiVO.builder()
						.raName(rs.getString("ra_name"))
						.raAddr(rs.getString("addr"))
						.build();
				raVO = raiVOBuilder;
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
