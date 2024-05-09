package restAreaStore;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class RestAreaStoreDAO {
	private static RestAreaStoreDAO rasDAO;
	
	private RestAreaStoreDAO() {
		
	}
	
	public static RestAreaStoreDAO getInstance() {
		if(rasDAO == null) {
			rasDAO = new RestAreaStoreDAO();
		}//end if
		return rasDAO;
	}//getInstance
	
	public List<RestAreaStoreVO> selectStore(String raNum) throws SQLException{
		List<RestAreaStoreVO> storeList = new ArrayList<RestAreaStoreVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			//2.
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String selectStore = "";
			pstmt = con.prepareStatement(selectStore);
			//4.
			pstmt.setString(0, selectStore);
			RestAreaStoreVO raVO = null;
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				raVO = new RestAreaStoreVO();
				storeList.add(raVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		} 
		return storeList;
	}
	
	public RestAreaStoreVO selectRecommandMenu(String storeNum) throws SQLException {
		RestAreaStoreVO rasVO = null;
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//2.
		try {
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String selectRecommandMenu = "";
			pstmt = con.prepareStatement(selectRecommandMenu);
			//4.
			pstmt.setString(0, selectRecommandMenu);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rasVO = new RestAreaStoreVO();
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		return rasVO;
	}
	
	public List<RestAreaStoreVO> selectAllMenu(String storeNum) throws SQLException{
		List<RestAreaStoreVO> menuList = new ArrayList<RestAreaStoreVO>();
		//1. 드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//2
		try {
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String selectAllMenu = "";
			pstmt = con.prepareStatement(selectAllMenu);
			//4.
			pstmt.setString(0, selectAllMenu);
			RestAreaStoreVO rasVO = null;
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rasVO = new RestAreaStoreVO();
				menuList.add(rasVO);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		return menuList;
	}
}
