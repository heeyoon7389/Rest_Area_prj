package prj2DAO;

import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj2VO.MyInquiryVO;
import prj2VO.SearchVO;

public class MyInquiryDAO {

	private static MyInquiryDAO miDAO;
	
	private String[] columnNames;
	
	private MyInquiryDAO() {
		//키워드 검색할 열이름
		columnNames = new String[] {"title", "content", "ANSWER_CONTENTS"};
	}
	
	public static MyInquiryDAO getInstance() {
		if(miDAO == null) {
			miDAO=new MyInquiryDAO();
		}//end if
		return miDAO;
	}//getInstance
	
	/**
	 * 특정회원의 전체 레코드 개수 구하기
	 * @param id
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount(String id, SearchVO sVO)throws SQLException{
		int totalCnt = 0;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection db=DbConnection.getInstance();
		
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectCnt = new StringBuilder();
			//특정회원의 모든 레코드 수
			selectCnt.append(" select count(*) cnt from INQUIRY where mem_id=? ");
			
			//검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				selectCnt
				.append(" and instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(",? ) > 0 ");
			}//end if
			
			pstmt=con.prepareStatement(selectCnt.toString());
			
			//5. 바인드변수에 값 설정
			pstmt.setString(1, id);
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				pstmt.setString(2, sVO.getKeyword());
			}//end if
			
			//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalCnt=rs.getInt("cnt");
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		}//end finally
		return totalCnt;
	}//selectTotalCount
	
	/**
	 * 특정회원이 작성한 전체 글 select
	 * @param id
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public List<MyInquiryVO> selectBoard(String id, SearchVO sVO)throws SQLException{
		List<MyInquiryVO> list=new ArrayList<MyInquiryVO>();
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection db=DbConnection.getInstance();
		
		try {
		//1. JNDI 사용객체 생성
		//2. DataSource 얻기
		//3. Connection 얻기
			con=db.getConn("jdbc/restarea");
		//4. 쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectBoard=new StringBuilder();
			
			selectBoard
			.append("	select rnum, INQUIRY_NUM, MEM_ID, TITLE, INPUT_DATE, SECRET_FLAG, ANSWER_FLAG	")
			.append("	from (select INQUIRY_NUM, MEM_ID, TITLE, INPUT_DATE, SECRET_FLAG, ANSWER_FLAG,	")
			.append("			row_number() over(order by input_date desc) rnum	")
			.append("			from INQUIRY ")
			.append("			where mem_id=? ");
			
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				
				selectBoard
				.append(" and instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(",? ) > 0 ");
				
			}//end if
			
			selectBoard.append(" )	where rnum between ? and ?	");
			
			pstmt=con.prepareStatement(selectBoard.toString());
			
		//5. 바인드변수에 값 설정
			int bindIndex=0;
			pstmt.setString(++bindIndex, id);
			if(sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			}//end if
			
			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
		//6. 쿼리문 수행 후 결과얻기
			
			rs=pstmt.executeQuery();
			MyInquiryVO miVO=null;
			while(rs.next()) {
				MyInquiryVO miVOBuilder= miVO.builder()
						.inquiryNum(rs.getString("INQUIRY_NUM"))
						.memId(rs.getString("MEM_ID"))
						.title(rs.getString("TITLE"))
						.secretFlag(rs.getString("SECRET_FLAG")) 
						.answerFlag(rs.getString("ANSWER_FLAG")) 
						.inputDate(rs.getDate("INPUT_DATE"))
						.build();
				
				list.add(miVOBuilder);
			}//end while
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectBoard
	
	/**
	 * 특정회원이 작성한 글의 내용
	 * @param seq
	 * @param id
	 * @return
	 * @throws SQLException
	 */
	public MyInquiryVO selectDetailBoard(String inquiryNum)throws SQLException{
		MyInquiryVO miVO = null;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection db = DbConnection.getInstance();
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/restarea");
			//4. 쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder selectBoard=new StringBuilder();
			
			selectBoard
			.append("	select MEM_ID, INQUIRY_NUM, TITLE, CONTENT, INPUT_DATE, SECRET_FLAG, ANSWER_CONTENTS, ANSWER_DATE, ANSWER_FLAG	")
			.append("	from INQUIRY ")
			.append("	where INQUIRY_NUM=?  ");
			
			pstmt=con.prepareStatement(selectBoard.toString());
			
			//5. 바인드변수에 값 설정
			pstmt.setString(1, inquiryNum);
			
			//6. 쿼리문 수행 후 결과얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				StringBuilder content = new StringBuilder();
				String temp="";
				
				//content는 clob데이터 형이여서 별도의 Stream을 연결하여 검색.
				BufferedReader br = null;
				try {
//					문의내용
					br = new BufferedReader(rs.getClob("CONTENT").getCharacterStream());
					while((temp = br.readLine()) != null) {
						content.append(temp).append("\n");
					}//end while
					br.close();
				}catch(IOException ie) {
					ie.printStackTrace();
				}//end catch
				
				MyInquiryVO miVOBuilder= miVO.builder()
				.inquiryNum(rs.getString("INQUIRY_NUM"))
				.memId(rs.getString("MEM_ID"))
				.title(rs.getString("TITLE"))
				.content(content.toString())
				.secretFlag(rs.getString("SECRET_FLAG"))
				.inputDate(rs.getDate("INPUT_DATE"))
				.answerContents(rs.getString("ANSWER_CONTENTS"))
				.answerFlag(rs.getString("ANSWER_FLAG")) 
				.answerDate(rs.getDate("ANSWER_DATE"))
				.build();
				
				miVO = miVOBuilder;
			}//end if
		}finally {
			//7. 연결 끊기
				db.closeCon(rs, pstmt, con);
		}//end finally
		return miVO;
	}//selectDetailBoard
	
	/**
	 * 글 수정
	 * @param miVO
	 * @return
	 * @throws SQLException
	 */
	public int updateBoard( MyInquiryVO miVO )throws SQLException{
		int cnt=0;
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/restarea");
			//4. 쿼리문 생성객체 얻기(Dynamic Query)
			
			StringBuilder updateBoard= new StringBuilder();
			updateBoard
			.append(" update INQUIRY ")
			.append(" set TITLE=?, CONTENT=?, ")
			.append(" INPUT_DATE=sysdate, SECRET_FLAG=? ")
			.append(" where INQUIRY_NUM=? and MEM_ID=? ");
			
			pstmt=con.prepareStatement(updateBoard.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, miVO.getTitle());
			pstmt.setString(2, miVO.getContent());
			pstmt.setString(3, miVO.getSecretFlag());
			pstmt.setString(4, miVO.getInquiryNum());
			pstmt.setString(5, miVO.getMemId());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
				db.closeCon(null, pstmt, con);
		}//end finally
			
		return cnt;
	}//updateBoard
	
	/**
	 * 글 삭제
	 * @param miVO
	 * @return
	 * @throws SQLException
	 */
	public int deleteBoard( MyInquiryVO miVO )throws SQLException{
		int cnt=0;
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection db = DbConnection.getInstance();
		try {
			//1. JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con=db.getConn("jdbc/restarea");
			
			//4. 쿼리문 생성객체 얻기(Dynamic Query)
			StringBuilder deleteBoard= new StringBuilder();
			deleteBoard
			.append(" delete INQUIRY ")
			.append(" where INQUIRY_NUM=? and MEM_ID=? ");
			
			pstmt=con.prepareStatement(deleteBoard.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, miVO.getInquiryNum());
			pstmt.setString(2, miVO.getMemId());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
			db.closeCon(null, pstmt, con);
		}//end finally
		
		return cnt;
	}//deleteBoard
}//class
