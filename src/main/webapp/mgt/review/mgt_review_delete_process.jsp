<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.post.vo.RestAreaReviewVO"%>
<%@page import="prj2.mgt.post.dao.MgtReviewDAO"%>
<%@ page import="prj2.mgt.login.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 리뷰 삭제"%>
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
<jsp:useBean id="rarVO" class="prj2.mgt.post.vo.RestAreaReviewVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="rarVO"/>

<script type="text/javascript">
	<%
	try {
		String managerId = ((ManagerVO)session.getAttribute("loginData2")).getManagerId();
		
		MgtReviewDAO mrDAO = MgtReviewDAO.getInstance();
		int cnt = mrDAO.deleteReview(rarVO.getReviewNum(), managerId);
		switch (cnt) {
		case 1:
 		%>
			alert('리뷰가 삭제되었습니다');
			window.opener.location.reload();
			window.close();
		<%
		} // end case
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