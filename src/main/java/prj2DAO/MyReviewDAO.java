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

import prj2VO.MyReviewVO;
import prj2VO.SearchVO;

public class MyReviewDAO {

	private static MyReviewDAO mrDAO;
	
	private String[] columnNames;
	
	private MyReviewDAO() {
		//키워드 검색할 열이름
		columnNames = new String[] {"RA_NAME", "content"};//내용으로 검색
	}
	
	public static MyReviewDAO getInstance() {
		if(mrDAO == null) {
			mrDAO=new MyReviewDAO();
		}//end if
		return mrDAO;
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
			selectCnt.append(" select count(*) cnt from RA_REVIEW where mem_id=? and DELETE_FLAG != '1' and BLIND_FLAG != '1' ");
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
	public List<MyReviewVO> selectBoard(String id, SearchVO sVO)throws SQLException{
		List<MyReviewVO> list=new ArrayList<MyReviewVO>();
		
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
			.append("	select rnum, RA_REVIEW_NUM, MEM_ID, RA_NUM, CONTENT, INPUT_DATE		")
			.append("	from ( select RA_REVIEW_NUM, MEM_ID, RA_NUM, CONTENT, INPUT_DATE,	")
			.append("			row_number() over(order by INPUT_DATE desc) rnum	")
			.append("			from RA_REVIEW ")
			.append("			where mem_id=? and DELETE_FLAG != '1' and BLIND_FLAG != '1'  ");
			
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
			MyReviewVO mrVO=null;
			while(rs.next()) {
				MyReviewVO mrVOBuilder= mrVO.builder()
						.raReviewNum(rs.getString("RA_REVIEW_NUM"))
						.memId(rs.getString("MEM_ID"))
						.raNum(rs.getString("RA_NUM"))
						.content(rs.getString("CONTENT")) 
						.inputDate(rs.getDate("INPUT_DATE"))
						.build();
				list.add(mrVOBuilder);
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
	public MyReviewVO selectDetailBoard(String raReviewNum)throws SQLException{
		MyReviewVO mrVO = null;
		
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
			.append("	select RA_REVIEW_NUM, MEM_ID, RA_NUM, CONTENT, INPUT_DATE	")
			.append("	from RA_REVIEW ")
			.append("	where RA_REVIEW_NUM=?  ");
			
			pstmt=con.prepareStatement(selectBoard.toString());
			
			//5. 바인드변수에 값 설정
			pstmt.setString(1, raReviewNum);
			
			//6. 쿼리문 수행 후 결과얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				
				MyReviewVO mrVOBuilder= mrVO.builder()
						.raReviewNum(rs.getString("RA_REVIEW_NUM"))
						.memId(rs.getString("MEM_ID"))
						.raNum(rs.getString("RA_NUM"))
						.content(rs.getString("CONTENT")) 
						.inputDate(rs.getDate("INPUT_DATE"))
						.build();
				
				mrVO = mrVOBuilder;
			}//end if
		}finally {
			//7. 연결 끊기
				db.closeCon(rs, pstmt, con);
		}//end finally
		return mrVO;
	}//selectDetailBoard
	
	/**
	 * 글 수정
	 * @param mrVO
	 * @return
	 * @throws SQLException
	 */
	public int updateBoard( MyReviewVO mrVO )throws SQLException{
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
			.append(" update RA_REVIEW ")
			.append(" set CONTENT=?, ")
			.append(" INPUT_DATE=sysdate ")
			.append(" where RA_REVIEW_NUM=? and MEM_ID=? ");
			
			pstmt=con.prepareStatement(updateBoard.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, mrVO.getContent());
			pstmt.setString(2, mrVO.getRaReviewNum());
			pstmt.setString(3, mrVO.getMemId());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
				db.closeCon(null, pstmt, con);
		}//end finally
			
		return cnt;
	}//updateBoard
	
	/**
	 * 글 삭제
	 * @param mrVO
	 * @return
	 * @throws SQLException
	 */
	public int updateDeleteFlag( MyReviewVO mrVO )throws SQLException{
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
			
			StringBuilder updateDeleteFlag= new StringBuilder();
			updateDeleteFlag
			.append(" update RA_REVIEW ")
			.append(" set DELETE_FLAG='1', DELETE_DATE=sysdate ")
			.append(" where RA_REVIEW_NUM=? and MEM_ID=? ");
			
			pstmt=con.prepareStatement(updateDeleteFlag.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, mrVO.getRaReviewNum());
			pstmt.setString(2, mrVO.getMemId());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
				db.closeCon(null, pstmt, con);
		}//end finally
			
		return cnt;
	}//updateDeleteFlag
	
	/**
	 * 휴게소이름 select
	 * @param raNum
	 * @return
	 * @throws SQLException
	 */
	public String selectRaName(String raNum)throws SQLException{
		String raName = "";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			con = db.getConn("jdbc/restarea");
			String selectRaName=" select RA_NAME from REST_AREA where RA_NUM=? ";
			
			pstmt = con.prepareStatement(selectRaName);
			
			pstmt.setString(1, raNum);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				raName = rs.getString("RA_NAME");
			}
		}finally {
			db.closeCon(rs, pstmt, con);
		}//end finally
		return raName;
	}//selectRaName
	
	/**
	 * 별점 select
	 * @param raNum
	 * @return
	 * @throws SQLException
	 */
	public double selectStar(String id, String raNum)throws SQLException{
		double star=0;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			con = db.getConn("jdbc/restarea");
			StringBuilder selectStar= new StringBuilder();
			selectStar
			.append("	select STAR	")
			.append("	from STAR_RATE	")
			.append("	where  MEM_ID=? and RA_NUM=?	");
			
			pstmt = con.prepareStatement(selectStar.toString());
			
			pstmt.setString(1, id);
			pstmt.setString(2, raNum);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				star = rs.getDouble("STAR");
			}
		}finally {
			db.closeCon(rs, pstmt, con);
		}//end finally
		return star;
	}//selectStar
	
	/**
	 * 별점 update
	 * @param mrVO
	 * @return
	 * @throws SQLException
	 */
	public int updateStar( MyReviewVO mrVO )throws SQLException{
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
			
			StringBuilder updateStar= new StringBuilder();
			updateStar
			.append(" update STAR_RATE ")
			.append(" set STAR=?, INPUT_DATE=sysdate ")
			.append(" where  MEM_ID=? and RA_NUM=? ");
			
			pstmt=con.prepareStatement(updateStar.toString());
			
			//바인드 변수에 값 설정
			pstmt.setDouble(1, mrVO.getStar());
			pstmt.setString(2, mrVO.getMemId());
			pstmt.setString(3, mrVO.getRaNum());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
				db.closeCon(null, pstmt, con);
		}//end finally
			
		return cnt;
	}//updateStar
	
	/**
	 * 별점 삭제
	 * @param mrVO
	 * @return
	 * @throws SQLException
	 */
	public int deleteStar( MyReviewVO mrVO )throws SQLException{
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
			StringBuilder deleteStar= new StringBuilder();
			deleteStar
			.append(" delete STAR_RATE ")
			.append(" where  MEM_ID=? and RA_NUM=? ");
			
			pstmt=con.prepareStatement(deleteStar.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, mrVO.getMemId());
			pstmt.setString(2, mrVO.getRaNum());
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
			db.closeCon(null, pstmt, con);
		}//end finally
		
		return cnt;
	}//deleteStar
	
}//class
