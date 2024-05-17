package prj2DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj2VO.MyFavoriteVO;
import prj2VO.SearchVO;

public class MyFavoriteDAO {

	private static MyFavoriteDAO mfDAO;
	
	private String[] columnNames;
	
	private MyFavoriteDAO() {
		//키워드 검색할 열이름
		columnNames = new String[] {"RA_NAME", "addr"};//휴게소 이름으로 검색?? RA_NUM, RA_NAME, addr
	}
	
	public static MyFavoriteDAO getInstance() {
		if(mfDAO == null) {
			mfDAO=new MyFavoriteDAO();
		}//end if
		return mfDAO;
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
			selectCnt.append(" select count(*) cnt from FAVORITE where mem_id=? ");
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
	public List<MyFavoriteVO> selectBoard(String id, SearchVO sVO)throws SQLException{
		List<MyFavoriteVO> list=new ArrayList<MyFavoriteVO>();
		
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
			.append("	select rnum, MEM_ID, RA_NUM, INPUT_DATE		")
			.append("	from ( select MEM_ID, RA_NUM, INPUT_DATE,	")
			.append("			row_number() over(order by INPUT_DATE desc) rnum	")
			.append("			from FAVORITE ")
			.append("			where mem_id=? and favorite_flag = '1'  ");
			
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
			MyFavoriteVO mfVO=null;
			while(rs.next()) {
				MyFavoriteVO mfVOBuilder= mfVO.builder()
						.memId(rs.getString("MEM_ID"))
						.raNum(rs.getString("RA_NUM"))
						.inputDate(rs.getDate("INPUT_DATE"))
						.build();
				list.add(mfVOBuilder);
			}//end while
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectBoard
	
	
	/**
	 * 글 삭제
	 * @param mrVO
	 * @return
	 * @throws SQLException
	 */
	public int deleteFavorite( String id, String raNum )throws SQLException{
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
			
			StringBuilder deleteFavorite= new StringBuilder();
			deleteFavorite
			.append(" update FAVORITE ")
			.append(" set  favorite_flag = '0' ")
			.append(" where MEM_ID=? and RA_NUM=? ");
			
			pstmt=con.prepareStatement(deleteFavorite.toString());
			
			//바인드 변수에 값 설정
			pstmt.setString(1, id);
			pstmt.setString(2, raNum);
			
			cnt = pstmt.executeUpdate();
		}finally {
			//7. 연결 끊기
				db.closeCon(null, pstmt, con);
		}//end finally
			
		return cnt;
	}//deleteFavorite
	
	/**
	 * 휴게소이름 select
	 * @param raNum
	 * @return
	 * @throws SQLException
	 */
	public MyFavoriteVO selectRaName(String raNum)throws SQLException{
		MyFavoriteVO mfVO=null;
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		DbConnection db = DbConnection.getInstance();
		
		try {
			con = db.getConn("jdbc/restarea");
			String selectRaName=" select RA_NUM, RA_NAME, addr from REST_AREA where RA_NUM=? ";
			
			pstmt = con.prepareStatement(selectRaName);
			
			pstmt.setString(1, raNum);
			
			rs=pstmt.executeQuery();
			if(rs.next()) {
				MyFavoriteVO mfVOBuilder= mfVO.builder()
						.raNum(rs.getString("RA_NUM"))
						.raName(rs.getString("RA_NAME"))
						.addr(rs.getString("addr"))
						.build();
				mfVO = mfVOBuilder;
			}
		}finally {
			db.closeCon(rs, pstmt, con);
		}//end finally
		return mfVO;
	}//selectRaName
	
}//class
