<%@page import="prj2.mgt.dashboard.vo.RaViewRankVO"%>
<%@page import="prj2.mgt.dashboard.vo.MemberVariGraphVO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.util.List"%>
<%@page import="prj2.mgt.dashboard.dao.MgtDashBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="Insert info here"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>
<%
JSONObject jsonObj = new JSONObject();
JSONArray jsonArr = new JSONArray();
jsonObj.put("result", false);
jsonObj.put("dataSize", 0);
jsonObj.put("data", jsonArr);
try {
	MgtDashBoardDAO mdbDAO = MgtDashBoardDAO.getInstance();
	List<RaViewRankVO> list = mdbDAO.selectRAViewRank(Integer.parseInt(request.getParameter("selDate")));
	
	JSONObject jsonObjTemp = null;
	for(RaViewRankVO rvrVO: list) {
		jsonObjTemp = new JSONObject();
		jsonObjTemp.put("ranking", rvrVO.getRanking());
		jsonObjTemp.put("restAreaName", rvrVO.getRestAreaName());
		jsonObjTemp.put("views", rvrVO.getViews());
		jsonArr.add(jsonObjTemp);
	}
	jsonObj.put("result", true);
	jsonObj.put("dataSize", list.size());
	jsonObj.put("data", jsonArr);
} catch (SQLException | NumberFormatException e) {
	e.printStackTrace();
} // end catch
%>
<%=jsonObj.toJSONString()%>