package restAreaReview;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class RestAreaReviewDAO {
	private static RestAreaReviewDAO rarDAO;
	
	private RestAreaReviewDAO() {
		
	}
	
	public static RestAreaReviewDAO getInstance() {
		if(rarDAO == null) {
			rarDAO = new RestAreaReviewDAO();
		}//end if
		return rarDAO;
	}//getInstance
	
	public List<RestAreaReviewVO> selectAllReview(String raNum) throws SQLException{
		List<RestAreaReviewVO> reviewList = new ArrayList<RestAreaReviewVO>();
		//1.드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		//2
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			//3.
			String selectAllReview = "";
			pstmt = con.prepareStatement(selectAllReview);
			//4.
			pstmt.setString(0, selectAllReview);
			RestAreaReviewVO rarVO = null;
			
			rs = pstmt.executeQuery();
			while(rs.next()) {
				rarVO = new RestAreaReviewVO();
				reviewList.add(rarVO);
			}
		} finally {
			dbCon.dbClose(rs, pstmt, con);
		}
		return reviewList;
	}
	
	public int insertReview(RestAreaReviewVO rarVO, String memberId) throws SQLException {
		int cnt = 0;
		//1.드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			//3.
			String insertReview = "";
			pstmt = con.prepareStatement(insertReview);
			
			//4.
			pstmt.setString(cnt, insertReview);
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(pstmt, con);
		}
		return cnt;
	}
	
	public int deleteReview(RestAreaReviewVO rarVO) throws SQLException {
		int cnt = 0;
		//1.드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			String deleteReview = "";
			pstmt = con.prepareStatement(deleteReview);
			
			pstmt.setString(cnt, deleteReview);
			
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(pstmt, con);
		}
		
		
		return cnt;
	}
	
	public int updateRepReview(RestAreaReviewVO rarVO, String memberId) throws SQLException {
		int cnt = 0;
		//1.드라이버 로딩
		DbConnection dbCon = DbConnection.getInstance();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			String id = "RestArea";
			String pass = "4";
			con = dbCon.getConnection(id, pass);
			//3.
			String updateRepReview = "";
			pstmt = con.prepareStatement(updateRepReview);
			
			pstmt.setString(cnt, updateRepReview);
			
			pstmt.executeUpdate();
		} finally {
			dbCon.dbClose(pstmt, con);;
		}
		
		
		return cnt;
	}
}
