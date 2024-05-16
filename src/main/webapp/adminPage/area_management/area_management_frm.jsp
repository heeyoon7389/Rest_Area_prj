<%@page import="java.sql.SQLException"%>
<%@page import="AreaManagement.SelectRestAreaVO"%>
<%@page import="java.util.List"%>
<%@page import="AreaManagement.SelectRestAreaDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="휴게소 관리"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 관리</title>
<!-- 파비콘 시작 -->
<!-- <link rel="icon" href="http://192.168.10.220/jsp_prj/common/favicon.ico"/> -->
<!-- 파비콘 끝 -->

<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	ul { /* 좌측 사이드바 */
	  list-style-type: none;
	  padding: 0px;
	  margin: 0px;
	  width: 225px;
	  height: 100%;
	  background: #101924;
	  overflow: auto;
	  position: fixed;
	}

	#unSelsected { /* 사이드바 글자 */
	  text-decoration: none;
	  padding: 5px;
	  display: block;
	  color: #66799B;
	  font-weight: bold;
	}
	
	#unSelsected:hover { /* 커서 올렸을때 색 */
	  color: #7F8DFF;
	}
	
	#selected{
  	  text-decoration: none;
	  padding: 5px;
	  display: block;
	  color: #7F8DFF;
	  font-weight: bold;
	}
	
	#mainFrame { /* 중앙 메인화면 프레임 */
	  margin-left: 225px;
	  padding-top: 5px;
	  height: 100%;
	  background-color: #FFFFFF;
	}
	
	.topMenu{ /* 사이드바 대분류메뉴 글씨 */
		font-size: 30px;
		padding-left: 10px;
	}
	
	.bottomMenu{ /* 사이드바 소분류메뉴 글씨 */
		font-size: 18px;
		padding-left: 25px;
	}
	
	#frmBackground{ /* 중앙 최상단 타이틀바 프레임(밑줄긋기용) */
		border-bottom: 3px solid #CECECE;
		margin-bottom: 20px;
	}
	
	#currentTopMenuName{ /* 중앙 최상단 타이틀바 > 대분류 글씨 */
		font-size: 40px;
		font-weight: bold;
		padding-left: 15px;
	}
	
	#currentBottomMenuName{ /* 중앙 최상단 타이틀바 > 소분류 글씨 */
		font-size: 30px;
		font-weight: bold;
	}
	
	/* ~~~~~~~~~~~ 여기부터 내용부분 css ~~~~~~~~~~~ */
	
	.tableFrm{ /* 테이블 div */
		margin-left: 1%;
		margin-right: 1%;
	}
	
	.Frame1{ /* 위쪽 노선명~ 들어가있는 div */
		width: 100%;
		height: auto;
		padding: 15px;
		text-align: center;
		font-size: 15px;
		font-weight: bold;
		background-color: #E0E0E0;
	}
	
	.Frame2{ /* 아래쪽 버튼 들어가있는 div */
		width: 100%;
		height: auto;
		padding: 15px;
		padding-right: 18%;
		text-align: center;
		background-color: #E0E0E0;
		position: fixed;
		bottom: 0;
	}
	
	.restAreaTable{ /* 메인 테이블 */
		width: 100%;
		margin-top: 15px;
		margin-bottom : 80px;
		border: 1px solid #B1B1B1;
	}
	
	th{
		height: 40px;
		border: 1px solid #B1B1B1;
		background-color: #D0D0D0;
		text-align: center;
	}
	
	tr, td{
		height: 35px;
		border: 1px solid #B1B1B1;
	}
	
	.menuBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #779BB2;
		background-color: #779BB2;
		border-radius: 5px;
		color: white;
	}
	
	.areaAmenitieBtn{ /* 휴게소 편의시설 관리 버튼 */
		width: 170px;
		height: 39px;
		border: 1px solid #A87873;
		background-color: #A87873;
		border-radius: 5px;
		color: white;
	}
	
	.allAmenitieBtn{
		width: 120px;
		height: 39px;
		border: 1px solid #C3AFAD;
		background-color: #C3AFAD;
		border-radius: 5px;
		color: white;
	}
	
	.petrolBtn{
		width: 120px;
		height: 39px;
		border: 1px solid #9896B8;
		background-color: #9896B8;
		border-radius: 5px;
		color: white;
	}
	
	.amenitieSelectBtn{
		width: 200px;
		height: 39px;
		border: 1px solid #F3F3F3;
		background-color: #F3F3F3;
		border-radius: 5px;
		color: #979797;
	}
	
