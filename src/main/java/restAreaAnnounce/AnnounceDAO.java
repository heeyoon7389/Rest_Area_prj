package restAreaAnnounce;

import java.io.BufferedReader;

import java.io.IOException;
import java.sql.Connection;


import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj2DAO.DbConnection;
import prj2VO.SearchVO;




/**
 * 공지사항
 */
public class AnnounceDAO {

	private static AnnounceDAO iDAO;
	
	private String[] columnNames;
	
	private AnnounceDAO() {
		columnNames=new String[] {"title","content","id"};
	}
	
	public static AnnounceDAO getInstance() {
		if(iDAO == null) {
			iDAO=new AnnounceDAO();
		}//end if
		return iDAO;
	}//getInstance
	

	/**
	 * 총 레코드의 수
	 * @param sVO
	 * @return
	 * @throws SQLException
	 */
	public int selectTotalCount(SearchVO sVO)throws SQLException{
		int totalCnt=0;
		
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
			StringBuilder selectCnt=new StringBuilder();
			selectCnt.append("select count(*) cnt from announce");
			
			//검색 키워드가 존재하면 키워드에 해당하는 레코드의 수만 검색
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				selectCnt.append(" where ")
				.append(columnNames[Integer.parseInt(sVO.getField())])
				.append(" like '%'||?||'%'");
			}//end if	
			
			pstmt=con.prepareStatement(selectCnt.toString());
		//5. 바인드변수에 값 설정
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				pstmt.setString(1, sVO.getKeyword());
			}//end if
			
			System.out.println( selectCnt );
			
			
		//6. 쿼리문 수행 후 결과얻기
			rs=pstmt.executeQuery();
			if(rs.next()) {
				totalCnt=rs.getInt("cnt");
			}//end if
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
			
		return totalCnt;
	}//totalCount
	
	public List<AnnounceVO> selectallAnnounce( SearchVO sVO)throws SQLException{
		List<AnnounceVO> list=new ArrayList<AnnounceVO>();
		
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
			StringBuilder selectAnnounce=new StringBuilder();
			selectAnnounce
			.append("   select announce_num, title, manager_id, input_date, announce_view, rnum   ")
			.append("   from  (select announce_num, title, manager_id, input_date, announce_view,  ")
			.append("            row_number() over(order by input_date desc) rnum     ")
			.append("            from  announce   ");
			
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				
				selectAnnounce
				.append(" where instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(",? ) > 0 ");
			
			}//end if
			
			selectAnnounce.append(" )   where rnum between ? and ?   ");
			
			pstmt=con.prepareStatement(selectAnnounce.toString());
			
		//5. 바인드변수에 값 설정
			int bindIndex=0;
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			}//end if

			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
			
		//6. 쿼리문 수행 후 결과얻기
			
			rs=pstmt.executeQuery();
			
			AnnounceVO aVO=null;
			while(rs.next()) {
				aVO=new AnnounceVO(rs.getString("announce_num"), rs.getString("manager_id"),
						rs.getString("title"),null, rs.getDate("input_date"), rs.getInt("announce_view"));
				
				list.add(aVO);
			}//end while
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectallAnnounce
	
	public AnnounceVO selectoneAnnounce( String announce_num)throws SQLException{

		AnnounceVO aVO = null;
		
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		DbConnection db=DbConnection.getInstance();
		
		try { 
		//1. JNDI사용객체 생성
		//2. DBCP에서 DataSource 얻기
		//3. Connection얻기
			con=db.getConn("jdbc/restarea");
		//4. 쿼리문 생성객체 얻기
			StringBuilder selectoneAnnounce=new StringBuilder();	
			selectoneAnnounce
			.append("   select title,manager_id,input_date,announce_view,content ")
			.append("   from   announce              ")
			.append("   where  announce_num=?         ");
			
			pstmt=con.prepareStatement(selectoneAnnounce.toString());
			
		//5. 바인드 변수에 값 설정
			pstmt.setString(1, announce_num);
		//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
				
			if(rs.next()) {
				StringBuilder content=new StringBuilder();
				String temp="";
				
				//content는 clob데이터 형이어서 별도의 Stream을 연결하여 검색한다.
				BufferedReader br=null;
				try {
					br=new BufferedReader(rs.getClob("content").getCharacterStream());
					while( (temp=br.readLine()) != null) {
						content.append(temp).append("\n");
					}//end while
					br.close();
				}catch(IOException ie) {
					ie.printStackTrace();
				}//end catch
					
				 aVO = new AnnounceVO(announce_num,		           
		                rs.getString("manager_id"),rs.getString("title"),
		                content.toString(),rs.getDate("input_date"),
		                rs.getInt("announce_view"));
		        }//end if
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		
		 return aVO;
		
	}//selectoneAnnounce
	
}//class
