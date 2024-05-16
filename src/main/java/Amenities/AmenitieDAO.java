package Amenities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;

public class AmenitieDAO {
	
	private static AmenitieDAO aaDAO;
	
	private AmenitieDAO() {
	}
	
	public static AmenitieDAO getInstance() {
		if(aaDAO == null) {
			aaDAO = new AmenitieDAO();
		}//end if
		return aaDAO;
	}//getInstance
	
	
	/**
	 * 사용 가능한 모든 편의시설 조회
	 * @return
	 */
	public List<AreaAmeniteVO> selectAllAmenitie() throws SQLException {
		List<AreaAmeniteVO> list = new ArrayList<AreaAmeniteVO>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectAllAmenitie = new StringBuilder();
			selectAllAmenitie
			.append(" select ra_facil_num, ra_facil_name ")
			.append(" from restarea_facility ");
			
			pstmt = con.prepareStatement(selectAllAmenitie.toString());
			
			//5. 바인드 변수에 값 설정
			
			//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			AreaAmeniteVO aaVO = null;
			while(rs.next()) {
				aaVO = new AreaAmeniteVO(
						rs.getString("ra_facil_num"),
						rs.getString("ra_facil_name")
						);
				list.add(aaVO);
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return list;
	}//selectAllAmenitie
	
	public String selectAreaName(String areaCode) throws SQLException {
		String areaName = "";
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectAreaName = new StringBuilder();
			selectAreaName
			.append(" select ra_name ")
			.append(" from rest_area ")
			.append(" where ra_num = ? ");
			
			pstmt = con.prepareStatement(selectAreaName.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				areaName = rs.getString("ra_name");
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return areaName;
	}//selectAreaName
	
	public List<String> selectAreaAmenitie(String areaCode) throws SQLException{
		List<String> list = new ArrayList<String>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		DbConnection db = DbConnection.getInstance();
		
		try {
			//1.JNDI 사용객체 생성
			//2. DataSource 얻기
			//3. Connection 얻기
			con = db.getConn("jdbc/restarea");
			//4. 쿼리문 생성 객체 얻기
			StringBuilder selectAreaAmenitie = new StringBuilder();
			selectAreaAmenitie
			.append(" select ra_facil_num ")
			.append(" from held_ra_facility ")
			.append(" where ra_num=? ");
			
			pstmt = con.prepareStatement(selectAreaAmenitie.toString());
			
			//5. 바인드 변수에 값 설정
			pstmt.setString(1, areaCode);
			
			//6. 쿼리문 수행 후 결과 얻기
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getString("ra_facil_num"));
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return list;
	}//selectAreaAmenitie
	
}
