<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.post.vo.AnnounceVO"%>
<%@page import="prj2.mgt.post.dao.MgtAnnounceDAO"%>
<%@ page import="prj2.mgt.login.vo.ManagerVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 공지사항 글 작성"%>
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
<link rel="icon" href="http://192.168.10.214/common/favicon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<link rel="stylesheet" href="http://192.168.10.214/Rest_Area_prj/CSS/etc/board.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.214/Rest_Area_prj/CSS/etc/main.css" type="text/css" media="all" />

<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	
	
	
</style>

<!-- 파라미터 받기 -->
<jsp:useBean id="aVO" class="prj2.mgt.post.vo.AnnounceVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="aVO"/>

<script type="text/javascript">
	<%
	try {
		aVO.setManagerId(((ManagerVO)session.getAttribute("loginData2")).getManagerId());
		
		MgtAnnounceDAO maDAO = MgtAnnounceDAO.getInstance();
		int cnt = maDAO.deleteAnnounce(aVO);
		switch(cnt){
		case 1:
		%>
			alert("글을 삭제하였습니다");
			location.href = "http://192.168.10.214/Rest_Area_prj/mgt/announce/mgt_announce.jsp?currentPage=${param.currentPage}";
		<%
			break;
		default:
		%>
			alert("글 삭제에 실패하였습니다");
			history.back();
		<%
		}
	} catch (SQLException se) {
		se.printStackTrace();
		%>
		alert('문제가 발생했습니다');
		location.href = "http://192.168.10.214/Rest_Area_prj/mgt/announce/mgt_announce.jsp?currentPage=${param.currentPage}";
		<%
	} // end catch
	%>
	$(function() {

	}); // $(document).ready(function() { })

</script>

</head>
<body>

<div>

</div>

</body>
</html>