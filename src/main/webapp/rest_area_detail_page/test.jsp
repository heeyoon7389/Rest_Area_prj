<%@page import="java.sql.Connection"%>
<%@page import="restAreaDbConnection.DbConnection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%-- <%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
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
	</script>
</head>

<body>
	<div id = "map" style="width:500px; height: 500px;">
		<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16ee3555fcc7fa1f7c8e630d95b34e4f">
						</script>
						<script type="text/javascript">
						var container = document.getElementById('map'),
						option = {
								center: new kakao.maps.LatLng(37.459939, 127.042514),
								level : 3
						};
						
						var map = new kakao.maps.Map(container, option);
						</script>
				
	</div>
</body>

</html>