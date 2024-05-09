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
			String searchByRaName = "";
			pstmt = con.prepareStatement(searchByRaName);
			pstmt.setString(0, searchByRaName);
			RestAreaNameVO ranVO = null;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ranVO = new RestAreaNameVO();
				raNameList.add(ranVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		return raNameList;
	}
	
	public List<LocationVO> searchByLocation(String locName) throws SQLException{
		List<LocationVO> locationList = new ArrayList<LocationVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			
			String searchByLocation = "";
			pstmt = con.prepareStatement(searchByLocation);
			pstmt.setString(0, searchByLocation);
			LocationVO locVO = null;
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				locVO = new LocationVO();
				locationList.add(locVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		
		return locationList;
	}
	
	public List<RouteVO> searchByRoute(String routeName) throws SQLException{
		List<RouteVO> routeList = new ArrayList<RouteVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = dbCon.getConn("jdbc/restarea");
			
			String searchByRoute = "";
			pstmt = con.prepareStatement(searchByRoute);
			pstmt.setString(0, searchByRoute);
			RouteVO roVO = null;
			rs = pstmt.executeQuery();
			while(rs.next()) {
				roVO = new RouteVO();
				routeList.add(roVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		
		return routeList;
	}
}
