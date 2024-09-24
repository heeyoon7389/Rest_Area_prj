package prj2.mgt.post.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.paging.vo.SearchVO;
import prj2.mgt.post.vo.RestAreaReviewRepVO;

public class MgtReviewReportDAO {
	private static MgtReviewReportDAO mrrptDAO;
	private String[] columnNames;

	private MgtReviewReportDAO(){
		columnNames = new String[]{"mem_id_review", "content_review", "mem_id_report", "content_report"};
	} // MgtReviewReportDAO

	public static MgtReviewReportDAO getInstance(){
		if(mrrptDAO == null) {
			mrrptDAO = new MgtReviewReportDAO();
		} // end if
		return mrrptDAO;
	} // getInstance

	// 검색된 리뷰 신고 리스트 수
	public int selectMaxPage(SearchVO sVO) throws SQLException{
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
			StringBuilder selectMaxPage = new StringBuilder();
			selectMaxPage	// 모든 레코드의 수
			.append("	select	count(*) cnt	")
			.append("	from	")
			.append("			(select ra_review_num, mem_id mem_id_review, content content_review from ra_review) rev,	")
			.append("			(select ra_review_num, content content_report, mem_id mem_id_report, process_flag from review_report) rpt	")
			.append("	where	(rpt.ra_review_num = rev.ra_review_num)	");
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				int field = Integer.parseInt(sVO.getField());
				switch(field) {
				case 0:
				case 1:
					selectMaxPage.append("	and rev.");
					break;
				case 2:
				case 3:
					selectMaxPage.append("	and rpt.");
					break;
				} // end switch
				selectMaxPage.append(columnNames[field])
				.append(" like '%'||?||'%'	");
			} // end if
			pstmt = con.prepareStatement(selectMaxPage.toString());
		
			// 5. 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
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

	// 리뷰 신고 리스트 검색 (시작, 끝, 검색 조건 타입, 검색어)
	public List<RestAreaReviewRepVO> selectPagingRevRep(SearchVO sVO) throws SQLException {
		List<RestAreaReviewRepVO> list = new ArrayList<RestAreaReviewRepVO>();
		
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
			StringBuilder selectPagingRevRep = new StringBuilder();
			selectPagingRevRep
			.append("	select	rnum, ra_review_num,	")
			.append("			case	")
			.append("				when length(content_report) > 15 then substr(content_report, 0, 12) || '...'	")
			.append("				else content_report	")
			.append("			end content_report,	")
			.append("			mem_id_review, mem_id_report, input_date, blind_flag, process_flag, process_date, delete_flag	")
			.append("	from	(	")
			.append("			select	row_number() over (order by rpt.input_date desc) rnum, rpt.ra_review_num, rpt.content_report, rev.mem_id_review, rpt.mem_id_report, rpt.input_date, rpt.process_flag, rpt.process_date, rev.blind_flag, rev.delete_flag	")
			.append("			from	(select ra_review_num, mem_id mem_id_review, content content_review, blind_flag, delete_flag from ra_review) rev,	")
			.append("					(select ra_review_num, content content_report, mem_id mem_id_report, input_date, process_flag, process_date from review_report) rpt	")
			.append("			where	(rpt.ra_review_num = rev.ra_review_num)	");
			
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				int field = Integer.parseInt(sVO.getField());
				switch(field) {
				case 0:
				case 1:
					selectPagingRevRep.append("	and instr(rev.");
					break;
				case 2:
				case 3:
					selectPagingRevRep.append("	and instr(rpt.");
					break;
				} // end switch
				selectPagingRevRep.append(columnNames[field])
				.append(", ? ) > 0	");
			} // end if

