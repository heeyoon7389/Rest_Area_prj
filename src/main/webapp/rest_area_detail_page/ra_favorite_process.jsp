<%-- <%@page import="java.sql.SQLException"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="restAreaInfo.RestAreaInfoDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String flag = 
JSONObject jsonObj = new JSONObject();

int cnt = 0;

if(params != null){
	RestAreaInfoDAO raiDAO = RestAreaInfoDAO.getInstance();
	String memberId = ((LoginVO) session.getAttribute("loginData")).getMemId();
	
	try{
		raiDAO.updateFavorite(flag, memberId, raNum);
	}catch(SQLException e){
		e.printStackTrace();
	}
}

%> --%>