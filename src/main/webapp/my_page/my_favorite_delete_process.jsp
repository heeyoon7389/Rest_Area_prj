<%@page import="prj2VO.LoginVO"%>
<%@page import="prj2DAO.MyFavoriteDAO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
String[] chkArr = request.getParameterValues("chkArr[]");
JSONObject jsonObj = new JSONObject();
jsonObj.put("flag", false);

int cnt=0;
	
if(chkArr != null){
	MyFavoriteDAO mfDAO = MyFavoriteDAO.getInstance();
	String memId = ((LoginVO) session.getAttribute("loginData")).getMemId();
	try{
		for(String raNum : chkArr){
			mfDAO.deleteFavorite(memId, raNum);
			++cnt;
		}//end for
		if(cnt == chkArr.length){
			jsonObj.put("flag", true);
			jsonObj.put("cnt", cnt);
		}
	}catch(SQLException e){
			e.printStackTrace();
	}//end catch
}
%>
<%= jsonObj.toJSONString() %>
