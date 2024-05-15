package prj2.mgt.manageMember.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import prj2.mgt.manageMember.vo.StarRateMemVO;
import prj2.mgt.paging.vo.PagingVO;
import prj2.mgt.paging.vo.SearchVO;
import restAreaDbConnection.DbConnection;

public class MgtStarRateDAO {
	private static MgtStarRateDAO srDAO;

	private MgtStarRateDAO(){
	} // MgtStarRateDAO

	public static MgtStarRateDAO getInstance(){
		if(srDAO == null) {
			srDAO = new MgtStarRateDAO();
		} // end if
		return srDAO;
	} // getInstance

	// 별점 리스트 수
	public int selectMaxPage(String memId) throws SQLException{
		int cnt = 0;

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
			selectMaxPage
			.append("	select count(*) cnt from inquiry	")	// 모든 레코드의 수
			.append("	where mem_id like '%'||?||'%'	");
			pstmt = con.prepareStatement(selectMaxPage.toString());

			// 5. 바인드 변수에 값 설정
			pstmt.setString(1, memId);

			// 6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			if(rs.next()) {
				cnt = rs.getInt("cnt");
			} // end if

		} finally {
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally		
		
		return cnt;
	} // selectMaxPage

	// 특정 회원이 별점 매긴 리스트 조회
	public List<StarRateMemVO> selectPagingStarRate(SearchVO sVO) throws SQLException{
		List<StarRateMemVO> list = new ArrayList<StarRateMemVO>();

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
			StringBuilder selectPagingStarRate = new StringBuilder();
			selectPagingStarRate
			.append("	select 	rnum, mem_id, ra_name, ra_num, star, input_date	")
			.append("	from	(	")
			.append("			select 	row_number() over(order by input_date desc) rnum, mem_id, ra.ra_name, ra.ra_num, star, input_date	")
			.append("			from	star_rate sr,	")
			.append("					(select ra_num, ra_name from rest_area) ra	")
			.append("			where	sr.ra_num = ra.ra_num and mem_id=?	")
			.append("			)	")
			.append("	where	rnum between ? and ?	");
			pstmt = con.prepareStatement(selectPagingStarRate.toString());
			
			// 바인드 변수에 값 설정
			pstmt.setString(1, sVO.getKeyword());
			pstmt.setInt(2, sVO.getStartNum());
			pstmt.setInt(3, sVO.getEndNum());
			
			// 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			StarRateMemVO srmVO = null;
			while(rs.next()) {
				srmVO = new StarRateMemVO(rs.getString("ra_name"), rs.getString("ra_num"), rs.getString("mem_id"), rs.getInt("star"), rs.getDate("input_date"));
				list.add(srmVO);
			} // end while
		} finally { 
			// 7. 연결 끊기
			db.closeCon(rs, pstmt, con);
		} // end finally 
			
		return list;
	} // selectPagingStarRate
} // class
