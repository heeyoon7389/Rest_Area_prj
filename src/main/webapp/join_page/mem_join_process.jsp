<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="prj2DAO.JoinMemDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 폼에서 입력된 값을 받는 JSP"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mjVO" class="prj2VO.MemJoinVO" scope="page"/>
<jsp:setProperty property="*" name="mjVO"/><!-- 모든 VO 값 다 들어옴 -->
<script type="text/javascript">
<%
//입력값에 대한 전처리
mjVO.setEmail(mjVO.getEmail1()+"@"+mjVO.getEmail2());//이메일 합치기

//일방향 Hash(비번)
mjVO.setPassword(DataEncrypt.messageDigest("MD5", mjVO.getPassword()));
//복호화가 가능한 암호화(이름, 이메일)
String key="yIzLRfreATg/6wxHGia/4w==";

DataEncrypt de = new DataEncrypt(key);
mjVO.setName(de.encryption(mjVO.getName()));
mjVO.setEmail(de.encryption(mjVO.getEmail()));

//db Table 추가
JoinMemDAO jmDAO = JoinMemDAO.getInstance();

try{
	//웹의 비연결성으로 동시에 같은 값을 사용하는 경우에
	if(jmDAO.selectDupId(mjVO.getId()) == true){//조회를 하여 같은 값이 있는지 판단하고 있으면
	%>
	alert("입력하신 아이디는 이미 사용중입니다.\n 다른 아이디로 재가입해주세요");
	<%	
	}else{//그렇지 않다면 정상작업 진행
		jmDAO.insertMemberShip(mjVO);//웹의 비연결성에 대한 특성
		%>
		alert("회원가입되었습니다.");
		location.href="../main_page/main_page.jsp";
		</script>
		<%
	}//end else
}catch(SQLException e){
	e.printStackTrace();
}
%>
