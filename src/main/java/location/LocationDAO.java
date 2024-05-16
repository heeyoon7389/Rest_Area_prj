package location;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import highway.HighwayVO;
import restAreaDbConnection.DbConnection;

public class LocationDAO {
	private static LocationDAO lcDAO;
	
	private LocationDAO() {
		
	}
	
	public static LocationDAO getInstance() {
		if(lcDAO == null) {
			lcDAO = new LocationDAO();
		}
		return lcDAO;
	}//getInstance
	
	public List<LocationVO> selectAllLocation() throws SQLException {
		List<LocationVO> locationList = new ArrayList<LocationVO>();
		
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			StringBuilder selectLocation = new StringBuilder()
					.append("select loc_name, loc_num ")
					.append("from location ");
			pstmt = con.prepareStatement(selectLocation.toString());
			
			rs = pstmt.executeQuery();
			LocationVO lVO = null;
			while(rs.next()) {
				LocationVO lVOBuilder = lVO.builder()
						.locationName(rs.getString("loc_name"))
						.locNum(rs.getString("loc_num"))
						.build();
				locationList.add(lVOBuilder);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		return locationList;
	}
}
