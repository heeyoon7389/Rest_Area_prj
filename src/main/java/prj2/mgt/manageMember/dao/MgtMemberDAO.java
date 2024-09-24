package prj2.mgt.manageMember.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.manageMember.vo.MemberVO;
import prj2.mgt.paging.vo.SearchVO;

public class MgtMemberDAO {
	private static MgtMemberDAO mDAO;
	
	private String[] columnNames;

	private MgtMemberDAO(){
		columnNames = new String[]{"mem_id", "nick"};
	} // MgtMemberDAO

	public static MgtMemberDAO getInstance(){
		if(mDAO == null) {
			mDAO = new MgtMemberDAO();
		} // end if
		return mDAO;
	} // getInstance

	// 검색된 회원 리스트 페이지 수 (검색 조건 타입, 검색어)
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
			StringBuilder selectTotalCount = new StringBuilder();
			selectTotalCount	// 모든 레코드의 수
			.append("	select	count(*) cnt from member	");
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectTotalCount.append("	where	").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(" like '%'||?||'%'	");
			} // end if
			pstmt = con.prepareStatement(selectTotalCount.toString());
		
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

	// 회원 리스트 검색 조회 (시작, 끝, 검색 조건 타입, 검색어)
	public List<MemberVO> selectPagingMember(SearchVO sVO) throws SQLException{
		List<MemberVO> list = new ArrayList<MemberVO>();

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
			StringBuilder selectPagingMember = new StringBuilder();
			selectPagingMember
			.append("	select 	rnum, mem_id, nick, email, name, suspend_flag, withdraw_flag	")
			.append("	from	(	")
			.append("			select 	row_number() over(order by mem_id) rnum, mem_id, nick, email, name, suspend_flag, withdraw_flag	")
			.append("			from 	member	");

			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectPagingMember.append("	where instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(", ? ) > 0	");
			} // end if
			
			selectPagingMember.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingMember.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			MemberVO mVO = null;
			while(rs.next()) {
				mVO = new MemberVO(rs.getString("mem_id"), null, rs.getString("name"), rs.getString("nick"), rs.getString("email"), null, rs.getBoolean("suspend_flag"), null, rs.getBoolean("withdraw_flag"), null);
				list.add(mVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return list;
	} // selectPagingMember

	// 회원 상세 조회
	public MemberVO selectOneMember(String memId) throws SQLException{
		MemberVO mVO = null;
		
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
			StringBuilder selectOneMember = new StringBuilder();
			selectOneMember
			.append("	select	MEM_ID, NAME, NICK, EMAIL, JOIN_DATE, SUSPEND_FLAG, SUSPEND_DATE, WITHDRAW_FLAG, WITHDRAW_DATE	")
			.append("	from	member	")
			.append("	where	MEM_ID = ?	");
			pstmt = con.prepareStatement(selectOneMember.toString());
		
			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, memId);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				mVO = new MemberVO(memId, null, rs.getString("name"), rs.getString("nick"), rs.getString("email"), rs.getDate("join_date"), rs.getBoolean("suspend_flag"), rs.getDate("suspend_date"), rs.getBoolean("withdraw_flag"), rs.getDate("withdraw_date"));
			} // end if
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 

		return mVO;
	} // selectOneMember

	// 회원 활동 정지 / 해제
	public int updateMemberSuspend(String memId, boolean flagSuspend) throws SQLException{
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
			StringBuilder updateMemberSuspend = new StringBuilder();
			updateMemberSuspend
			.append("	update 	member	");
			if(flagSuspend) {
				updateMemberSuspend.append("	set		SUSPEND_FLAG = 1, SUSPEND_DATE = sysdate	");
			} else {
				updateMemberSuspend.append("	set		SUSPEND_FLAG = 0, SUSPEND_DATE = ''	");
			} // end else
			updateMemberSuspend.append("	where 	mem_id=?	");
			pstmt = con.prepareStatement(updateMemberSuspend.toString());
			
			pstmt.setString(1, memId);
			
			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateMemberSuspend

	// 회원 탈퇴
	public int deleteMember(String id) {
		int retval = 0;

		return retval;
	} // deleteMember

} // class
