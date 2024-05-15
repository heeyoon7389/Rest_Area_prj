package prj2.mgt.post.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.paging.vo.SearchReviewVO;
import prj2.mgt.post.vo.RestAreaReviewVO;
import prj2.mgt.post.vo.RestAreaVO;

public class MgtReviewDAO {
	private static MgtReviewDAO mrarDAO;
	private String[] columnNames;

	private MgtReviewDAO() {
		columnNames = new String[]{"content", "mem_id"};
	} // MgtReviewDAO

	public static MgtReviewDAO getInstance(){
		if(mrarDAO == null) {
			mrarDAO = new MgtReviewDAO();
		} // end if
		return mrarDAO;
	} // getInstance
	
	// <select>의 휴게소 목록
	public List<RestAreaVO> selectRestArea() throws SQLException {
		List<RestAreaVO> list = new ArrayList<RestAreaVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			String selectRestArea = "	select RA_NUM, RA_NAME from rest_area order by ra_name	";
			pstmt = con.prepareStatement(selectRestArea);
		
			// 5. 바인드 변수에 값 설정
		
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			RestAreaVO raVO = null;
			while(rs.next()) {
				raVO = new RestAreaVO();
				raVO.setRaNum(rs.getString("ra_num"));
				raVO.setRaName(rs.getString("ra_name"));
				list.add(raVO);
			} // end if
		} finally {
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally
		
		return list;
	} // selectRestArea 

