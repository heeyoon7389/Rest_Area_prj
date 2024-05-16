package Admin_main;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import restAreaDbConnection.DbConnection;



public class SelectRestAreaDAO {
	private static SelectRestAreaDAO sraDAO;
	
	private SelectRestAreaDAO() {
	}
	
	public static SelectRestAreaDAO getInstance() {
		if(sraDAO == null) {
			sraDAO = new SelectRestAreaDAO();
		}//end if
		return sraDAO;
	}//getInstance
	
	public List<SelectRestAreaVO> selectArea(String routeName, String areaName) throws SQLException {
		List<SelectRestAreaVO> list = new ArrayList<SelectRestAreaVO>();
		
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
			StringBuilder selectArea = new StringBuilder();
			selectArea
			.append(" select	ra.ra_name, ra.ra_num, ra.addr, ra.tel, ")
			.append(" (select	substr( xmlagg(xmlelement(a, ', ', rf.ra_facil_name )).extract('//text()'),3) ra_facil_num ")
			.append(" from		restarea_facility rf, held_ra_facility hf ")
			.append(" where		rf.ra_facil_num=hf.ra_facil_num and hf.ra_num=ra.ra_num ")
			.append(" group by hf.ra_num) ra_facil_name ")
			.append(" from    rest_area ra ");
			
			if(!"".equals(routeName) && !"".equals(areaName)) {
				selectArea
				.append(" where   ra.route_id=? and ra.ra_name like '%'||?||'%' ");
			}else if(!"".equals(routeName)) {
				selectArea
				.append(" where   ra.route_id=? ");
			}else if(!"".equals(areaName)){
				selectArea
				.append(" where   ra.ra_name like '%'||?||'%' ");
			}//end if
			
			pstmt = con.prepareStatement(selectArea.toString());
			
			//5. 바인드 변수에 값 설정
			if(!"".equals(routeName) && !"".equals(areaName)) {
				pstmt.setString(1, routeName);
				pstmt.setString(2, areaName);
			}else if(!"".equals(routeName)) {
				pstmt.setString(1, routeName);
			}else if(!"".equals(areaName)){
				pstmt.setString(1, areaName);
			}//end if
			
			//6. 쿼리문 수행 후 결과 얻기
			rs=pstmt.executeQuery();
			
			SelectRestAreaVO sraVO = new SelectRestAreaVO();
			while(rs.next()) {
				sraVO = new SelectRestAreaVO(
						rs.getString("ra_name"),
						rs.getString("ra_num"),
						rs.getString("addr"),
						rs.getString("tel"),
						rs.getString("ra_facil_name")
						);
				list.add(sraVO);
			}//end if
		}finally {
			db.closeCon(rs, pstmt, con);
		//7. 연결 끊기
		}//end finally
		
		return list;
	}//selectArea
	
}//class
