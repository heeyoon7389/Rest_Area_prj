package highway;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class HighwayDAO {
	private static HighwayDAO hwDAO;
	
	private HighwayDAO() {
		
	}
	
	public static HighwayDAO getInstance() {
		if(hwDAO == null) {
			hwDAO = new HighwayDAO();
		}
		return hwDAO;
	}//getInstance
	
	public List<HighwayVO> selectAllHighway() {
		List<HighwayVO> highwayList = new ArrayList<HighwayVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			//3.
			StringBuilder selectHighway = new StringBuilder();
			selectHighway
			.append("select route_name, route_num ")
			.append("from highway");
			
			pstmt = con.prepareStatement(selectHighway.toString());
			
			rs = pstmt.executeQuery();
			HighwayVO hwVO = null;
			while(rs.next()) {
				HighwayVO hwVOBuilder = hwVO.builder()
						.highwayName(rs.getString("route_name"))
						.routeId(rs.getString("route_num"))
						.build();
				highwayList.add(hwVOBuilder);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return highwayList;
	}
}
