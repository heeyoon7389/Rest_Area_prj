package Store_management;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import AreaManagement.SelectRestAreaVO;
import restAreaDbConnection.DbConnection;

public class StoreManagementDAO {
	private static StoreManagementDAO smmDAO;
	
	private StoreManagementDAO() {
	}//StoreManagementDAO
	
	public static StoreManagementDAO getInstance() {
		if(smmDAO == null) {
			smmDAO = new StoreManagementDAO();
		}//end if
		return smmDAO;
	}//getInstance
	
	public List<StoreManagementVO> selectAllStore(String areaCode) throws SQLException {
		List<StoreManagementVO> list = new ArrayList<StoreManagementVO>();
		
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
			StringBuilder selectAllStore = new StringBuilder();
			selectAllStore
			.append(" select store_num, store_kind, store_name, note ")
			.append(" from store ")
			.append(" where ra_num = ? ");
			
			pstmt = con.prepareStatement(selectAllStore.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			StoreManagementVO smmVO = new StoreManagementVO();
			while(rs.next()) {
				smmVO = new StoreManagementVO(
						rs.getString("store_name"),
						rs.getString("store_kind"),
						rs.getString("store_num"),
						rs.getString("note")
						);
				list.add(smmVO);
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return list;
	}//selectAllStore
	
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
	
	public boolean selectStoreName(String storeName, String areaCode) throws SQLException {
		boolean flag = false;
		
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
			.append(" select store_name ")
			.append(" from store ")
			.append(" where store_name=? and ra_num=? ");
			
			pstmt = con.prepareStatement(selectAreaName.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, storeName);
			pstmt.setString(2, areaCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				flag = true;
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return flag;
	}
	
}//class
