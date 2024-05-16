<%@page import="org.json.simple.JSONObject"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="내정보 수정 전 비밀번호 확인" trimDirectiveWhitespaces="true"%>
<%
String pass = request.getParameter("password");
pass = DataEncrypt.messageDigest("MD5", pass);
String sessionPass = ((LoginVO)session.getAttribute("loginData")).getPass();
JSONObject jsonObj = new JSONObject();
jsonObj.put("flag", false);
jsonObj.put("pass",pass);
jsonObj.put("sessionPass",sessionPass);

if(pass.equals(sessionPass)){
	jsonObj.put("flag", true);
}
%>
<%= jsonObj.toJSONString() %>