			selectPagingRevRep.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingRevRep.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			RestAreaReviewRepVO rarrVO = null;
			while(rs.next()) {
				rarrVO = new RestAreaReviewRepVO(rs.getInt("ra_review_num"), rs.getString("mem_id_review"), null, null, rs.getString("mem_id_report"), rs.getString("content_report"), rs.getDate("input_date"), rs.getBoolean("blind_flag"), rs.getInt("process_flag"), null, rs.getDate("process_date"), rs.getBoolean("delete_flag"));
				list.add(rarrVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally
						
		return list;
	} // selectPagingRevRep

	// 리뷰 신고 상세 조회
	public RestAreaReviewRepVO selectOneRevRep(int reviewNum, String reportMemId) throws SQLException{
		RestAreaReviewRepVO rarrVO = null;
		
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
			StringBuilder selectOneRevRep = new StringBuilder();
			selectOneRevRep
			.append("	select	rev.mem_id review_mem_id, rev.ra_review_num, rev.input_date review_input_date, rev.content review_content, rpt.mem_id report_mem_id, rpt.input_date report_input_date, rpt.content report_content, rev.BLIND_FLAG, rpt.PROCESS_FLAG, rpt.PROCESS_CONTENTS, rpt.process_date, rev.delete_flag	")
			.append("	from	(select ra_review_num, mem_id, content, input_date, blind_flag, delete_flag from ra_review) rev,	")
			.append("			(select ra_review_num, content, mem_id, input_date, process_flag, PROCESS_CONTENTS, process_date from review_report) rpt	")
			.append("	where	(rpt.ra_review_num = rev.ra_review_num) and	")
			.append("			(rev.ra_review_num = ?) and rpt.mem_id = ?	");

			pstmt = con.prepareStatement(selectOneRevRep.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, reviewNum);
			pstmt.setString(2, reportMemId);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				rarrVO = new RestAreaReviewRepVO(reviewNum, rs.getString("review_mem_id"), rs.getString("review_content"), rs.getDate("review_input_date"), reportMemId, rs.getString("report_content"), rs.getDate("report_input_date"), rs.getBoolean("BLIND_FLAG"), rs.getInt("PROCESS_FLAG"), rs.getString("PROCESS_CONTENTS"), rs.getDate("process_date"), rs.getBoolean("delete_flag"));
			} // end if 
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		return rarrVO;
	} // selectOneRevRep

	// 받은 신고 처리 (처리 답변 / 처리상태 변경 / 블라인드 변경)
	public int updateRevRep(RestAreaReviewRepVO rarrVO, String managerId) throws SQLException {
		int cnt = 0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			StringBuilder updateRevRep = new StringBuilder();
			updateRevRep
			.append("	update	(	")
			.append("			select	rev.ra_review_num, rev.BLIND_FLAG, rpt.PROCESS_FLAG, process_contents, process_date	")
			.append("			from	(select ra_review_num, blind_flag from ra_review) rev,	")
			.append("					(select ra_review_num, PROCESS_FLAG, PROCESS_CONTENTS, PROCESS_DATE from review_report) rpt	")
			.append("			where	rpt.ra_review_num = rev.ra_review_num	")
			.append("			)	")
			.append("	set		PROCESS_FLAG=?, PROCESS_CONTENTS=?, PROCESS_DATE=sysdate	")
			.append("	where	ra_review_num=? and	")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(updateRevRep.toString());
			
			pstmt.setInt(1, rarrVO.getProcessFlag());
			pstmt.setString(2, rarrVO.getProcessContents());
			pstmt.setInt(3, rarrVO.getReviewNum());
			pstmt.setString(4, managerId);
			
			String updateRevRep2 = " update ra_review set blind_flag = ? where ra_review_num=? ";
			pstmt2 = con.prepareStatement(updateRevRep2);
			pstmt2.setBoolean(1, rarrVO.isBlindFlag());
			pstmt2.setInt(2, rarrVO.getReviewNum());
			
			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			cnt += pstmt2.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
			db.closeCon(null, pstmt2, null);
		} // end finally 

		return cnt;
	} // updateRevRep
} // class
