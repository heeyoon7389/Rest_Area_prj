<%@page import="Amenities.AreaAmeniteVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@page import="Amenities.AmenitieDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="사용 가능 휴게시설 관리"%>
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
		width: 800px;
		height: auto;
	}
	
	.shopTable{ /* 메인 테이블 */
		width: 400px;
		border: 1px solid #B1B1B1;
		float: left;
		margin-left: 15px;
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
	
	#addBtn{ /* 편의시설추가 버튼 */
		width: 250px;
		height: 39px;
		border: 1px solid #3498DB;
		background-color: #3498DB;
		border-radius: 5px;
		color: white;
	}
	
	#modifyAmenitieBtn{ /* 수정 버튼 */
		width: 80px;
		height: 30px;
		border: 1px solid #DBBD37;
		background-color: #DBBD37;
		border-radius: 5px;
		color: white;
	}
	
	#deleteAmenitieBtn{ /* 삭제 버튼 */
		width: 80px;
		height: 30px;
		border: 1px solid #B87972;
		background-color: #B87972;
		border-radius: 5px;
		color: white;
	}
	
	#addAmenitieBtn{ /* 추가 버튼 */
		width: 80px;
		height: 30px;
		border: 1px solid #3498DB;
		background-color: #3498DB;
		border-radius: 5px;
		color: white;
	}
	
	#addFrame, #modifyFrame{
		width: 360px;
		height: auto;
		float: right;
	}
			
</style>
<script type="text/javascript">
	$(function(){
		/* 매장추가 */
		$("#addBtn").click(function(){
			$("#modifyFrame").hide();
			$("#addFrame").show();
		});
			
		/* 추가 */
		$("#addAmenitieBtn").click(function(){
				alert("추가되었습니다.")
		});
		
		/* 수정 */
		$("#modifyAmenitieBtn").click(function(){
			if(confirm("정말 수정하시겠습니까?")){
				alert("수정되었습니다.")
			}//end if
		});
		
		/* 삭제 */
		$("#deleteAmenitieBtn").click(function(){
			if(confirm("정말 삭제하시겠습니까?")){
				alert("삭제되었습니다.")
			}//end if
		});
		/* 테이블이벤트 */
		$("#shopTable tr").click(function(){
			
			var str = ""
			var tdArr = new Array();
			
			// 현재 클릭된 Row(<tr>)
			var tr = $(this);
			var td = tr.children();
			
			$("#addFrame").hide();
			$("#modifyFrame").show();
			
			$("#storeNameM").val( tr.text().trim() );
			
			// tr.text()는 클릭된 Row 즉 tr에 있는 모든 값을 가져온다.
			console.log("클릭한 Row의 모든 데이터 : "+tr.text());
			
		});

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
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/area_management/area_management_frm.jsp" id="unSelsected">메뉴 관리</a></li>
		<li class="bottomMenu"><a href="http://192.168.10.220/Rest_Area_prj/adminPage/all_amenities/all_amenities.jsp" id="selected">전체 편의시설 관리</a></li>
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
	<!-- 최상단 메뉴이름 타이틀바 시작 -->
	<div id="currentMenu">
		<span id="currentTopMenuName">휴게소 관리</span>
		<span id="currentBottomMenuName"> > 전체 편의시설 관리</span>

	</div>
	<!-- 최상단 메뉴이름 타이틀바 끝 -->
	
	<!-- 내용 시작 -->
	
	<%
		AmenitieDAO aaDAO = AmenitieDAO.getInstance();
			try{
				List<AreaAmeniteVO> list = aaDAO.selectAllAmenitie();
				pageContext.setAttribute("list", list);
			}catch(SQLException se){
				se.printStackTrace();
			}//end catch
		%>
	
	<div class="mainWrap">
		<div class="tableFrm">
		<table class="shopTable" id="shopTable">
			<tr>
				<th>현재 사용 가능한 편의시설 목록</th>
			</tr>
			<c:forEach var="aaVO" items="${ list }" varStatus="i">
			<tr>
				<td><c:out value="${ aaVO.amenitieName }"/></td>
			</tr>
			</c:forEach>

		</table>
		</div>
		
		<div id="modifyFrame" style="display: none;">
			<label><h3><strong>상세정보</strong></h3></label><br/><br/>
			<label>편의시설 이름</label><br/>

			<input type="text" id="storeNameM" class="storeNameM" style="width:300px; height: 40px;" placeholder="편의시설 이름"/><br/><br/>

			<input type="button" value="수정" id="modifyAmenitieBtn"/>　
			<input type="button" value="삭제" id="deleteAmenitieBtn"/>
		</div>
		
		<div id="addFrame" style="display: none;">
			<label><h3><strong>추가</strong></h3></label><br/><br/>
			<label>편의시설 이름</label><br/>

			<input type="text" id="storeNameA" class="storeNameA" style="width:300px; height: 40px;" placeholder="편의시설 이름"/><br/><br/>

			<input type="button" value="추가" id="addAmenitieBtn"/>　
		</div>
		
		<div class="bottomBarWrap"/>
			<input type="button" value="편의시설 추가" id="addBtn"/>　
		</div>
	</div>
	
	
	<!-- 내용 끝 -->
	
</div>
<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>