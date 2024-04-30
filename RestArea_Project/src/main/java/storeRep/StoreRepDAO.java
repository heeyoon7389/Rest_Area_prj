package storeRep;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class StoreRepDAO {
	private static StoreRepDAO srDAO;
	
	private StoreRepDAO() {
		
	}
	
	public static StoreRepDAO getInstance() {
		if(srDAO == null) {
			srDAO = new StoreRepDAO();
		}
		return srDAO;
	}//getInstance
	
	public void insertStoreRep(StoreRepVO srVO) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		
		//1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			//3.
			String insertStoreRep = "";
			pstmt = con.prepareStatement(insertStoreRep);
			pstmt.setString(0, insertStoreRep);
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(pstmt, con);
		}
	}
}
