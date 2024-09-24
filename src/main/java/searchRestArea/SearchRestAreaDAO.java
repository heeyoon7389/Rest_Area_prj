package searchRestArea;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class SearchRestAreaDAO {
	private static SearchRestAreaDAO sraDAO;
	
	private SearchRestAreaDAO() {
		
	}
	
	public static SearchRestAreaDAO getInstance() {
		if(sraDAO == null) {
			sraDAO = new SearchRestAreaDAO();
		}//end if
		return sraDAO;
	}//getInstance
	
	public List<RestAreaNameVO> searchByRaName(String raName) throws SQLException{
		List<RestAreaNameVO> raNameList = new ArrayList<RestAreaNameVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			StringBuilder searchByRaName = new StringBuilder()
					.append("select ra_num, ra_name, addr, tel, latitude, longitude ")
					.append("from rest_area ")
					.append("where ra_name like ?")
					;
			pstmt = con.prepareStatement(searchByRaName.toString());
			pstmt.setString(1, "%" + raName + "%");
			RestAreaNameVO ranVO = null;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				RestAreaNameVO ranVOBuilder = ranVO.builder()
				.raNum(rs.getString("ra_num"))		
				.raName(rs.getString("ra_name"))
				.raAddr(rs.getString("addr"))
				.raTel(rs.getString("tel"))
				.latitude(rs.getDouble("latitude"))
				.longitude(rs.getDouble("longitude"))
				.build();
				raNameList.add(ranVOBuilder);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		return raNameList;
	}
	
	public List<LocationVO> searchByLocation(String locNum) throws SQLException{
		List<LocationVO> locationList = new ArrayList<LocationVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			
			StringBuilder searchByLocation = new StringBuilder()
					.append("select ra.ra_num, lc.loc_num, ra.ra_name, ra.addr, ra.tel, ra.latitude, ra.longitude ")
					.append("from location lc, rest_area ra ")
					.append("where lc.loc_num = ra.loc_num and lc.loc_num =?");
			pstmt = con.prepareStatement(searchByLocation.toString());
			pstmt.setString(1, locNum);
			rs = pstmt.executeQuery();
			LocationVO locVO = null;
			
			while(rs.next()) {
				LocationVO locVOBuilder = locVO.builder()
						.raNum(rs.getString("ra_num"))
						.locNum(rs.getString("loc_num"))
						.raName(rs.getString("ra_name"))
						.addr(rs.getString("addr"))
						.raTel(rs.getString("tel"))
						.latitude(rs.getDouble("latitude"))
						.longitude(rs.getDouble("longitude"))
						.build();
				locationList.add(locVOBuilder);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		
		return locationList;
	}
	
	 public List<RouteVO> searchByRoute(String routeId) throws SQLException {
	        List<RouteVO> routeList = new ArrayList<>();
	        DbConnection dbCon = DbConnection.getInstance();
	        Connection con = null;
	        PreparedStatement pstmt = null;
	        ResultSet rs = null;

	        try {
	            con = dbCon.getConn("jdbc/restarea");
	            StringBuilder searchByRoute = new StringBuilder()
	                    .append("SELECT ra.ra_num, hw.route_num, ra.ra_name, ra.addr, ra.tel, ra.latitude, ra.longitude ")
	                    .append("FROM highway hw, rest_area ra ")
	                    .append("WHERE hw.route_id = ra.route_id AND hw.route_num = ?");
	            pstmt = con.prepareStatement(searchByRoute.toString());
	            pstmt.setString(1, routeId);
	            rs = pstmt.executeQuery();
	            RouteVO route = null;
	            while (rs.next()) {
	                RouteVO routeBuilder = route.builder()
	                		.raNum(rs.getString("ra_num"))
	                        .routeNum(rs.getString("route_num"))
	                        .raName(rs.getString("ra_name"))
	                        .raAddr(rs.getString("addr"))
	                        .raTel(rs.getString("tel"))
	                        .restAreaLatitude(rs.getDouble("latitude"))
	                        .restAreaLongitude(rs.getDouble("longitude"))
	                        .build();
	                routeList.add(routeBuilder);
	            }
	        } finally {
	            dbCon.closeCon(rs, pstmt, con);
	        }

	        return routeList;
	    }
}
