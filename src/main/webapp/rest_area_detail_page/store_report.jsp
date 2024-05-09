<%@page import="storeRep.StoreRepDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link rel="icon" href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<style type="text/css">
	</style>
	<!--jQuery CDN 시작-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js">
	</script>
	<script type="text/javascript">
		$(function () {
			
		});
		
		function chkNull() {
			var content = document.getElementById("reportTextarea").value;
			if(!content.trim()) {
				alert("신고 내용을 입력해주세요.");
				return false;
			}else{
				alert("신고 접수가 완료되었습니다.");
				return true;
				window.close();
			}
			
		}
	</script>
</head>

<body>
	<div id="reportModal" class="modal-dialog">
  <div class="modal-content" style="text-align: center;">
    <span class="close" onclick="closeReviewModal()"></span>
    <h2><strong>신고 작성</strong></h2><br />
    <%
    String storeNum = request.getParameter("storeNum");
    String memId = "kimking";
    String content = request.getParameter("content");
    
    StoreRepDAO srDAO = StoreRepDAO.getInstance();
    srDAO.insertStoreRep(memId, storeNum, content);
    %>
    <form action="store_report.jsp" method="post" onsubmit="return chkNull()">
    <textarea name="content" id="reportTextarea" rows="10" cols="50"></textarea><br />
    <button type="submit" class="btn btn-primary">제출</button>
  	</form>
  </div>
</div>
</body>
</html>