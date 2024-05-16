<%@page import="MenuManagement.MenuVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="MenuManagement.MenuDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>메뉴 관리</title>
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
	
	/* -------------------------------------------------------- */
	
	.mainWrap{
		width: 1000px;
		height: auto;
		margin-left: 15px;
	}
	
	.menuTable{ /* 메인 테이블 */
		width: 900px;
		border: 1px solid #B1B1B1;
		float: left;
		margin-left: 20px; 
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
	
	.addMenuBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #3498DB;
		background-color: #3498DB;
		border-radius: 5px;
		color: white;
	}
	
	.detailViewBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #5E5E5E;
		background-color: #5E5E5E;
		border-radius: 5px;
		color: white;
	}
	
	.modifyMenuBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #C1B682;
		background-color: #C1B682;
		border-radius: 5px;
		color: white;
	}
	
	.deleteMenuBtn{ /* 메뉴 관리 버튼 */
		width: 120px;
		height: 39px;
		border: 1px solid #B97972;
		background-color: #B97972;
		border-radius: 5px;
		color: white;
	}
	
	
</style>
<script type="text/javascript">
	$(function(){
		$(function(){
			/* 메뉴추가 */
			$("#addMenuBtn").click(function(){
				addMenu();
			});
			
			/* 상세조회 */
			$("#detailViewBtn").click(function(){
				selectMenu();
			});
			
			/* 수정 */
			$("#modifyMenuBtn").click(function(){
				modifyMenu();
			});
			
			/* 삭제 */
			$("#deleteMenuBtn").click(function(){
				if(confirm("정말 삭제하시겠습니까?")){
					alert("삭제되었습니다.")
				}//end if
			});
			
		});//ready
		
		function addMenu(){
			window.open("menu_add_dup.jsp", addMenu, "width=451, height=701, top="
					+(window.screenY+100)+", left="+(window.screenX+100));
		}//addMenu
		
		function selectMenu(){
			window.open("menu_detail_veiw_dup.jsp", selectMenu, "width=451, height=701, top="
					+(window.screenY+100)+", left="+(window.screenX+100));
		}//selectMenu
		
		function modifyMenu(){
			window.open("menu_modify_dup.jsp", modifyMenu, "width=451, height=701, top="
					+(window.screenY+100)+", left="+(window.screenX+100));
		}//updateMenu
		
		
		
	});//ready
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
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">매장 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="selected">메뉴 관리</a></li>
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
	String storeCode = request.getParameter("storeCode");
	MenuDAO mnDAO = MenuDAO.getInstance();
	try{
		String areaName = mnDAO.selectAreaName(areaCode);
		String storeName = mnDAO.selectStoreName(areaCode, storeCode);
		pageContext.setAttribute("areaName", areaName);
		pageContext.setAttribute("storeName", storeName);
	}catch(SQLException se){
		se.printStackTrace();
	}//end catch
	
	%>
	<!-- 최상단 메뉴이름 타이틀바 시작 -->
	<div id="currentMenu">
		<span id="currentTopMenuName">휴게소 관리</span>
		<span id="currentBottomMenuName">
		> <c:out value="${ areaName }"/> 
		> 매장관리 > 메뉴관리 : <c:out value="${ storeName }"/>  </span>
	</div>
	<!-- 최상단 메뉴이름 타이틀바 끝 -->
	
	<!-- 내용 시작 -->
	
	<%
	try{
		List<MenuVO> list = mnDAO.selectAllMenu(areaCode, storeCode);
		pageContext.setAttribute("list", list);
	}catch(SQLException se){
		se.printStackTrace();
	}//end catch 
	%>
	
	<div id="mainWrap">
		<div class="tableFrm">
		<table class="menuTable">
			<tr>
				<th style="width: 2%;"></th>
				<th style="width: 20%;">메뉴명</th>
				<th style="width: 25%;">매장명</th>
				<th style="width: 20%;">가격</th>
				<th style="width: 33%;">기타</th>
			</tr>
			<c:forEach var="mnVO" items="${ list }" varStatus="i">
			<tr>
				<td style="text-align: center;"><input type="radio" name="radio" value="${ mnVO.menuNum }"></td>
				<td><c:out value="${ mnVO.menuName }"/></td>
				<td><c:out value="${ mnVO.storeName }"/></td>
				<td><c:out value="${ mnVO.price }"/>원</td>
				<td><c:out value="${ mnVO.note }"/></td>
			</tr>
			</c:forEach>
		</table>
		</div>
			
		<div class="Frame2">
			<input type="button" value="메뉴 추가" class="addMenuBtn" id="addMenuBtn"/>　
			<input type="button" value="상세 조회" class="detailViewBtn" id="detailViewBtn"/>　
			<input type="button" value="수정" class="modifyMenuBtn" id="modifyMenuBtn"/>　
			<input type="button" value="삭제" class="deleteMenuBtn" id="deleteMenuBtn"/>
		</div>
		
	</div>
	<!-- 내용 끝 -->
	
</div>
<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>