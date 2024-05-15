package prj2.mgt.dashboard.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.dashboard.vo.DashInquiryVO;
import prj2.mgt.dashboard.vo.DashReviewReportVO;
import prj2.mgt.dashboard.vo.MemberVariGraphVO;
import prj2.mgt.dashboard.vo.MemberVariTableVO;
import prj2.mgt.dashboard.vo.RaReviewRankVO;
import prj2.mgt.dashboard.vo.RaViewRankVO;
import prj2.mgt.dashboard.vo.VisitorVO;

public class MgtDashBoardDAO {
	private static MgtDashBoardDAO mdbDAO;
	
	private MgtDashBoardDAO(){
	} // MgtDashBoardDAO
	
	public static MgtDashBoardDAO getInstance(){
		if(mdbDAO == null) {
			mdbDAO = new MgtDashBoardDAO();
		} // end if
		return mdbDAO;
	} // getInstance
	
	// 사이트 방문자수
	public List<VisitorVO> selectVisitors(String startDate, String endDate, String selInterval) throws SQLException {
		List<VisitorVO> list = new ArrayList<VisitorVO>();
		
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
			StringBuilder selectVisitors = new StringBuilder();
			if(!("dd".equals(selInterval) || "ww".equals(selInterval) || "mm".equals(selInterval))){
				selInterval = "dd";
			} // end if
			selectVisitors
			.append("	select	case	")
			.append("				when colDate < to_date(?, 'yyyy-mm-dd') then to_char(to_date(?, 'yyyy-mm-dd'), 'yyyy-fmmm-dd')	")
			.append("				else to_char(colDate, 'yyyy-fmmm-dd')	")
			.append("			end col,	")
			.append("			nvl(member, 0) member, nvl(visitor, 0) visitor	")
			.append("	from	(select	TRUNC(days, '").append(selInterval).append("') colDate, sum(mem_cnt) member, sum(non_mem_cnt) visitor	")
			.append("			from	(	")
			.append("					select	lev.days, vi.mem_cnt, vi.non_mem_cnt	")
			.append("					from	(select (to_date(?, 'yyyy-mm-dd') + level - 1) days	")
			.append("							from dual connect by level < (select to_date(?, 'yyyy-mm-dd') - to_date(?, 'yyyy-mm-dd') + 2 from dual)) lev,	")
			.append("							(select INPUT_DATE, MEM_CNT, NON_MEM_CNT from visitor) vi	")
			.append("					where	vi.input_date(+) = lev.days	")
			.append("					)	")
			.append("			group by TRUNC(days, '").append(selInterval).append("')	")
			.append("			)	")
			.append("	order by	colDate	");
			
			pstmt = con.prepareStatement(selectVisitors.toString());

			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, startDate);
			pstmt.setString(2, startDate);
			pstmt.setString(3, startDate);
			pstmt.setString(4, endDate);
			pstmt.setString(5, startDate);

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			VisitorVO vVO = null;
			while(rs.next()) {
				vVO = new VisitorVO(rs.getInt("visitor"), rs.getInt("member"), rs.getString("col"));
				list.add(vVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 		
		
		return list;
	} // selectVisitors

	// 회원 수 변동
	public List<MemberVariGraphVO> selectMemberVariance(String startDate, String endDate, String selInterval) throws SQLException {
		List<MemberVariGraphVO> list = new ArrayList<MemberVariGraphVO>();
		
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
			StringBuilder selectMemberVariance = new StringBuilder();
			if(!("dd".equals(selInterval) || "ww".equals(selInterval) || "mm".equals(selInterval))){
				selInterval = "dd";
			} // end if
			selectMemberVariance
			.append("	with lev as (	")
			.append("		select (to_date(?, 'yyyy-mm-dd') + level - 1) days	")
			.append("		from dual	")
			.append("		connect by level < (select to_date(?, 'yyyy-mm-dd') - to_date(?, 'yyyy-mm-dd') + 2 from dual)	")
			.append("	)	")
			.append("	select	case	")
			.append("				when col < to_date(?, 'yyyy-mm-dd') then to_char(to_date(?, 'yyyy-mm-dd'), 'yyyy-fmmm-dd')	")
			.append("				else to_char(col, 'yyyy-fmmm-dd')	")
			.append("			end col, memberNew, memberQuit	")
			.append("	from	(	")
			.append("			select	trunc(days, '").append(selInterval).append("') col, sum(memberNew) memberNew, sum(memberQuit) memberQuit	")
			.append("			from	(	")
			.append("					select 	lev.days, nvl(mem.m_cnt, 0) memberNew, nvl(wmem.wm_cnt, 0) memberQuit	")
			.append("					from	lev,	")
			.append("							(select trunc(join_date) join_date, count(join_date) m_cnt from member group by trunc(join_date)) mem,	")
			.append("					 		(select trunc(join_date) join_date, count(join_date) wm_cnt from member where withdraw_flag='1' group by trunc(join_date)) wmem	")
			.append("					where	mem.join_date(+) = lev.days and wmem.join_date(+) = lev.days	")
			.append("					)	")
			.append("			group by trunc(days, '").append(selInterval).append("')	")
			.append("			order by trunc(days, '").append(selInterval).append("')	")
			.append("			)	");
			
			pstmt = con.prepareStatement(selectMemberVariance.toString());

			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, startDate);
			pstmt.setString(2, endDate);
			pstmt.setString(3, startDate);
			pstmt.setString(4, startDate);
			pstmt.setString(5, startDate);

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			MemberVariGraphVO mvgVO = null;
			while(rs.next()) {
				mvgVO = new MemberVariGraphVO(rs.getInt("memberNew"), rs.getInt("memberQuit"), rs.getString("col"));
				list.add(mvgVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return list;
	} // selectMemberVariance
	
	// 회원수 현황
	public MemberVariTableVO selectMemberCurrentSituation() throws SQLException{
		MemberVariTableVO mvtVO = null;
		
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
			StringBuilder selectMemberCurrentSituation = new StringBuilder();
			selectMemberCurrentSituation
			.append("	select	(select count(mem_id) from member) sign_in_total,	")
			.append("			(select count(mem_id) from member where withdraw_flag != '1') member_now_total,	")
			.append("			(select count(mem_id) from member where withdraw_flag = '1') member_quit_total	")
			.append("	from dual	");
			
			pstmt = con.prepareStatement(selectMemberCurrentSituation.toString());

			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			if(rs.next()) {
				mvtVO = new MemberVariTableVO(rs.getInt("sign_in_total"), rs.getInt("member_now_total"), rs.getInt("member_quit_total"));
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return mvtVO;
	} // selectMemberCurrentSituation

	// 휴게소 조회수
	public List<RaViewRankVO> selectRAViewRank(int selDate) throws SQLException {
		List<RaViewRankVO> list = new ArrayList<RaViewRankVO>();
		
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
			StringBuilder selectRAViewRank = new StringBuilder();
			SelecDate date = SelecDate.values()[selDate];
			selectRAViewRank
			
			.append("	select	ranking, ra_name restareaname, cnt views	")
			.append("	from 	(	")
			.append("			select	row_number() over(order by cnt desc) ranking, ra.ra_name, rv.cnt	")
			.append("			from	(	")
			.append("					select	RA_NUM, count(to_char(views_date, 'yyyy-mm-dd')) cnt	")
			.append("					from 	ra_view	");
			
			switch(date) {
			case TODAY:
				selectRAViewRank.append("					where	trunc(viewS_date) = trunc(sysdate)	");
				break;
			case WEEK:
				selectRAViewRank.append("					where	trunc(viewS_date, 'WW') = trunc(sysdate, 'WW')	");
				break;
			case MONTH:
				selectRAViewRank.append("					where	trunc(viewS_date, 'MM') = trunc(sysdate, 'MM')	");
				break;
			} // end switch
			
			selectRAViewRank.append("					group by ra_num	")
			.append("					) rv,	")
			.append("					(select ra_num, ra_name from rest_area) ra	")
			.append("			where	rv.ra_num = ra.ra_num	")
			.append("			)	")
			.append("	where	ranking between 1 and 3	");
			
			pstmt = con.prepareStatement(selectRAViewRank.toString());

			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();

			RaViewRankVO rvrVO = null;
			while(rs.next()) {
				rvrVO = new RaViewRankVO(rs.getInt("ranking"), rs.getString("restAreaName"), rs.getInt("views"));
				list.add(rvrVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 		

		return list;
	} // selectRAViewRank

	//휴게소 리뷰 수
	public List<RaReviewRankVO> selectRAReviewRank(int selDate) throws SQLException {
		List<RaReviewRankVO> list = new ArrayList<RaReviewRankVO>();
		
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
			StringBuilder selectRAReviewRank = new StringBuilder();
			SelecDate date = SelecDate.values()[selDate];
			selectRAReviewRank
			.append("	select	ranking, ra_name restAreaName, cnt reviews	")
			.append("	from	(	")
			.append("			select	row_number() over (order by rv.cnt desc) ranking, ra.ra_name, rv.cnt	")
			.append("			from	(	")
			.append("					select	RA_NUM, count(to_char(INPUT_DATE, 'yyyy-mm-dd')) cnt	")
			.append("					from 	RA_REVIEW	");
			switch(date) {
			case TODAY:
				selectRAReviewRank.append("				where trunc(input_date) = trunc(sysdate)	");
				break;
			case WEEK:
				selectRAReviewRank.append("				where trunc(input_date, 'WW') = trunc(sysdate, 'WW')	");
				break;
			case MONTH:
				selectRAReviewRank.append("				where trunc(input_date, 'MM') = trunc(sysdate, 'MM')	");
				break;
			} // end switch
			selectRAReviewRank
			.append("					group by ra_num	")
			.append("					) rv,	")
			.append("					(select ra_num, ra_name from rest_area) ra	")
			.append("			where	rv.ra_num = ra.ra_num	")
			.append("			)	")
			.append("	where	ranking between 1 and 3	");
			pstmt = con.prepareStatement(selectRAReviewRank.toString());

			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			RaReviewRankVO rrrVO = null;
			while(rs.next()) {
				rrrVO = new RaReviewRankVO(rs.getInt("ranking"), rs.getString("restAreaName"), rs.getInt("reviews"));
				list.add(rrrVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 

		return list;
	} // selectRAReviewRank

	// 문의 내역
	public List<DashInquiryVO> selectDashInquiry() throws SQLException{
		List<DashInquiryVO> list = new ArrayList<DashInquiryVO>();

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
			StringBuilder selectDashInquiry = new StringBuilder();
			selectDashInquiry
			.append("	select 	case	")
			.append("				when length(title) > 15 then substr(title, 0, 12) || '...'	")
			.append("				else title	")
			.append("			end title,	")
			.append("			input_date inputDate,	")
			.append("			answer_flag flagAnswer	")
			.append("	from 	(	")
			.append("			select input_date, title, answer_flag, row_number() over (order by input_date desc) rnum from inquiry	")
			.append("			)	")
			.append("	where 	rnum between 1 and 5	");
			pstmt = con.prepareStatement(selectDashInquiry.toString());

			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			DashInquiryVO diVO = null;
			while(rs.next()) {
				diVO = new DashInquiryVO(rs.getString("title"), rs.getDate("inputDate"), rs.getBoolean("flagAnswer"));
				list.add(diVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return list;
	} // selectDashInquiry

	// 신고 내역
	public List<DashReviewReportVO> selectDashReport() throws SQLException{
		List<DashReviewReportVO> list = new ArrayList<DashReviewReportVO>();

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
			StringBuilder DashReviewReportVO = new StringBuilder();
			DashReviewReportVO
			.append("	select	case	")
			.append("				when length(title) > 15 then '[' || type_ || '] ' || substr(title, 0, 12) || '...'	")
			.append("				else '[' || type_ || '] ' || title	")
			.append("			end title,	")
			.append("			input_date inputDate,	")
			.append("			PROCESS_flag flagAnswer	")
			.append("	from	(	")
			.append("			select	row_number() over (order by input_date desc) rnum, type_, input_date, title, process_flag	")
			.append("			from	(	")
			.append("					select	'매장' type_, INPUT_DATE, TITLE, PROCESS_FLAG	")
			.append("					from	store_report	")
			.append("					union all	")
			.append("					select	'리뷰' type_, INPUT_DATE, CONTENT title, PROCESS_FLAG	")
			.append("					from	review_report	")
			.append("					)	")
			.append("			)	")
			.append("	where	rnum between 1 and 5	");
			pstmt = con.prepareStatement(DashReviewReportVO.toString());

			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			DashReviewReportVO drrVO = null;
			while(rs.next()) {
				drrVO = new DashReviewReportVO(rs.getString("title"), rs.getDate("inputDate"), rs.getBoolean("flagAnswer"));
				list.add(drrVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally
		
		return list;
	} // selectDashReport
} // class
