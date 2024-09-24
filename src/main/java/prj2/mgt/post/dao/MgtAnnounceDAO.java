package prj2.mgt.post.dao;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;
import prj2.mgt.paging.vo.SearchVO;
import prj2.mgt.post.vo.AnnounceVO;

public class MgtAnnounceDAO {
	private static MgtAnnounceDAO staticanDAO;
	private String[] columnNames;

	private MgtAnnounceDAO(){
		columnNames = new String[]{"title_content", "title", "content", "manager_id"}; // 검색 컬럼
	} // MgtAnnounceDAO

	public static MgtAnnounceDAO getInstance(){
		if(staticanDAO == null) {
			staticanDAO = new MgtAnnounceDAO();
		} // end if
		return staticanDAO;
	} // getInstance
	
	
	/**
	 * 공지사항 조회수 증가
	 * @param views
	 * @return
	 * @throws SQLException
	 */
	public int updateViews(int views) throws SQLException {
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
			StringBuilder updateViews = new StringBuilder();
			updateViews
			.append("	update announce	")
			.append("	set announce_view = announCe_view + 1	")
			.append("	where announce_num=?	");
			pstmt = con.prepareStatement(updateViews.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, views);

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateViews

	// 검색된 공지사항 리스트 수 (검색 조건 타입, 검색어)
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
			
			selectMaxPage.append("	select count(*) cnt from (select announce.*, title||'㏇'||content title_content from announce) where delete_flag='0'	");	// 모든 레코드의 수
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectMaxPage.append("	and ").append(columnNames[Integer.parseInt(sVO.getField())]).append(" like '%'||?||'%'	");
			} // end if
			pstmt = con.prepareStatement(selectMaxPage.toString());

			// 5. 바인드 변수에 값 설정
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(1, sVO.getKeyword());
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

	// 공지사항 리스트 검색 조회 (시작, 끝, 검색 조건 타입, 검색어)
	public List<AnnounceVO> selectPagingAnnounce(SearchVO sVO) throws SQLException {
		List<AnnounceVO> list = new ArrayList<AnnounceVO>();


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
			StringBuilder selectPagingAnnounce = new StringBuilder();
			selectPagingAnnounce
			.append("	select	announce_num, title, nick, input_date, announce_view views, rnum	")
			.append("	from 	(select	row_number() over (order by input_date desc) rnum, an.announce_num, an.title, ma.nick, an.input_date, an.announce_view	")
			.append("			from	(select ANNOUNCE_NUM, TITLE, content, title||'㏇'||content title_content, MANAGER_ID, INPUT_DATE, ANNOUNCE_VIEW, DELETE_FLAG from announce) an,	")
			.append("					(select manager_id, nick from manager) ma	")	
			.append("			where	(an.manager_id = ma.manager_id) and an.delete_flag = '0'	");
			
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectPagingAnnounce.append("	and instr(an.").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(", ? ) > 0	");
			} // end if
			
			selectPagingAnnounce.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingAnnounce.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			AnnounceVO aVO = null;
			while(rs.next()) {
				aVO = new AnnounceVO(rs.getInt("announce_num"), null, rs.getString("nick"), rs.getString("title"), null, rs.getDate("input_date"), rs.getInt("views"), false, null);
				list.add(aVO);
			} // end while
		} finally {
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return list;
	} // selectPagingAnnounce

	// 공지사항 상세 조회
	public AnnounceVO selectOneAnnounce(int announceNum) throws SQLException{
		AnnounceVO aVO = null;

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
			StringBuilder selectBoard = new StringBuilder();
			selectBoard
			.append("	select	a.ANNOUNCE_NUM, a.title, a.input_date, m.nick, a.manager_id, a.announce_view, a.content	")
			.append("	from	(select ANNOUNCE_NUM, title, input_date, manager_id, announce_view, content from announce) a,	")
			.append("			(select manager_id, nick from manager) m	")
			.append("	where	(a.manager_id = m.manager_id) and (a.ANNOUNCE_NUM = ?)	");
			pstmt = con.prepareStatement(selectBoard.toString());
		
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, announceNum);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			aVO = new AnnounceVO();
			if(rs.next()) {
				StringBuilder content = new StringBuilder();
				String temp = "";
				// content는 clob 데이터형이어서 별도의 Stream을 연결하여 검색한다
				BufferedReader br = null;
				try {
					br = new BufferedReader(rs.getClob("content").getCharacterStream());
					while( (temp = br.readLine()) != null) {
						content.append(temp).append("\n");	// textarea에선 줄바꿈이 \n
					} // end while
					br.close();
				} catch (IOException ioe) {
					ioe.printStackTrace();
				} // end catch
				
				aVO = new AnnounceVO(announceNum, rs.getString("manager_id"), rs.getString("nick"), rs.getString("title"), content.toString(), rs.getDate("input_date"), rs.getInt("announce_view"), false, null);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return aVO;
	} // selectOneAnnounce

	// 공지사항 등록
	public void insertAnnounce(AnnounceVO aVO) throws SQLException {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			// 1. JNDI 사용 객체 생성
			// 2. DataSource 얻기
			// 3. Connection 얻기
			con = db.getConn("jdbc/restarea");
		
			// 4. 쿼리문 생성 객체 얻기 (Dynamic Query)
			String insertBoard = "	insert into announce (ANNOUNCE_NUM, MANAGER_ID, TITLE, CONTENT, ANNOUNCE_VIEW) values (seq_announce.nextval, ?, ?, ?, ?)	";
			pstmt = con.prepareStatement(insertBoard);
			
			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, aVO.getManagerId());
			pstmt.setString(2, aVO.getTitle());
			pstmt.setString(3, aVO.getContent());
			pstmt.setInt(4, aVO.getViews());

			// 6. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
	} // insertAnnounce

	// 공지사항 수정
	public int updateAnnounce(AnnounceVO aVO) throws SQLException{
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
			StringBuilder updateAnnounce = new StringBuilder();
			updateAnnounce
			.append("	update	announce	")
			.append("	set		title=?,	")
			.append("			content=?,	")
			.append("			announce_view=?	")
			.append("	where	announce_num = ? and manager_id = ?	");
			pstmt = con.prepareStatement(updateAnnounce.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, aVO.getTitle());
			pstmt.setString(2, aVO.getContent());
			pstmt.setInt(3, aVO.getViews());
			pstmt.setInt(4, aVO.getAnnounceNum());
			pstmt.setString(5, aVO.getManagerId());

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateAnnounce

	// 공지사항 삭제
	public int deleteAnnounce(AnnounceVO aVO) throws SQLException{
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
			StringBuilder deleteAnnounce = new StringBuilder();
			deleteAnnounce
			.append("	update	announce	")
			.append("	set		delete_flag = '1',	")
			.append("			delete_date = sysdate	")
			.append("	where	announce_num = ? and manager_id = ?	");
			pstmt = con.prepareStatement(deleteAnnounce.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, aVO.getAnnounceNum());
			pstmt.setString(2, aVO.getManagerId());

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // deleteAnnounce
} // class
