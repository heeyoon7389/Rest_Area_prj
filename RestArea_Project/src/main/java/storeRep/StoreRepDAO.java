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
	
	public void insertStoreRep(String memId, String storeNum, String content) throws SQLException {
		DbConnection dbCon = DbConnection.getInstance();
		
		//1. 드라이버 로딩
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = dbCon.getConn("jdbc/restarea");
			//3.
			StringBuilder insertStoreRep = new StringBuilder()
					.append("insert into store_report (num_rep_store, mem_id, store_num, content, input_date) ")
					.append("values(seq_store_report.nextval, ?,?,?, sysdate)");
			
			pstmt = con.prepareStatement(insertStoreRep.toString());
			pstmt.setString(1, memId);
			pstmt.setString(2, storeNum);
			pstmt.setString(3, content);
			pstmt.executeUpdate();
		} finally {
			dbCon.closeCon(null, pstmt, con);
		}
	}
}
