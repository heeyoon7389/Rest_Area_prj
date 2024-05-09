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
			con = dbCon.getConn("jdbc/restarea");
			//3.
			StringBuilder selectFacil = new StringBuilder();
			selectFacil
			.append("select hrf.ra_num, rf.ra_facil_num, rf.img, rf.ra_facil_name, rf.note ")
			.append("from held_ra_facility hrf, restarea_facility rf ")
			.append("where hrf.ra_facil_num = rf.ra_facil_num and hrf.ra_num = ?");
			
			pstmt = con.prepareStatement(selectFacil.toString());
			//4.
			pstmt.setString(1, raNum);
			rs = pstmt.executeQuery();
			RestAreaFacilVO rafVO = null;			
			while(rs.next()) {
				rafVO = new RestAreaFacilVO(
						rs.getString("ra_facil_num"),
						rs.getString("ra_num"), 
						rs.getString("ra_facil_name"),
						rs.getString("note"),
						rs.getString("img")
						);
				facilList.add(rafVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		return facilList;
	}
}