</style>
<script type="text/javascript">
	
	var areaCode = "";
	
	$(function(){
		
		$("#btnSubmit").click(function() {
			select();
		});//click
		
		$("#areaName").keydown(function( evt ){
			if( evt.which == 13 ){
				select();
			}//end if
		});//keydown
		
		/* 매장/메뉴관리 */
		$("#menuBtn").click(function(){
 			getAreaCode();
			if(areaCode == ""){
				alert("휴게소를 선택해주세요.");
				return;
			}//end if
			
			location.href =
				"http://192.168.10.220/Rest_Area_prj/adminPage/store_management/store_management.jsp?areaCode=" + areaCode;
		});//click
		
		/* 휴게소 편의시설 관리 */
		$("#areaAmenitieBtn").click(function(){
			getAreaCode();
			if(areaCode == ""){
				alert("휴게소를 선택해주세요.");
				return;
			}//end if
			
			window.open("rest_area_amenitie_dup.jsp?areaCode="+areaCode, "amenitie", "width=501, height=701, top"
					+(window.screenY+100)+", left="+(window.screenX+100));
			
		});//keydown
		
		/* 전체 편의시설 */
		$("#allAmenitieBtn").click(function(){
			location.href =
				"http://192.168.10.220/Rest_Area_prj/adminPage/all_amenities/all_amenities.jsp";
		});//keydown
		
		/* 주유소 관리 */
		$("#petrolBtn").click(function(){
			location.href =
				"http://192.168.10.220/Rest_Area_prj/adminPage/gas_station_management/gas_station.html";
		});//keydown
		
		
	});//ready
	
	function select(){
		$("#frmSelect").submit();
	}//select
	
	function getAreaCode(){
		var radio = document.getElementsByName('radio');
		for(var i=0 ; i<radio.length ; i++){
			if(radio[i].checked){
				areaCode = radio[i].value;
				break;
			}//end if
		}//end for
	}//getAreaCode

	
</script>
</head>
<body>
<div>

<!-- 좌측 사이드바 시작 -->
<ul>
	</br>
	<li class="topMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/dashboard/mgt_dashboard.jsp" id="unSelsected">대시보드</a></li>
  
	</br>
	<li class="topMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="selected">휴게소 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">매장 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">메뉴 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/all_amenities/all_amenities.jsp" id="unSelsected">전체 편의시설 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">휴게소 편의시설 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/gas_station_management/gas_station.html" id="unSelsected">주유소 관리</a></li>
	  
	</br>
	<li class="topMenu"><a href="#" id="unSelsected">게시글 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/inquiry/mgt_inquiry.jsp" id="unSelsected">문의</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/report/mgt_report_review.jsp" id="unSelsected">신고</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/review/mgt_review.jsp" id="unSelsected">리뷰</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/announce/mgt_announce.jsp" id="unSelsected">공지사항</a></li>
  
	</br>
	<li class="topMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/member/mgt_member.jsp" id="unSelsected">회원 관리</a></li>
</ul>
<!-- 좌측 사이드바 끝 -->

