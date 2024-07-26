<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.post.vo.MgtStoreRepVO"%>
<%@page import="prj2.mgt.post.dao.MgtStoreRepDAO"%>
<%@ page import="prj2.mgt.login.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 - 리뷰 블라인드 처리 (신고)"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>

<!-- 로그인 세션 없으면 리다이렉트 -->
<c:if test="${empty sessionScope.loginData2 }"><c:redirect url="http://192.168.10.214/Rest_Area_prj/mgt/login/mgt_login_frm.jsp" /></c:if>
<!-- 로그인 세션 없으면 리다이렉트 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>

<!-- 파라미터 받기 -->
<jsp:useBean id="msrVO" class="prj2.mgt.post.vo.MgtStoreRepVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="msrVO"/>

<script type="text/javascript">
	<%
	try {
		String managerId = ((ManagerVO)session.getAttribute("loginData2")).getManagerId();
		
		MgtStoreRepDAO msrDAO = MgtStoreRepDAO.getInstance();
		int cnt = msrDAO.updateStoreReq(msrVO, managerId);
		switch(cnt) {
		case 1:
 		%>
			alert('신고 처리 내역이 업데이트 되었습니다');
			location.href = "mgt_report_store_detail_frm.jsp?rnum=${param.rnum}&num=${param.num}&currentPage=${param.currentPage}&memId=${param.memId}&update=1";
		<%
		} // end if
	} catch (SQLException se) {
		se.printStackTrace();
 		%> 
		alert('문제가 발생하였습니다');
		history.back();
		<%
	} // end catch
		
 	%>
</script>
</head>
<body>

<div>

</div>

</body>
</html>