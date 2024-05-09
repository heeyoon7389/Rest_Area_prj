<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="prj2DAO.LoginDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
<%
String paramId = request.getParameter("id");
String paramPass = request.getParameter("password");
//비번은 일방향 Hash로 암호화
paramPass = DataEncrypt.messageDigest("MD5", paramPass);


LoginDAO lDAO = LoginDAO.getInstance();
try{
	LoginVO lVO = lDAO.selectMembership(paramId, paramPass);
	if(lVO != null){//로그인 성공
		//복호화
		String key = "yIzLRfreATg/6wxHGia/4w==";
		DataDecrypt dd = new DataDecrypt(key);
		
		lVO.setName(dd.decryption(lVO.getName()));
		lVO.setEmail(dd.decryption(lVO.getEmail()));
		lVO.setPass(paramPass);
		
		//세션에 값 설정 memId, pass, name, nick, email
		session.setAttribute("loginData", lVO);
		%>
		alert("<%= lVO.getNick() %>님, 로그인되었습니다.");
		opener.parent.winReload();
		window.close();//로그인 창 닫기
		<%	
		} else{
		//로그인 실패
		%>	
		alert("로그인에 실패했습니다. 아이디와 비밀번호를 다시 확인해주세요."); 
		window.close();//로그인 창 닫기
		<%
		}//end else
		%>
// 		location.href="../main_page/main_page.jsp?link=logo"; 
		</script>
		<%
}catch(Exception e){
	e.printStackTrace();
}
%>