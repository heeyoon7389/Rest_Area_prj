<%@page import="Store_management.StoreManagementVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Store_management.StoreManagementDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>
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
		border-bottom: 3px solid #FF00FF;
		margin-bottom: 20px;
	}
	
	#currentMenu{ /* 중앙 최상단 타이틀바 프레임(밑줄긋기용) */
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
	
 	.mainWrap{
		width: 1000px;
		height: auto;
	}
	
	.shopTable{ /* 메인 테이블 */
		width: 600px;
		border: 1px solid #B1B1B1;
		float: left;
		margin-left: 15px;
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
	
	.bottomBarWrap{ /* 아래쪽 버튼 들어가있는 div */
		width: 100%;
		height: auto;
		padding: 15px;
		padding-right: 18%;
		text-align: center;
		background-color: #E0E0E0;
		position: fixed;
		bottom: 0;
	}
	
	#addShopBtn, #addStoreBtn2{ /* 매장추가 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #3498DB;
		background-color: #3498DB;
		border-radius: 5px;
		color: white;
	}
	
	#menuManageBtn{ /* 메뉴관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #E67E22;
		background-color: #E67E22;
		border-radius: 5px;
		color: white;
	}
	
	#modifyShopBtn, #modifyShopBtn2{ /* 수정 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #C1B682;
		background-color: #C1B682;
		border-radius: 5px;
		color: white;
	}
	
	#deleteShopBtn{ /* 삭제 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #B87972;
		background-color: #B87972;
		border-radius: 5px;
		color: white;
	}
	
	#addFrame, #modifyFrame{
		width: 360px;
		height: 600px;
		background-color: #E0E0E0;
		padding: 20px;
		float: right;
	}
			
</style>
<script type="text/javascript">
	$(function(){
		
		var storeCode = "";
		var url = new URL(window.location.href);
		var areaCode = url.searchParams.get("areaCode");
		
		/* 매장추가 */
		$("#addShopBtn").click(function(){
			$("#modifyFrame").hide();
			$("#addFrame").show();
		});
		
		/* 메뉴관리 진입버튼 */
		$("#menuManageBtn").click(function(){
			
			getStoreCode();
			if(storeCode == ""){
				alert("매장을 선택해주세요.");
				return;
			}//end if
			
			location.href =
				"http://192.168.10.220/Rest_Area_prj/adminPage/menu_management/menu_management.jsp?areaCode=" + areaCode + "&storeCode=" + storeCode;
			
		});
		
		/* 매장수정 */
		$("#modifyShopBtn").click(function(){
			getStoreCode();
			if(storeCode == ""){
				alert("매장을 선택해주세요.");
				return;
			}//end if
			
			$("#addFrame").hide();
			$("#modifyFrame").show();
		});
		
		/* 삭제 */
		$("#deleteShopBtn").click(function(){
			getStoreCode();
			if(storeCode == ""){
				alert("매장을 선택해주세요.");
				return;
			}//end if
			
			if(confirm("정말 삭제하시겠습니까?")){
				alert("삭제되었습니다.")
			}//end if
		});
		
		/* 매장추가 - 추가버튼 */
		$("#addStoreBtn2").click(function(){
			var storeName = $("#addStoreName").val();
			var storeType = $("#addStoreType").val();
			var storeMemo = $("#addStoreMemo").val();
			
			if(storeName == ""){
				alert(storeName + " 이름은 필수입력사항입니다.");
				return;
			}
			
			selectStore();
		});
		
		function getStoreCode(){
			var radio = document.getElementsByName('radio');
			for(var i=0 ; i<radio.length ; i++){
				if(radio[i].checked){
					storeCode = radio[i].value;
					break;
				}//end if
			}//end for
		}//getStoreCode
		
	});//ready
	
	function selectStore(){
		
			/* StoreManagementDAO smmDAO = StoreManagementDAO.getInstance();
			try{
				if (smmDAO.selectStoreName(storeName, areaCode)){
					alert("매장 이름이 중복됩니다. 다른 이름을 사용해주세요.");
					return;
				}//end if
				alert(storeName);
			}catch(SQLException se){
				se.printStackTrace();
			}//end catch */
		
	}//selectStore
	
	
</script>
</head>
<body>
<div>

<!-- 좌측 사이드바 시작 -->
<ul>
	<br>

	<li class="topMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/dashboard/mgt_dashboard.jsp" id="unSelsected">대시보드</a></li>

  
	<br>
	<li class="topMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">휴게소 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="selected">매장 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">메뉴 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/all_amenities/all_amenities.jsp" id="unSelsected">전체 편의시설 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">휴게소 편의시설 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/gas_station_management/gas_station.html" id="unSelsected">주유소 관리</a></li>
	  
	<br>
	<li class="topMenu"><a href="#" id="unSelsected">게시글 관리</a></li>

		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/inquiry/mgt_inquiry.jsp" id="unSelsected">문의</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/report/mgt_report_review.jsp" id="unSelsected">신고</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/review/mgt_review.jsp" id="unSelsected">리뷰</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/announce/mgt_announce.jsp" id="unSelsected">공지사항</a></li>
  
	<br>
	<li class="topMenu"><a href="http://192.168.10.214/Rest_Area_prj/mgt/member/mgt_member.jsp" id="unSelsected">회원 관리</a></li>

