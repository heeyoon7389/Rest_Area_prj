package MenuManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import Store_management.StoreManagementVO;
import restAreaDbConnection.DbConnection;

public class MenuDAO {
	
	private static MenuDAO mnDAO;
	
	private MenuDAO() {
	}
	
	public static MenuDAO getInstance() {
		if(mnDAO == null) {
			mnDAO = new MenuDAO();
		}//end if
		return mnDAO;
	}//getInstance
	
	public List<MenuVO> selectAllMenu(String areaCode, String storeCode) throws SQLException{
		List<MenuVO> list = new ArrayList<MenuVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectAllMenu = new StringBuilder();
			selectAllMenu
			.append(" select m.menu_num, m.menu_name, s.store_name, m.price, m.note ")
			.append(" from menu m, store s ")
			.append(" where s.ra_num=? and m.store_num=? and m.store_num = s.store_num ");
			
			pstmt = con.prepareStatement(selectAllMenu.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			pstmt.setString(2, storeCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			MenuVO mnVO = new MenuVO();
			while(rs.next()) {
				mnVO = new MenuVO(
						rs.getString("menu_num"),
						rs.getString("menu_name"),
						rs.getString("store_name"),
						rs.getString("price"),
						rs.getString("note")
						);
				list.add(mnVO);
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return list;
	}//selectAllMenu
	
	public String selectStoreName(String areaCode, String storeCode) throws SQLException {
		String storeName = "";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectStoreName = new StringBuilder();
			selectStoreName
			.append(" select store_name ")
			.append(" from store ")
			.append(" where ra_num=? and store_num=? ");
			
			pstmt = con.prepareStatement(selectStoreName.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			pstmt.setString(2, storeCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				storeName = rs.getString("store_name");
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return storeName;
	}//selectStoreName
	
	public String selectAreaName(String areaCode) throws SQLException {
		String areaName = "";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectAreaName = new StringBuilder();
			selectAreaName
			.append(" select ra_name ")
			.append(" from rest_area ")
			.append(" where ra_num = ? ");
			
			pstmt = con.prepareStatement(selectAreaName.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				areaName = rs.getString("ra_name");
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return areaName;
	}//selectAreaName
	
}