<!-- 중앙 메인프레임 시작 -->
<div id="mainFrame">
	<!-- 최상단 메뉴이름 타이틀바 시작 -->
	<div id="frmBackground">
		<span id="currentTopMenuName">휴게소 관리</span>
		<span id="currentBottomMenuName"> > 휴게소 선택</span>
	</div>
	<!-- 최상단 메뉴이름 타이틀바 끝 -->
	
	<!-- 내용 시작 -->
	<form class="Frame1" action="area_management_frm.jsp" id="frmSelect">
		<span>노선명 : </span>
		<select name="routeName" id="routeName" style="width: 200px; height: 40px">
			<option value=""> -- 전체 -- </option>
			<option value="1"${ param.routeName eq 1?" selected='selected'":"" }>경부선</option>
			<option value="100"${ param.routeName eq 100?" selected='selected'":"" }>경인선</option>
			<option value="101"${ param.routeName eq 101?" selected='selected'":"" }>고창담양선</option>
			<option value="3"${ param.routeName eq 3?" selected='selected'":"" }>광주대구선</option>
			<option value="4"${ param.routeName eq 4?" selected='selected'":"" }>무안광주선</option>
			<option value="102"${ param.routeName eq 102?" selected='selected'":"" }>광주외곽순환선</option>
			<option value="2"${ param.routeName eq 2?" selected='selected'":"" }>남해선</option>
			<option value="103"${ param.routeName eq 103?" selected='selected'":"" }>남해제1지선</option>
			<option value="33"${ param.routeName eq 33?" selected='selected'":"" }>남해제2지선</option>
			<option value="17"${ param.routeName eq 17?" selected='selected'":"" }>당진영덕선</option>
			<option value="104"${ param.routeName eq 104?" selected='selected'":"" }>대구외곽순환선</option>
			<option value="105"${ param.routeName eq 105?" selected='selected'":"" }>대전남부순환선</option>
			<option value="29"${ param.routeName eq 29?" selected='selected'":"" }>동해선</option>
			<option value="106"${ param.routeName eq 106?" selected='selected'":"" }>밀양울산선</option>
			<option value="107"${ param.routeName eq 107?" selected='selected'":"" }>부산외곽순환선</option>
			<option value="108"${ param.routeName eq 108?" selected='selected'":"" }>새만금포항선</option>
			<option value="109"${ param.routeName eq 109?" selected='selected'":"" }>새만금포항선의 지선</option>
			<option value="28"${ param.routeName eq 28?" selected='selected'":"" }>서울양양선</option>
			<option value="38"${ param.routeName eq 38?" selected='selected'":"" }>서천공주선</option>
			<option value="6"${ param.routeName eq 6?" selected='selected'":"" }>서해안선</option>
			<option value="110"${ param.routeName eq 110?" selected='selected'":"" }>수도권제1순환선</option>
			<option value="15"${ param.routeName eq 15?" selected='selected'":"" }>순천완주선</option>
			<option value="25"${ param.routeName eq 25?" selected='selected'":"" }>영동선</option>
			<option value="111"${ param.routeName eq 111?" selected='selected'":"" }>울산선</option>
			<option value="112"${ param.routeName eq 112?" selected='selected'":"" }>제2경인선</option>
			<option value="113"${ param.routeName eq 113?" selected='selected'":"" }>제2중부선</option>
			<option value="24"${ param.routeName eq 24?" selected='selected'":"" }>중부내륙선</option>
			<option value="47"${ param.routeName eq 47?" selected='selected'":"" }>중부내력선의 지선</option>
			<option value="27"${ param.routeName eq 27?" selected='selected'":"" }>중앙선</option>
			<option value="114"${ param.routeName eq 114?" selected='selected'":"" }>중앙선의 지선</option>
			<option value="21"${ param.routeName eq 21?" selected='selected'":"" }>통영대전선</option>
			<option value="20"${ param.routeName eq 20?" selected='selected'":"" }>중부선</option>
			<option value="23"${ param.routeName eq 23?" selected='selected'":"" }>평택제천선</option>
			<option value="13"${ param.routeName eq 13?" selected='selected'":"" }>호남선</option>
			<option value="42"${ param.routeName eq 42?" selected='selected'":"" }>호남선의 지선</option>
		</select>
		
		<span>　　　휴게소명 : </span>
		<input type="text" name="areaName" id="areaName" style="width: 300px; height: 38px">　
		<input type="button" value="　검색　" class="btn btn-primary" id="btnSubmit"/>
	</form>
	
	<%
	request.setCharacterEncoding("UTF-8");
	
	String routeName = request.getParameter("routeName");
	String areaName = request.getParameter("areaName");
	
	if(routeName == null){
		routeName = "";
	}
	if(areaName == null){
		areaName = "";
	}
	
	SelectRestAreaDAO sraDAO = SelectRestAreaDAO.getInstance();
	try{
		List<SelectRestAreaVO> list = sraDAO.selectArea(routeName, areaName);
		pageContext.setAttribute("list", list);
	}catch(SQLException se){
		se.printStackTrace();
	}//end catch
	%>
	
	<div class="tableFrm">
		<table class="restAreaTable" id="restAreaTable">
			<thead>
			<tr>
				<th style="width: 2%;"> </th>
				<th style="width: 25%;">휴게소명</th>
				<th style="width: 33%;">주소</th>
				<th style="width: 12%;">전화번호</th>
				<th style="width: 28%;">편의시설</th>
			</tr>
			</thead>
		 	<tbody>
			<c:forEach var="sraVO" items="${ list }" varStatus="i">
			<tr>
				<td style="text-align: center;"><input type="radio" name="radio" value="${ sraVO.areaCode }"></td>
				<td><c:out value="${ sraVO.areaName }"/></td>
				<td><c:out value="${ sraVO.addr }"/></td>
				<td><c:out value="${ sraVO.callNumber }"/></td>
				<td><c:out value="${ sraVO.amenites }"/></td>
			</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="Frame2">
		<input type="button" value="매장/메뉴 관리" class="menuBtn" id="menuBtn"/>　
		<input type="button" value="휴게소 편의시설 관리" class="areaAmenitieBtn" id="areaAmenitieBtn"/>
		<input type="button" value="전체 편의시설" class="allAmenitieBtn" id="allAmenitieBtn"/>　
		<input type="button" value="주유소 관리" class="petrolBtn" id="petrolBtn"/>
	</div>
	
	<!-- 내용 끝 -->
</div>
<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>