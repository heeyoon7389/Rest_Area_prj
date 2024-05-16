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
	List<MemberVariGraphVO> list = mdbDAO.selectMemberVariance(request.getParameter("start"), request.getParameter("end"), request.getParameter("interval"));
	JSONObject jsonObjTemp = null;
	for(MemberVariGraphVO mvgVO: list) {
		jsonObjTemp = new JSONObject();
		jsonObjTemp.put("memberNew", mvgVO.getMemberNew());
		jsonObjTemp.put("memberQuit", mvgVO.getMemberQuit());
		jsonObjTemp.put("col", mvgVO.getCol());
		jsonArr.add(jsonObjTemp);
	}
	jsonObj.put("result", true);
	jsonObj.put("dataSize", list.size());
	jsonObj.put("data", jsonArr);
} catch (SQLException se) {
	se.printStackTrace();
} // end catch
%>
<%=jsonObj.toJSONString()%>