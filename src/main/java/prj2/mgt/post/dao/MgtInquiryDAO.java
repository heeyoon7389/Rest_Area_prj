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
import prj2.mgt.post.vo.InquiryVO;

public class MgtInquiryDAO {
	private static MgtInquiryDAO inDAO;

	private String[] columnNames;
	
	private MgtInquiryDAO(){
		columnNames = new String[]{"title_content", "title", "content", "mem_id"}; // 검색 컬럼
	} // MgtInquiryDAO

	public static MgtInquiryDAO getInstance(){
		if(inDAO == null) {
			inDAO = new MgtInquiryDAO();
		} // end if
		return inDAO;
	} // getInstance

	// 검색된 문의 리스트 수 (검색 조건 타입, 검색어)
	public int selectMaxPage(SearchVO sVO) throws SQLException {
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
			selectTotalCount.append("	select count(*) cnt from (select inquiry.*, title||'㏇'||content title_content from inquiry)	");	// 모든 레코드의 수
			// 검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectTotalCount.append("	where ").append(columnNames[Integer.parseInt(sVO.getField())]).append(" like '%'||?||'%'	");
			} // end if
			pstmt = con.prepareStatement(selectTotalCount.toString());

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

	// 문의 리스트 검색 조회 (시작, 끝, 검색 조건 타입, 검색어)
	public List<InquiryVO> selectPagingInquiry(SearchVO sVO) throws SQLException{
		List<InquiryVO> list = new ArrayList<InquiryVO>();
		
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
			StringBuilder selectPagingInquiry = new StringBuilder();
			selectPagingInquiry
			.append("	select	INQUIRY_NUM, TITLE, title_content, SECRET_FLAG, MEM_ID, INPUT_DATE, ANSWER_FLAG, rnum	")
			.append("	from 	(select INQUIRY_NUM, TITLE, title_content, SECRET_FLAG, MEM_ID, INPUT_DATE, ANSWER_FLAG, row_number() over(order by input_date desc) rnum	")
			.append("			from	(	")
			.append("					select inquiry.*, title||'㏇'||content title_content from inquiry	")
			.append("					)	");
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				selectPagingInquiry.append("	where instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(", ? ) > 0	");
			} // end if
			
			selectPagingInquiry.append("	) where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingInquiry.toString());
			
			// 바인드 변수에 값 설정
			int bindIndex = 0;
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword())) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			} // end if
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			InquiryVO iVO = null;
			while(rs.next()) {
				iVO = new InquiryVO();
				iVO.setInquiryNum(rs.getInt("inquiry_num"));
				iVO.setTitle(rs.getString("title"));
				iVO.setSecretFlag(rs.getBoolean("secret_flag"));
				iVO.setMemId(rs.getString("mem_id"));
				iVO.setInputDate(rs.getDate("input_date"));
				iVO.setAnswerFlag(rs.getBoolean("answer_flag"));
				list.add(iVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 

		return list;
	} // selectPagingInquiry

	// 문의 상세 조회
	public InquiryVO selectOneInquiry(int inquiryNum) throws SQLException{
		InquiryVO iVO= null;
		
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
			.append("	select	INQUIRY_NUM, MEM_ID, TITLE, secret_flag, INPUT_DATE, CONTENT, ANSWER_FLAG, ANSWER_CONTENTS, ANSWER_DATE	")
			.append("	from	inquiry	")
			.append("	where 	INQUIRY_NUM = ?");
			pstmt = con.prepareStatement(selectBoard.toString());
		
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, inquiryNum);
			
			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				StringBuilder content = new StringBuilder();
				String temp = "";
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
				iVO = new InquiryVO(rs.getInt("INQUIRY_NUM"), rs.getString("MEM_ID"), rs.getString("TITLE"), content.toString(), rs.getDate("INPUT_DATE"), rs.getBoolean("secret_flag"), rs.getBoolean("ANSWER_FLAG"), rs.getString("ANSWER_CONTENTS"), rs.getDate("ANSWER_DATE"), null);
			} // end if
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
		
		return iVO;
	} // selectOneInquiry

	// 문의 수정 (답변)
	public int updateInquiry(InquiryVO iVO) throws SQLException{
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
			StringBuilder updateInquiry = new StringBuilder();
			updateInquiry
			.append("	update 	inquiry	")
			.append("	set		answer_Flag=1, ANSWER_CONTENTS=?, ANSWER_DATE=sysdate	")
			.append("	where 	INQUIRY_NUM=?	and  ")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(updateInquiry.toString());
			
			pstmt.setString(1, iVO.getAnswerContents());
			pstmt.setInt(2, iVO.getInquiryNum());
			pstmt.setString(3, iVO.getManagerId());
			
			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // updateInquiry

	// 문의 삭제
	public int deleteInquiry(InquiryVO iVO) throws SQLException {
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
			StringBuilder deleteInquiry = new StringBuilder();
			deleteInquiry
			.append("	delete from inquiry	")
			.append("	where	inquiry_num=? and	")
			.append("			((select 1 from manager where manager_id = ?) = 1)	");
			pstmt = con.prepareStatement(deleteInquiry.toString());
			
			// 5. 바인드 변수에 값 설정
			pstmt.setInt(1, iVO.getInquiryNum());
			pstmt.setString(2, iVO.getManagerId());

			// 6. 쿼리문 수행 후 결과 얻기
			cnt = pstmt.executeUpdate();
			
		} finally { 
			// 7. 연결 끊기
			db.closeCon(null, pstmt, con);
		} // end finally 
		
		return cnt;
	} // deleteInquiry
} // class
