package prj2DAO;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj2VO.FAQAnnounceVO;

public class FAQAnnounceDAO {

	private static FAQAnnounceDAO faDAO;
	
	private FAQAnnounceDAO() {
	}
	
	public static FAQAnnounceDAO getInstance() {
		if(faDAO == null) {
			faDAO=new FAQAnnounceDAO();
		}//end if
		return faDAO;
	}//getInstance
	
	
	public List<FAQAnnounceVO> selectFAQ()throws SQLException{
		List<FAQAnnounceVO> list=new ArrayList<FAQAnnounceVO>();
		
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
			StringBuilder selectFAQ=new StringBuilder();
			
			selectFAQ
			.append("	select rnum, FAQ_NUM, Q	")
			.append("	from ( select FAQ_NUM, Q,	")
			.append("			row_number() over(order by FAQ_NUM) rnum	")
			.append("			from FAQ) ")
			.append("			where rnum between 1 and 10 ");
			
			
			pstmt=con.prepareStatement(selectFAQ.toString());
			
		//5. 바인드변수에 값 설정
		//6. 쿼리문 수행 후 결과얻기
			
			rs=pstmt.executeQuery();
			FAQAnnounceVO faVO=null;
			while(rs.next()) {
				FAQAnnounceVO faVOBuilder= faVO.builder()
						.faqNum(rs.getString("FAQ_NUM"))
						.qStr(rs.getString("Q"))
						.build();
				
				list.add(faVOBuilder);
			}//end while
			
		}finally {
		//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectBoard
	public List<FAQAnnounceVO> selectAn()throws SQLException{
		List<FAQAnnounceVO> list=new ArrayList<FAQAnnounceVO>();
		
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
			StringBuilder selectAn=new StringBuilder();
			
			selectAn
			.append("	select rnum, ANNOUNCE_NUM, TITLE, INPUT_DATE	")
			.append("	from ( select ANNOUNCE_NUM, TITLE, INPUT_DATE,	")
			.append("			row_number() over(order by INPUT_DATE desc) rnum	")
			.append("			from ANNOUNCE) ")
			.append("			where rnum between 1 and 10 ");
			
			pstmt=con.prepareStatement(selectAn.toString());
			
			//5. 바인드변수에 값 설정
			//6. 쿼리문 수행 후 결과얻기
			
			rs=pstmt.executeQuery();
			FAQAnnounceVO faVO=null;
			while(rs.next()) {
				FAQAnnounceVO faVOBuilder= faVO.builder()
						.title(rs.getString("TITLE"))
						.inputDate(rs.getDate("INPUT_DATE"))
						.build();
				
				list.add(faVOBuilder);
			}//end while
			
		}finally {
			//7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		}//end finally
		return list;
	}//selectBoard
	
}//class
