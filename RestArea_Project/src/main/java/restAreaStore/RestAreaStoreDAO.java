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
			StringBuilder selectStore = new StringBuilder();
			selectStore
			.append("select store_image, store_name, note, store_num ")
			.append("from store ")
			.append("where ra_num = ?");
			pstmt = con.prepareStatement(selectStore.toString());
			//4.
			pstmt.setString(1, raNum);
			rs = pstmt.executeQuery();
			RestAreaStoreVO raVO = null;
			
			while(rs.next()) {
				RestAreaStoreVO raVOBuilder = raVO.builder()
						.storeImg(rs.getString("store_image"))
						.storeName(rs.getString("store_name"))
						.storeNote(rs.getString("note"))
						.storeNum(rs.getString("store_num"))
						.build();
				storeList.add(raVOBuilder);
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
			StringBuilder selectAllMenu = new StringBuilder()
					.append("select img, menu_name, price, note, store_num ")
					.append("from menu ")
					.append("where store_num = ?");
			pstmt = con.prepareStatement(selectAllMenu.toString());
			//4.
			pstmt.setString(1, storeNum);
			RestAreaStoreVO rasVO = null;
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
						RestAreaStoreVO rasVOBuilder = rasVO.builder()
						.menuImg(rs.getString("img"))
						.menuName(rs.getString("menu_name"))
						.price(rs.getInt("price"))
						.menuNote(rs.getString("note"))
						.storeNum(rs.getString("store_Num"))
						.build();
				menuList.add(rasVOBuilder);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
		}
		return menuList;
	}
}
