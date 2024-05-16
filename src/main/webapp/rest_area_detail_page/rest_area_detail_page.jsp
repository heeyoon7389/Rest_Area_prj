<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.parser.JSONParser"%>
<%@page import="java.io.FileReader"%>
<%@page import="restAreaInfo.RestAreaInfoDAO"%>
<%@page import="restAreaInfo.RestAreaInfoVO"%>
<%@page import="restAreaReview.RestAreaReviewDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="restAreaReview.RestAreaReviewVO"%>
<%@page import="restAreaStore.RestAreaStoreDAO"%>
<%@page import="restAreaStore.RestAreaStoreVO"%>
<%@page import="restAreaFacil.RestAreaFacilVO"%>
<%@page import="java.util.List"%>
<%@page import="restAreaFacil.RestAreaFacilDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="휴게소 상세 페이지"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 상세 페이지</title>
<link rel="icon"
	href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/detailpage_css.css">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
/* 기본 스타일 */
</style>
<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="JS/gs_info.js">
	
</script>
<script type="text/javascript">
	$(function() {
		$('.star_rating > .star').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
		})

		$("#write_review")
				.click(
						function() {
							var raNum = document.review_form.raNum.value;
							var memberId = document.review_form.memberId.value;
							var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/write_review_page.jsp?raNum="
									+ raNum + "&memberId=" + memberId;
							var name = "리뷰 작성";
							var option = "width = 500, height = 500, top = 100, left = 200, location = no";
							window.open(url, name, option)
							$("#review_form").submit();
						});
		$(".store_info a")
				.click(
						function(event) {
							// 호출할 페이지의 URL을 설정합니다.
							var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/menu_detail.jsp";

							// 현재 클릭한 링크의 부모 요소인 store_detail에서 storeNum 값을 가져옵니다.
							var storeNum = $(this).find('span').data('value');
							// URL에 파라미터를 추가합니다.
							url += "?storeNum=" + storeNum;

							// 모달 창의 이름과 옵션을 설정합니다.
							var name = "메뉴 상세정보";
							var options = "width=650,height=500,top="
									+ (window.screenY + 300) + ",left="
									+ (window.screenX + 740);

							// 새 창으로 모달을 엽니다.
							window.open(url, name, options);

							// 기본 이벤트를 막아야 새 창이 열립니다.
							event.stopPropagation();
						});
		$(".store_rep a")
				.click(
						function(event) {
							var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/store_report.jsp";
							var storeNum = $(this).find('span').data('value');
							url += "?storeNum=" + storeNum;
							var name = "매장 신고";
							var options = "width= 600, height=400, top="
									+ (window.screenY + 300) + ",left="
									+ (window.screenX + 740);
							window.open(url, name, options);
							event.stopPropagation();
						});

	});
</script>
</head>
<body>
	<div class="container">
		<div id="header">
			<%
			String raNum = request.getParameter("raNum");
			String raName = request.getParameter("raName");
			String addr = request.getParameter("addr");
			RestAreaInfoVO raiVO = null;
			RestAreaInfoDAO raiDAO = RestAreaInfoDAO.getInstance();
			raiVO = raiDAO.selectRestAreaInfo(raNum);
			%>
			<%=raiVO.getRaName()%><br />
			<%=raiVO.getRaAddr()%>
			<div class="star_rating">
				<span class="star"
					style="width: 50px; height: 50px; margin: left auto;" value="1"></span>
			</div>
		</div>
		<main>
			<div id="main">
				<div class="ra_map">
					<div id="map_">
						<h1>지도</h1>
					</div>
					<br />
					<div id="map" style="height: 450px;">
						<script type="text/javascript"
							src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16ee3555fcc7fa1f7c8e630d95b34e4f"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							mapOption = {
								center : new kakao.maps.LatLng(
						<%=raiVO.getLatitude()%>
							,
						<%=raiVO.getLongitude()%>
							), // 지도의 중심좌표
								level : 3
							// 지도의 확대 레벨
							};

							var map = new kakao.maps.Map(mapContainer,
									mapOption); // 지도를 생성합니다

							// 마커가 표시될 위치입니다 
							var markerPosition = new kakao.maps.LatLng(
						<%=raiVO.getLatitude()%>
							,
						<%=raiVO.getLongitude()%>
							);

							// 마커를 생성합니다
							var marker = new kakao.maps.Marker({
								position : markerPosition
							});

							// 마커가 지도 위에 표시되도록 설정합니다
							marker.setMap(map);

							// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
							// marker.setMap(null);
						</script>
					</div>
				</div>
				<div class="store">
					<div id="store_">
						<h1>매장</h1>
					</div>
					<br />
					<!-- /////////////////////매장 시작//////////////////////// -->
					<jsp:include page="store_content.jsp" />
				</div>
				<!-- /////////////////////// 매장 끝 /////////////////////////////////// -->
				<!--//////////////////////// 편의시설 ///////////////////////////////-->
				<jsp:include page="facil_content.jsp" />
				<!-- ////////////////////////////편의시설 끝///////////////////////////// -->
				<div class="gs">
					<div id="gs_">
						<h1>주유소</h1>
					</div>
					<br />
					<div id="gs_info">
						<!-- 주유소 ajax로 통신 -->
					</div>
				</div>
			</div>
		</main>
		<article>
			<!--//////////////////////// 리뷰 ///////////////////////////////-->
			<jsp:include page="review_content.jsp" />
			<!-- ////////////////////////////리뷰 끝///////////////////////////// -->
		</article>
</body>
</html>
