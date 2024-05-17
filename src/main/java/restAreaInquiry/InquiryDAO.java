package restAreaInquiry;

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
 * 문의
 */
public class InquiryDAO {

	private static InquiryDAO iDAO;
	
	private String[] columnNames;
	
	private InquiryDAO() {
		columnNames=new String[] {"title","content","id"};
	}
	
	public static InquiryDAO getInstance() {
		if(iDAO == null) {
			iDAO=new InquiryDAO();
		}//end if
		return iDAO;
	}//getInstance
	
	
	public void insertInquiry( InquirydetailVO idVO) throws SQLException{
		
		Connection con=null;
		PreparedStatement pstmt=null;
		
		DbConnection db=DbConnection.getInstance();
		
		try {
		//1. JNDI사용객체 생성
		//2. DBCP에서 DataSource 얻기
		//3. DataSource에서 Connection얻기
			con=db.getConn("jdbc/restarea");
		//4. 쿼리문 생성객체 얻기
		
			
			String insertInquiry=
			" insert into inquiry(mem_id, title, content, INQUIRY_NUM) values(?,?,?,SEQ_INQUIRY.NEXTVAL)";
	
			pstmt=con.prepareStatement(insertInquiry);
			
		//5. 바인드변수에 값 설정
			pstmt.setString(1, idVO.getMemid());
			pstmt.setString(2, idVO.getTitle());
			pstmt.setString(3, idVO.getContent());
		
			
		//6. 쿼리문 수행 후 결과 얻기
			pstmt.executeUpdate();
			
		}finally {
		//7. 연결끊기
			db.closeCon(null, pstmt, con);
		}//end finally
		
	}//insertInquiry
	
	
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
			selectCnt.append("select count(*) cnt from inquiry");
			
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
	
	
	public List<InquiryVO> selectallInquiry( SearchVO sVO)throws SQLException{
		List<InquiryVO> list=new ArrayList<InquiryVO>();
		
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
			StringBuilder selectInquiry=new StringBuilder();
			selectInquiry
			.append("   select INQUIRY_NUM, TITLE, MEM_ID, INPUT_DATE, rnum   ")
			.append("   from  (select INQUIRY_NUM, TITLE, MEM_ID, INPUT_DATE,   ")
			.append("            row_number() over(order by input_date desc) rnum     ")
			.append("            from  inquiry  ");
			
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
			
				selectInquiry
				.append(" where instr(").append(columnNames[Integer.parseInt(sVO.getField())])
				.append(",? ) > 0 ");
			
			}//end if
			
			selectInquiry.append(" )   where rnum between ? and ?   ");
			
			pstmt=con.prepareStatement(selectInquiry.toString());
			
		
		//5. 바인드변수에 값 설정
			int bindIndex=0;
			if( sVO.getKeyword() != null && !"".equals(sVO.getKeyword() )) {
				pstmt.setString(++bindIndex, sVO.getKeyword());
			}//end if

			pstmt.setInt(++bindIndex, sVO.getStartNum());
			pstmt.setInt(++bindIndex, sVO.getEndNum());
		//6. 쿼리문 수행 후 결과얻기
			
			rs=pstmt.executeQuery();
			
			InquiryVO iVO=null;
			while(rs.next()) {
				iVO=new InquiryVO(rs.getString("inquiry_num"),
						rs.getString("mem_id"), rs.getString("title"), null,
						rs.getDate("input_date"));
				
				list.add(iVO);
			}//end while
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectallInquiry
	
	
	public InquirydetailVO selectoneInquiry( String inquiry_num)throws SQLException{

		InquirydetailVO idVO = null;
		
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
			StringBuilder selectoneInquiry=new StringBuilder();	
			selectoneInquiry
			.append("   select title,mem_id,input_date,content,answer_date,answer_contents ")
			.append("   from   inquiry              ")
			.append("   where  inquiry_num=?         ");
			
			pstmt=con.prepareStatement(selectoneInquiry.toString());
			
		//5. 바인드 변수에 값 설정
			pstmt.setString(1, inquiry_num);
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
					
				idVO = new InquirydetailVO(inquiry_num,		           
						rs.getString("mem_id"),rs.getString("title"),
						content.toString(),rs.getDate("input_date"),
						false,rs.getString("answer_contents"),rs.getDate("answer_date"),false);
		        }//end if
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		
		 return idVO;
		
	}//selectoneInquiry
	
}//class
