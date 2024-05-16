package prj2.mgt.post.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.paging.vo.SearchVO;
import prj2.mgt.post.vo.MgtStoreRepVO;

public class MgtStoreRepDAO {
	private static MgtStoreRepDAO msrDAO;
	
	private String[] columnNames;

	private MgtStoreRepDAO(){
		columnNames = new String[]{"mem_id", "title", "content", "ra_name", "store_name"};
	} // MgtStoreRepDAO

	public static MgtStoreRepDAO getInstance(){
		if(msrDAO == null) {
			msrDAO = new MgtStoreRepDAO();
		} // end if
		return msrDAO;
	} // getInstance

	// 검색된 매장 신고 리스트 페이지 수 (검색 조건 타입, 검색어)
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
			.append("	from	(select STORE_NUM, NUM_REP_STORE, TITLE, content, MEM_ID, INPUT_DATE, PROCESS_FLAG, PROCESS_DATE from store_report) rpt,	")
			.append("			(select RA_NUM, STORE_NUM, STORE_NAME from store) st,	")
			.append("			(select RA_NUM, RA_NAME from REST_AREA) ra	")
			.append("	where	(st.ra_num = ra.ra_num and rpt.store_num = st.store_num)	");
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				int field = Integer.parseInt(sVO.getField());
				switch(field) {
				case 0:
				case 1:
				case 2:
					selectMaxPage.append("	and rpt.");
					break;
				case 3:
					selectMaxPage.append("	and ra.");
					break;
				case 4:
					selectMaxPage.append("	and st.");
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

	// 매장 신고 리스트 검색 (시작, 끝, 검색 조건 타입, 검색어)
	public List<MgtStoreRepVO> selectPagingStoreRep(SearchVO sVO) throws SQLException{
		List<MgtStoreRepVO> list = new ArrayList<MgtStoreRepVO>();
		
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
			StringBuilder selectPagingStoreRep = new StringBuilder();
			selectPagingStoreRep
			.append("	select	rnum, num_rep_store, title, mem_id, input_date, ra_name, store_name, process_flag, process_date	")
			.append("	from	(	")
			.append("			select	row_number() over(order by rpt.process_flag, rpt.input_date desc) rnum, rpt.num_rep_store, rpt.title, rpt.mem_id, rpt.input_date, ra.ra_name, st.store_name, rpt.process_flag, rpt.process_date	")
			.append("			from	(select STORE_NUM, NUM_REP_STORE, TITLE, content, MEM_ID, INPUT_DATE, PROCESS_FLAG, PROCESS_DATE from store_report) rpt,	")
			.append("					(select RA_NUM, STORE_NUM, STORE_NAME from store) st,	")
			.append("					(select RA_NUM, RA_NAME from REST_AREA) ra	")
			.append("			where	(st.ra_num = ra.ra_num and rpt.store_num = st.store_num)	");
			
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				int field = Integer.parseInt(sVO.getField());
				switch(field) {
				case 0:
				case 1:
				case 2:
					selectPagingStoreRep.append("	and instr(rpt.");
					break;
				case 3:
					selectPagingStoreRep.append("	and instr(ra.");
					break;
				case 4:
					selectPagingStoreRep.append("	and instr(st.");
					break;
				} // end switch
				selectPagingStoreRep.append(columnNames[field])
				.append(", ? ) > 0	");
			} // end if
			
			selectPagingStoreRep.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingStoreRep.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			MgtStoreRepVO msrVO = null;
			while(rs.next()) {
				msrVO = new MgtStoreRepVO(rs.getInt("num_rep_store"), rs.getString("mem_id"), rs.getString("title"), null, rs.getString("store_name"), rs.getString("ra_name"), rs.getDate("input_date"), rs.getInt("process_flag"), null, rs.getDate("process_date"));
				list.add(msrVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally
		
		return list;
	} // selectPagingStoreRep

	// 매장 신고 상세 조회
	public MgtStoreRepVO selectOneStoreRep(int storeRepNum) throws SQLException{
		MgtStoreRepVO msrVO = null;

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
			StringBuilder selectOneStoreRep = new StringBuilder();
			selectOneStoreRep
			.append("	select	rpt.num_rep_store store_rep_num, rpt.title, rpt.mem_id, rpt.input_date, ra.ra_name, st.store_name, rpt.content, rpt.process_contents, rpt.process_flag	")
			.append("	from	(select STORE_NUM, NUM_REP_STORE, TITLE, CONTENT, MEM_ID, INPUT_DATE, PROCESS_FLAG, process_contents from store_report) rpt,	")
			.append("			(select RA_NUM, STORE_NUM, STORE_NAME from store) st,	")
			.append("			(select RA_NUM, RA_NAME from REST_AREA) ra	")
			.append("	where	(st.ra_num = ra.ra_num and rpt.store_num = st.store_num)	")
			.append("			and (rpt.num_rep_store = ?)	");
			pstmt = con.prepareStatement(selectOneStoreRep.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, storeRepNum);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				msrVO = new MgtStoreRepVO(storeRepNum, rs.getString("mem_id"), rs.getString("title"), rs.getString("content"), rs.getString("store_name"), rs.getString("ra_name"), rs.getDate("input_date"), rs.getInt("process_flag"), rs.getString("process_contents"), null);
			} // end if 
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return msrVO;
	} // selectOneStoreRep

	// 신고 내용 처리
	public int updateStoreReq(MgtStoreRepVO msrVO, String managerId) throws SQLException{
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
			StringBuilder updateStoreReq = new StringBuilder();
			updateStoreReq
			.append("	update	store_report	")
			.append("	set 	process_flag = ?,	")
			.append("			process_contents = ?,	")
			.append("			process_date = sysdate	")
			.append("	where	num_rep_store = ? and	")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(updateStoreReq.toString());
			
			pstmt.setInt(1, msrVO.getProcessFlag());
			pstmt.setString(2, msrVO.getProcessContents());
			pstmt.setInt(3, msrVO.getStoreRepNum());
			pstmt.setString(4, managerId);
			
			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateStoreReq

} // code
