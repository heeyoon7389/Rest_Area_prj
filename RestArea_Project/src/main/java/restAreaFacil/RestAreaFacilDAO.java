package restAreaFacil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class RestAreaFacilDAO {
	private static RestAreaFacilDAO rafDAO;
	
	private RestAreaFacilDAO() {
		
	}
	
	public static RestAreaFacilDAO getInstance() {
		if(rafDAO == null) {
			rafDAO = new RestAreaFacilDAO();
		}//end if
		return rafDAO;
	}//getInstance
	
	public List<RestAreaFacilVO> selectFacil(String raNum) throws SQLException{
		List<RestAreaFacilVO> facilList = new ArrayList<RestAreaFacilVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//2.
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			//3.
			String selectFacil = "";
			pstmt = con.prepareStatement(selectFacil);
			//4.
			pstmt.setString(0, selectFacil);
			RestAreaFacilVO rafVO = null;
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rafVO = new RestAreaFacilVO();
				facilList.add(rafVO);
			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return facilList;
	}
}
