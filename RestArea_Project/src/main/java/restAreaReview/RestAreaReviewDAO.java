package restAreaReview;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import lombok.Builder;
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
			con = dbCon.getConn("jdbc/restarea");
			//3.
			StringBuilder selectAllReview = new StringBuilder()
					.append("select sr.ra_num, rr.mem_id, sr.star, rr.content, rr.input_date, rr.blind_flag ")
					.append("from star_rate sr, ra_review rr ")
					.append("where sr.ra_num = rr.ra_num and rr.mem_id = sr.mem_id and sr.ra_num = ? ")
					.append("order by rr.input_date desc");
			pstmt = con.prepareStatement(selectAllReview.toString());
			//4.
			pstmt.setString(1, raNum);
			rs = pstmt.executeQuery();
			
			RestAreaReviewVO rarVO = null;			
			while(rs.next()) {
				RestAreaReviewVO rarVOBuilder = rarVO.builder()
						.raNum(rs.getString("ra_num"))
						.memberId(rs.getString("mem_id"))
						.star(rs.getDouble("star"))
						.note(rs.getString("content"))
						.inputDate(rs.getDate("input_date"))
						.blindFlag(rs.getString("blind_flag"))
						.build();
				reviewList.add(rarVOBuilder);
			}
		} finally {
			dbCon.closeCon(rs, pstmt, con);
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
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String insertReview = "";
			pstmt = con.prepareStatement(insertReview);
			
			//4.
			pstmt.setString(cnt, insertReview);
			pstmt.executeUpdate();
		} finally {
			dbCon.closeCon(null, pstmt, con);
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
			con = dbCon.getConn("jdbc/restarea");
			String deleteReview = "";
			pstmt = con.prepareStatement(deleteReview);
			
			pstmt.setString(cnt, deleteReview);
			
			pstmt.executeUpdate();
		} finally {
			dbCon.closeCon(null, pstmt, con);
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
			con = dbCon.getConn("jdbc/restarea");
			//3.
			String updateRepReview = "";
			pstmt = con.prepareStatement(updateRepReview);
			
			pstmt.setString(cnt, updateRepReview);
			
			pstmt.executeUpdate();
		} finally {
			dbCon.closeCon(null, pstmt, con);
		}
		return cnt;
	}
}
