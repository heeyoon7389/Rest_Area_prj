<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.io.FileReader"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	//JSON 파일 경로
	String gsJsonFilePath = request.getRealPath("/WEB-INF/gas_station.json");
		JSONParser parser = new JSONParser();
	try{
		//1. JSON 파일 읽기
		Object obj = parser.parse(new FileReader(gsJsonFilePath));
		JSONObject jsonObject = (JSONObject) obj;
		
		JSONArray stations = (JSONArray) jsonObject.get("list");
		String jsonData = stations.toJSONString();
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(jsonData);
		
	}catch(Exception e){
		e.printStackTrace();
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
		response.getWriter().write("JSON 파일 읽기에 실패했습니다.");
	}

%>