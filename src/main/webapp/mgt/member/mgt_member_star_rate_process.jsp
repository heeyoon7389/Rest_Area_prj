<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.manageMember.vo.StarRateMemVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2.mgt.manageMember.dao.MgtStarRateDAO"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"
	info="Insert info here"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="sVO" class="prj2.mgt.paging.vo.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>

<%
JSONObject jsonObj = new JSONObject();
JSONArray jsonArr = new JSONArray();
jsonObj.put("result", false);
try {
	String memId = request.getParameter("memId");
	MgtStarRateDAO msrDAO = MgtStarRateDAO.getInstance();
	
	// 총 레코드의 수
	int totalCount = msrDAO.selectMaxPage(memId);
	
	// 한 화면에 보여줄 게시물의 수
	int pageScale = 10;
	
	// 총 페이지수
	int totalPage = (int)Math.ceil((double)totalCount / pageScale);
	
	// 게시물의 시작 번호
	String tempPage = sVO.getCurrentPage();
	int currentPage = 1;
	if(tempPage != null) {
		try {
			currentPage = Integer.parseInt(tempPage);
		} catch (NumberFormatException nfe) {
		} // end catch
	} // end if
	int startNum = (currentPage - 1) * pageScale + 1;
				
	// 끝번호
	int endNum = startNum + pageScale - 1;
	
	sVO.setKeyword(memId);
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	
	List<StarRateMemVO> list = msrDAO.selectPagingStarRate(sVO);
	JSONObject jsonTemp = null;
	for(StarRateMemVO vo : list) {
		jsonTemp = new JSONObject();
		jsonTemp.put("raName", vo.getRaName());
		jsonTemp.put("raNum", vo.getRaNum());
		jsonTemp.put("memId", memId);
		jsonTemp.put("star", vo.getStar());
		jsonTemp.put("inputDate", vo.getInputDate());
		jsonArr.add(jsonTemp);
	} // end for 
	
	jsonObj.put("result", true);
	jsonObj.put("totalCount", totalCount);
	jsonObj.put("pageScale", pageScale);
	jsonObj.put("currentPage", currentPage);
	jsonObj.put("data", jsonArr);
} catch (SQLException se) {
	se.printStackTrace();
} // end catch
%>
<%=jsonObj.toJSONString()%>