</ul>
<!-- 좌측 사이드바 끝 -->

<!-- 중앙 메인프레임 시작 -->
<div id="mainFrame">
	<%
 	String areaCode = request.getParameter("areaCode");
	StoreManagementDAO smmDAO = StoreManagementDAO.getInstance();
	try{
		String areaName = smmDAO.selectAreaName(areaCode);
		pageContext.setAttribute("areaName", areaName);
	}catch(SQLException se){
		se.printStackTrace();
	}//end catch
	%>
	
	<!-- 최상단 메뉴이름 타이틀바 시작 -->
	<div id="currentMenu">
		<span id="currentTopMenuName">휴게소 관리 </span>
		<span id="currentBottomMenuName">
		> <c:out value="${ areaName }"/> 
		> 매장 관리 
		</span>
	</div>
	<!-- 최상단 메뉴이름 타이틀바 끝 -->
	
	<!-- 내용 시작 -->
	
	<%
	try{
		List<StoreManagementVO> list = smmDAO.selectAllStore(areaCode);
		pageContext.setAttribute("list", list);
	}catch(SQLException se){
		se.printStackTrace();
	}//end catch 
	%>
	
	
	<div class="mainWrap">
		<div class="tableFrm">
		<table class="shopTable" id="shopTable">
			<tr>
				<th style="width: 2%;"> </th>
				<th style="width: 32%;">매장명</th>
				<th style="width: 32%;">분류</th>
				<th style="width: 34%;">기타</th>
			</tr>
 			<c:forEach var="smmVO" items="${ list }" varStatus="i">
			<tr>
				<td style="text-align: center;"><input type="radio" name="radio" value="${ smmVO.storeNum }"></td>
				<td><c:out value="${ smmVO.storeName }"/></td>
				<td>
				<c:choose>
					<c:when test="${ smmVO.storeType eq 1 }">한식</c:when>
					<c:when test="${ smmVO.storeType eq 2 }">일식</c:when>
					<c:when test="${ smmVO.storeType eq 3 }">우동</c:when>
					<c:when test="${ smmVO.storeType eq 4 }">중식</c:when>
					<c:when test="${ smmVO.storeType eq 5 }">돈까스</c:when>
					<c:when test="${ smmVO.storeType eq 6 }">만두</c:when>
					<c:when test="${ smmVO.storeType eq 7 }">버거</c:when>
					<c:when test="${ smmVO.storeType eq 8 }">양식</c:when>
				</c:choose>
				</td>
				<td><c:out value="${ smmVO.storeMemo }"/></td>
			</tr>
			</c:forEach>
		</table>
		</div>
		
		<form action="store_management_proccess.jsp" name="addFrm" id="addFrm">
		<div id="addFrame" style="display: none;">
			<label id="label1"><h3><strong>매장 추가</strong></h3></label><br/><br/>
			<label>매장 이름</label><br/>
			<input type="text" id="addStoreName" name="storeName" class="addStoreName" style="width:300px; height: 40px;" placeholder="매장 이름"/><br/><br/>			<label>분류</label><br/>
			<select id="addStoreType" name="storeType" style="width: 300px; height: 40px;">
				<option value="1">한식</option>
				<option value="2">일식</option>
				<option value="3">우동</option>
				<option value="4">중식</option>
				<option value="5">돈까스</option>
				<option value="6">만두</option>
				<option value="7">버거</option>
				<option value="8">양식</option>
			</select><br/><br/>
			<label>기타</label><br/>
			<textarea id="addStoreMemo" name="storeMemo" rows="9" cols="40" placeholder="내용을 입력해주세요." style="resize: none;"></textarea><br/><br/>
			<input type="button" value="추가" id="addStoreBtn2"/>
		</div>
		</form>
		
		<form action="store_management_proccess.jsp" method="get" name="modifyFrm" id="modifyFrm">
		<div id="modifyFrame" style="display: none;">
			<label id="label1"><h3><strong>매장 수정</strong></h3></label><br/><br/>
			<label>매장 이름</label><br/>
			<input type="text" id="modifyStoreName" class="modifyStoreName" style="width:300px; height: 40px;" placeholder="매장 이름"/><br/><br/>
			<label>분류</label><br/>
			<select id="modifyStoreType" style="width: 300px; height: 40px;">
				<option value="1">한식</option>
				<option value="2">일식</option>
				<option value="3">우동</option>
				<option value="4">중식</option>
				<option value="5">돈까스</option>
				<option value="6">만두</option>
				<option value="7">버거</option>
				<option value="8">양식</option>
			</select><br/><br/>
			<label>기타</label><br/>
			<textarea id="modifyStoreMemo" rows="9" cols="40" placeholder="내용을 입력해주세요." style="resize: none;"></textarea><br/><br/>
			<input type="button" value="추가" id="modifyShopBtn2"/>
		</div>
		</form>
		
		<div class="bottomBarWrap"/>
			<input type="button" value="매장 추가" id="addShopBtn"/>　
			<input type="button" value="메뉴 관리" id="menuManageBtn"/>　
			<input type="button" value="수정" id="modifyShopBtn"/>　
			<input type="button" value="삭제" id="deleteShopBtn"/>　
		</div>
	</div>
	
	
	<!-- 내용 끝 -->
	
</div>
<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>