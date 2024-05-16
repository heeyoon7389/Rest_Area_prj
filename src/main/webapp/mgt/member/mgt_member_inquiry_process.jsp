<%@page import="prj2.mgt.post.vo.InquiryVO"%>
<%@page import="prj2.mgt.post.dao.MgtInquiryDAO"%>
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
	MgtInquiryDAO miDAO = MgtInquiryDAO.getInstance();
	
	// 한 화면에 보여줄 게시물의 수
	int pageScale = 5;
	
	// 게시물의 시작 번호
	int currentPage = 1;
	int startNum = 1;
				
	// 끝번호
	int endNum = startNum + pageScale - 1;
	
	sVO.setField("3");
	sVO.setKeyword(memId);
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	
	List<InquiryVO> list = miDAO.selectPagingInquiry(sVO);
	JSONObject jsonTemp = null;
	for(InquiryVO vo : list) {
		jsonTemp = new JSONObject();
		jsonTemp.put("memId", vo.getMemId());
		jsonTemp.put("title", vo.getTitle());
		jsonTemp.put("inputDate", vo.getInputDate() != null ? sdf.format(vo.getInputDate()) : "");
		jsonTemp.put("answerFlag", vo.isAnswerFlag() ? "답변 완료" : "답변 전");
		jsonTemp.put("secretFlag", vo.isSecretFlag() ? " 🔒" : "");
		
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