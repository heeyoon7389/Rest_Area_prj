<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="prj2.mgt.login.vo.ManagerVO"%>
<%@page import="prj2.mgt.login.dao.MgtLoginDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="아이디와 비번을 받아서 로그인 처리"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="lVO" class="prj2.mgt.login.vo.ManagerVO" scope="page"/>
<jsp:setProperty name="lVO" property="*"/>
<%
// 비번은 일방향 Hash로 암호화
lVO.setPass(DataEncrypt.messageDigest("MD5", lVO.getPass()));

pageContext.setAttribute("msg", "로그인 실패 아이디나 비번 확인");
pageContext.setAttribute("url", "mgt_login_frm.jsp");

MgtLoginDAO mDAO = MgtLoginDAO.getInstance();
try {
	ManagerVO mVO = mDAO.selectOneMgtLogin(lVO.getManagerId(), lVO.getPass());
	
	if(mVO != null) { // 로그인에 성공
		String key = "yIzLRfreATg/6wxHGia/4w==";
		DataDecrypt dd = new DataDecrypt(key);
		
		mVO.setManagerId(lVO.getManagerId());
		mVO.setName(dd.decryption(mVO.getName()));

		// session에 값 설정
		session.setAttribute("loginData2", mVO);
		pageContext.setAttribute("msg", "로그인 성공");
		pageContext.setAttribute("url", "http://192.168.10.214/Rest_Area_prj/mgt/dashboard/mgt_dashboard.jsp");
	} // end if
} catch (Exception e) {
	pageContext.setAttribute("msg", "문제 발생 잠시 후 다시 시도해주세요");
	pageContext.setAttribute("url", "http://192.168.10.214/Rest_Area_prj/mgt/login/login_frm.jsp");
	
	e.printStackTrace();
} // end catch
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>
<link rel="icon" href="http://192.168.10.214/common/favicon.ico"/>
<script type="text/javascript">
	alert("${pageScope.msg}");
	location.href="${pageScope.url}"
</script>

</head>
<body>

<div>

</div>

</body>
</html>