	// 조건으로 검색된 리뷰 리스트 수 (검색 조건 타입, 검색어)
	public int selectMaxPage(SearchReviewVO srVO) throws SQLException {
		int totalCnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder selectTotalCount = new StringBuilder();
			selectTotalCount	// 모든 레코드의 수
			.append("	select	count(*) cnt	")
			.append("	from	(select ra_review_num, ra_num, mem_id, content from ra_review) rr,	")
			.append("			(select ra_num from rest_area) ra	")
			.append("	where	(rr.ra_num = ra.ra_num)	");
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(srVO.getKeyword() != null && !"".equals(srVO.getKeyword())) {
				selectTotalCount.append("	and rr.").append(columnNames[Integer.parseInt(srVO.getField())])
				.append(" like '%'||?||'%'	");
			} // end if
			if(srVO.getRaNum() != null && !"".equals(srVO.getRaNum())) {
				selectTotalCount.append("	and ra.ra_num = ? ");
			} // end if
			pstmt = con.prepareStatement(selectTotalCount.toString());
		
			// 5. 바인드 변수에 값 설정
			int bindIndex = 0;
			if(srVO.getKeyword() != null && !"".equals(srVO.getKeyword())) {
				pstmt.setString(++bindIndex, srVO.getKeyword());
			} // end if
			if(srVO.getRaNum() != null && !"".equals(srVO.getRaNum())) {
				pstmt.setString(++bindIndex, srVO.getRaNum());
			} // end if
		
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				totalCnt = rs.getInt("cnt");
			} // end if
		} finally {
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally

		return totalCnt;
	} // selectMaxPage

	// 휴게소 리뷰 검색 리스트 (시작, 끝, 검색 조건 타입, 검색어)
	public List<RestAreaReviewVO> selectPagingReview(SearchReviewVO srVO) throws SQLException {
		List<RestAreaReviewVO> list = new ArrayList<RestAreaReviewVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder selectPagingReview = new StringBuilder();
			selectPagingReview
			.append("	select	rnum, ra_review_num, ra_num,	")
			.append("			case	")
			.append("				when length(content) > 15 then substr(content, 0, 12) || '...'	")
			.append("				else content	")
			.append("			end content,	")
			.append("			ra_name, mem_id, blind_flag, input_date, delete_flag, delete_date	")
			.append("	from	(	")
			.append("			select	row_number () over (order by input_date desc) rnum, rr.ra_review_num, rr.ra_num, rr.content, ra.ra_name, rr.mem_id, rr.blind_flag, rr.input_date, rr.delete_flag, rr.delete_date	")
			.append("			from	(select ra_review_num, ra_num, content, mem_id, blind_flag, input_date, delete_flag, delete_date from ra_review) rr,	")
			.append("					(select ra_num, ra_name from rest_area) ra	")
			.append("			where	(rr.ra_num = ra.ra_num)	");
			if(srVO.getRaNum() != null && !"".equals(srVO.getRaNum())) {
				selectPagingReview.append("	and ra.ra_num = ?	");
			} // end if
			
			if(srVO.getKeyword() != null && !"".equals(srVO.getKeyword())) {
				selectPagingReview.append("	and instr(").append(columnNames[Integer.parseInt(srVO.getField())])
				.append(", ? ) > 0	");
			} // end if
			
			selectPagingReview.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingReview.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(srVO.getRaNum() != null && !"".equals(srVO.getRaNum())) {
				pstmt.setString(++bindIndex, srVO.getRaNum());
			} // end if
			if(srVO.getKeyword() != null && !"".equals(srVO.getKeyword())) {
				pstmt.setString(++bindIndex, srVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, srVO.getStartNum());
			pstmt.setInt(++bindIndex, srVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			RestAreaReviewVO rarVO = null;
			while(rs.next()) {
				rarVO = new RestAreaReviewVO(rs.getInt("ra_review_num"), rs.getString("ra_num"), rs.getString("ra_name"), rs.getString("content"), rs.getBoolean("blind_flag"), rs.getString("mem_id"), rs.getBoolean("delete_flag"), rs.getDate("input_date"), rs.getDate("delete_date"));
				list.add(rarVO);
			} // end while
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 

		return list;
	} // selectPagingReview

	// 휴게소 리뷰 상세 조회
	public RestAreaReviewVO selectOneReview(int reviewNum) throws SQLException {
		RestAreaReviewVO rarVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder selectOneReview = new StringBuilder();
			selectOneReview
			.append("	select	rr.ra_review_num, rr.content, ra.ra_name, rr.mem_id, rr.blind_flag, rr.input_date, rr.delete_flag 	")
			.append("	from	(select ra_review_num, ra_num, content, mem_id, blind_flag, input_date, delete_flag from ra_review) rr,	")
			.append("			(select ra_num, ra_name from rest_area) ra	")
			.append("	where	(rr.ra_num = ra.ra_num)	and ra_review_num = ?	");
			pstmt = con.prepareStatement(selectOneReview.toString());
		
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, reviewNum);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				rarVO = new RestAreaReviewVO(reviewNum, null, rs.getString("ra_name"), rs.getString("content"), rs.getInt("blind_flag") == 1 ? true : false, rs.getString("mem_id"), rs.getInt("delete_flag") == 1 ? true : false, rs.getDate("input_date"), null);
			} // end if
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return rarVO;
	} // selectOneReview

	// 휴게소 리뷰 수정 (블라인드 처리/해제)
	public int updateReview(int reviewNum, boolean blindFlag, String managerId) throws SQLException {
		int cnt = 0;

		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder updateReview = new StringBuilder();
			updateReview
			.append("	update 	ra_review	")
			.append("	set		blind_Flag=?	")
			.append("	where 	ra_review_num=? and	")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(updateReview.toString());
			
			pstmt.setString(1, blindFlag ? "1" : "0");
			pstmt.setInt(2, reviewNum);
			pstmt.setString(3, managerId);
			
			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // boolean)

	// 휴게소 리뷰 삭제
	public int deleteReview(int reviewNum, String managerId) throws SQLException{
		int cnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder deleteReview = new StringBuilder();
			deleteReview
			.append("	update	ra_review	")
			.append("	set		delete_flag='1', delete_date=sysdate	")
			.append("	where	ra_review_num=? and	")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(deleteReview.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, reviewNum);
			pstmt.setString(2, managerId);

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 

		return cnt;
	} // deleteReview
} // class
