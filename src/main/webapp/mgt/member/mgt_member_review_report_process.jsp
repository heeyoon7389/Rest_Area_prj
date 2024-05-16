<%@page import="prj2.mgt.post.vo.RestAreaReviewRepVO"%>
<%@page import="prj2.mgt.post.vo.RestAreaReviewVO"%>
<%@page import="prj2.mgt.post.dao.MgtReviewReportDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
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
	MgtReviewReportDAO mrrDAO = MgtReviewReportDAO.getInstance();
	
	// 한 화면에 보여줄 게시물의 수
	int pageScale = 5;
	
	// 게시물의 시작 번호
	int currentPage = 1;
	int startNum = 1;
				
	// 끝번호
	int endNum = startNum + pageScale - 1;
	
	sVO.setField("2");
	sVO.setKeyword(memId);
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	List<RestAreaReviewRepVO> list = mrrDAO.selectPagingRevRep(sVO);
	JSONObject jsonTemp = null;
	for(RestAreaReviewRepVO vo : list) {
		jsonTemp = new JSONObject();
		jsonTemp.put("reviewMemId", vo.getReviewMemId());
		jsonTemp.put("reportMemId", vo.getReportMemId());
		jsonTemp.put("reportContent", vo.getReportContent());
		jsonTemp.put("reportInputDate", vo.getReportInputDate() != null ? sdf.format(vo.getReportInputDate()) : "");
		jsonTemp.put("blindFlag", vo.isBlindFlag() ? "블라인드" : "");
		jsonTemp.put("deleteFlag", vo.isDeleteFlag() ? "삭제" : "");
		jsonTemp.put("processDate", vo.getProcessDate() != null ? sdf.format(vo.getProcessDate()) : "");
		switch(vo.getProcessFlag()){
		case 0:
			jsonTemp.put("processFlag", "처리전");
			break;
		case 1:
			jsonTemp.put("processFlag", "처리중");
			break;
		case 2:
			jsonTemp.put("processFlag", "처리완료");
			break;
		} // end switch
		
		jsonArr.add(jsonTemp);
	} // end for 
	
	jsonObj.put("result", true);
	jsonObj.put("pageScale", pageScale);
	jsonObj.put("data", jsonArr);
} catch (SQLException se) {
	se.printStackTrace();
} // end catch
%>
<%=jsonObj.toJSONString()%>