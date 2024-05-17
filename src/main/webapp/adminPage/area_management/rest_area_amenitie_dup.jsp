<%@page import="Amenities.AreaAmeniteVO"%>
<%@page import="java.util.List"%>
<%@page import="Amenities.AmenitieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>
<link rel="icon" href="http://192.168.10.220/jsp_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.220/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.220/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	#wrap{
		width: 500px;
		height: 700px;
		margin: 0px auto;
		background: #B3B3B3;
		position: relative;
	}
	
	#tableWrap{
		width: 450px;
		height: auto;
		max-height: 600px;
		overflow: auto;
		padding: 15px;
		background: #FFFFFF;
		margin-top: 25px;
		margin-left: 25px;
		box-shadow: 10px 10px 1px rgb(90,90,90);
	}
	
	#amenitie_management{
		width: 500px;
		height: 50px;
		padding: 10px;
		background-color: #E0E0E0;
	}
	
	#okBtn{ /* 확인버튼 */
		width: 100px;
		height: 39px;
		border: 1px solid #B3B3B3;
		background-color: #B3B3B3;
		border-radius: 5px;
		color: white;
	}
	
	#btnWrap{
		text-align: center;
	}
	
	#amenitie_table{ /* 메인 테이블 */
		width: 400px;
		border: 1px solid #B1B1B1;
		text-align: center;
	}
		
	th{
		height: 40px;
		border: 1px solid #B1B1B1;
		background-color: #D0D0D0;
	}
	
	tr, td{
		height: 35px;
		border: 1px solid #B1B1B1;
	}
	
</style>


<%
	String areaCode = request.getParameter("areaCode");
	
	AmenitieDAO aaDAO = AmenitieDAO.getInstance();
	List<String> amenitieList = aaDAO.selectAreaAmenitie(areaCode); //휴게소 보유 휴게시설
	pageContext.setAttribute("amenitieList", amenitieList);

	List<AreaAmeniteVO> list = aaDAO.selectAllAmenitie(); //사용 가능한 전체 편의시설
	pageContext.setAttribute("list", list);
	
	String areaName = aaDAO.selectAreaName(areaCode); //휴게소 이름
	
%>

<script type="text/javascript">
	$(function(){
		
		$("#okBtn").click(function(){
			
			
			
			
			self.close();

		});
		
	});//ready
</script>
</head>
<body>


<div id="wrap">
	<div id="amenitie_management"><h3><strong><%= areaName %></strong></h3></div>
	<div id="tableWrap">
	
	<table id="amenitie_table">
		<tr>
			<th>편의시설명</th>
			<th>보유 유무</th>
		</tr>
		<c:forEach var="aaVO" items="${ list }" varStatus="i">
		<tr>
			<td><c:out value="${ aaVO.amenitieName }"/></td>
			<td>
			<input type="checkbox" 
			<c:forEach var="amenitie" items="${ amenitieList }" varStatus="i">
			${ amenitie eq aaVO.amenitieCode ? " checked='checked'":""}
			</c:forEach>
			id="${ aaVO.amenitieCode }" value="${ aaVO.amenitieCode }">
			</td>
		</tr>
		</c:forEach>
	</table></br>
	<div id="btnWrap">
	<input type="button" value="확인" id="okBtn"/>
	</div>
	</div>
</div>
</body>
</html>

