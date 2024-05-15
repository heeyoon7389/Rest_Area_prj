package prj2.common.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import restAreaDbConnection.DbConnection;

public class CntDAO {
	private static CntDAO cDAO;
	private CntDAO() {
		
	} // CntDAO
	
	public static CntDAO getInstance() {
		if(cDAO == null) {
			cDAO = new CntDAO();
		} // end if
		return cDAO;
	} // getInstance
	
	
	/**
	 * 공지사항 조회수 1 증가
	 * @param announceNum 공지사항 번호
	 * @return 
	 * @throws SQLException
	 */
	public int updateAnnounceViewCnt(int announceNum) throws SQLException {
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
			StringBuilder updateAnnounceViewCnt = new StringBuilder();
			updateAnnounceViewCnt
			.append("	update announce	")
			.append("	set announce_view = announCe_view + 1	")
			.append("	where announce_num=?	");
			pstmt = con.prepareStatement(updateAnnounceViewCnt.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, announceNum);

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateAnnounceViewCnt
	
	/**
	 * 휴게소 조회수 추가
	 * @param raNum 휴게소 코드
	 * @return
	 * @throws SQLException
	 */
	public void insertRestAreaViewCnt(String raNum) throws SQLException {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			String insertRestAreaViewCnt = "	insert into RA_VIEW(RA_NUM, VIEWS_DATE) values (?, sysdate)	";
			pstmt = con.prepareStatement(insertRestAreaViewCnt);
			
			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, raNum);
			
			// 6. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
	} // insertRestAreaViewCnt
	
	/**
	 * 오늘자 사이트 방문자수를 회원/비회원으로 구분하여 없으면 insert, 있으면 update
	 * @param flagMember 회원이면 true, 비회원이면 false
	 * @return
	 * @throws SQLException
	 */
	public int mergeIntoVisitorViewCnt(boolean flagMember) throws SQLException{
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
			StringBuilder mergeIntoVisitorViewCnt = new StringBuilder();
			mergeIntoVisitorViewCnt
			.append("	merge into	visitor	")
			.append("	using		dual	")
			.append("	on 			(input_date = to_char(sysdate, 'yyyy-mm-dd'))	");
			if(flagMember) {
				mergeIntoVisitorViewCnt
				.append("	when 		matched then	update set MEM_CNT = MEM_CNT + 1	")
				.append("	when not 	matched then	insert (input_date, MEM_CNT, NON_MEM_CNT) values (to_char(sysdate, 'yyyy-mm-dd'), 1, 0)	");
			} else {
				mergeIntoVisitorViewCnt
				.append("	when 		matched then	update set NON_MEM_CNT = NON_MEM_CNT + 1	")
				.append("	when not 	matched then	insert (input_date, MEM_CNT, NON_MEM_CNT) values (to_char(sysdate, 'yyyy-mm-dd'), 0, 1)	");
			} // end else
			pstmt = con.prepareStatement(mergeIntoVisitorViewCnt.toString());
			
			// 5. 바인드 변수에 값 설정

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // mergeIntoVisitorViewCnt
} // class
