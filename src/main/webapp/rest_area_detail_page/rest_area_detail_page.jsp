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
<script type="text/javascript">
	$(function() {
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
						});
		$(".hambuger-button").on('click', function() {
			event.preventDefault();

			$(this).toggleClass('active');
			$('.overlay').toggleClass('visible');
		});

		$(document).on('scroll', function() {
			if ($(window).scrollTop() > 100) {
				$("#header").removeClass("deactive");
				$("#header").addClass("active");
			} else {
				$("#header").removeClass("active");
				$("#header").addClass("deactive");
			}
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
			<div class="star_rating">
				<span class="star" style="width: 50px; height: 50px;" value="1"></span>
				<%=raiVO.getRaName()%><br />
				<%=raiVO.getRaAddr()%><br />
				<span style="margin: left auto;"><%= raiVO.getMemberId() %>님 환영합니다.</span>
			</div>
			<a href="#void" class="hamburger-button"> <span></span> <span></span>
				<span></span> <span></span>
			</a>
			<div class="overlay">
				<nav class="menu">
					<ul>
						<li><a href="#">매장</a>
						<li><a href="#">편의시설</a>
						<li><a href="#">주유소</a>
						<li><a href="#">리뷰</a>
					</ul>
				</nav>
			</div>
			
		</div>
		<main>
			<div id="main">
				<div class="ra_map">
					<div id="map_">
						<h1>지도</h1>
					</div>
					<br />
					<div id="map" style="width 300px; height:450px;">
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
					<div class="store_info">
						<%
						List<RestAreaStoreVO> storeList = null;
						RestAreaStoreDAO rsDAO = RestAreaStoreDAO.getInstance();
						storeList = rsDAO.selectStore(raNum);
						RestAreaStoreVO rsVO = null;
						%>
						<%
						for (int i = 0; i < storeList.size(); i++) {
						%>
						<%
						rsVO = storeList.get(i);
						%>
						<div class="store_detail"
							style="margin-right: 20px; margin-bottom: 20px; display: flex; align-items: center;">
							<img src="images/<%=rsVO.getStoreImg()%>" alt="avatar"
								style="width: 100px; height: 100px; margin-right: 10px; top: 0;">
							<div class="store_info">
								<a href="">
									<h3 style="margin: 0;">
										<span data-value="<%=rsVO.getStoreNum()%>"><%=rsVO.getStoreName()%></span>
									</h3>
								</a>
								<p style="margin: 0;"><%=rsVO.getStoreNote()%></p>
							</div>
							<div class="store_rep"
								style="margin-left: auto; position: relative; bottm: 0;">
								<a href=""><span data-value="<%=rsVO.getStoreNum()%>">신고하기</span></a>
							</div>
						</div>

						<%
						}
						%>
					</div>
				</div>
				<div class="facil">
					<div id="facil_info" style="overflow: auto;">
						<div id="facil_">
							<h1>편의시설</h1>
						</div>
						<br />
						<table>
							<tbody>
								<tr>
									<th>시설</th>
									<th>이미지</th>
									<th>설명</th>
								</tr>
								<%
								List<RestAreaFacilVO> facilList = null;
								RestAreaFacilDAO rfDAO = RestAreaFacilDAO.getInstance();
								facilList = rfDAO.selectFacil(raNum);
								RestAreaFacilVO rafVO = null; // rafVO 정의 추가
								%>
								<%
								for (int i = 0; i < facilList.size(); i++) {
								%>
								<%
								rafVO = facilList.get(i);
								%>
								<tr>
									<td><%=rafVO.getFacilName()%></td>
									<td><img src="images/pharmacy.png" style ="width: 100px; height: 100px;"></td>
									<td><%=rafVO.getFacilNote()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>

				<div class="gs">
					<div id="gs_">
						<h1>주유소</h1>
					</div>
					<br />
					<div id="gs_info">
						<%
						String jsonFile = "C:/Users/user/git/Rest_Area_prj/src/main/webapp/rest_area_detail_page/주유소.json";
						JSONParser parser = new JSONParser();
						try {
							Object obj = parser.parse(new FileReader(jsonFile));
							JSONObject jsonObject = (JSONObject) obj;
							JSONArray stations = (JSONArray) jsonObject.get("list");
							for (Object stationObj : stations) {
								JSONObject station = (JSONObject) stationObj;
								String tempSaName = (String) station.get("serviceAreaName");
								if (tempSaName == null) {
							continue;
								}
								String serviceAreaName = tempSaName.replace("주유소", "휴게소");
								if (serviceAreaName.replaceAll(" ", "") != null && serviceAreaName.replaceAll(" ", "").contains(raName)) {
							String diselPrice = (String) station.get("diselPrice");
							String gasolinePrice = (String) station.get("gasolinePrice");
							String lpgPrice = (String) station.get("lpgPrice");
							String telNo = (String) station.get("telNo");
						%>


						<strong><%=raName%><br> 주유소 정보</strong>
						<table style="">
							<tr>
							<tr>
								<td>휘발유 : <%=gasolinePrice%></td>
							</tr>
							<tr>
								<td>경유 : <%=diselPrice%></td>
							</tr>
							<%
							if (lpgPrice.equals("X")) {
							%>
							<tr>
								<td>LPG : 정보없음</td>
							</tr>
							<%
							} else {
							%>
							<tr>
								<td>LPG : <%=lpgPrice%>
								</td>
							</tr>
							<%
							}
							%>
							<tr>
								<td>전화번호 : <%=telNo%></td>
							</tr>
						</table>
						<%
						break;
						}
						%>
						<%
						}
						} catch (Exception e) {
						out.println("주유소 정보를 가져오는 중 오류가 발생했습니다.");
						e.printStackTrace();
						}
						%>
					</div>
				</div>
			</div>
		</main>
		<article>
			<div class="review">
				<div id="review_info" style="overflow-x: auto; overflow-y: hidden;">
					<h1>리뷰</h1>
					<br />
					<%
					List<RestAreaReviewVO> reviewList = new ArrayList<RestAreaReviewVO>();
					RestAreaReviewDAO rarDAO = RestAreaReviewDAO.getInstance();
					reviewList = rarDAO.selectAllReview(raNum);
					RestAreaReviewVO rarVO = null;
					double totalScore = 0.0;
					int listSize = reviewList.size();
					double avg = 0.0;
					%>
					<div id="review_star_score"
						style="display: flex; justify-content: space-between; flex-direction: row;">
						<br> <span style="width: 100px;"><h2>별점:</h2></span>
						<%
						for (int i = 0; i < reviewList.size(); i++) {
						%>
						<%
						rarVO = reviewList.get(i);
						totalScore += rarVO.getStar();

						avg = totalScore / listSize;
						%>
						<%
						}
						%>

						<div class="star_rating">
							<%-- 별점에 대한 평균 값(avg)에 따라 불이 들어오도록 함 --%>
							<%
							int avgRounded = (int) Math.round(avg); // 소수점을 반올림하여 정수로 변환
							for (int i = 1; i <= 5; i++) {
								if (i <= avgRounded) {
							%>
							<span class="star on" value="<%=i%>"></span>
							<%
							} else {
							%>
							<span class="star" value="<%=i%>"></span>
							<%
							}
							}
							%>
						</div>
					</div>
					<form id="review_form" name="review_form"
						action="rest_area_detail_page.jsp" method="post">
						<div id="review_button" class="text-end">
							<input type="button" id="write_review" class="btn btn-primary"
								value="리뷰쓰기">
						</div>
						<input type="hidden" name="raNum" value="<%=raNum%>"> <input
							type="hidden" name="memberId" value="kimking">

					</form>
					<br />
					<div id="review_all" style="overflow: auto;">
						<%
						for (int i = 0; i < reviewList.size(); i++) {
						%>
						<%
						rarVO = reviewList.get(i);
						%>
						<%
						if (rarVO.getBlindFlag().equals("0")) {
						%>
						<div
							style="height: 100px; display: flex; flex-direction: column; background-color: white">
							<div style="display: flex; justify-content: space-between;">
								<span style="width: 250px;"> 아이디 : <%=rarVO.getMemberId()%>
									별점 :
								</span>
								<div class="star_rating">
									<%-- 별점에 대한 평균 값(avg)에 따라 불이 들어오도록 함 --%>
									<%
									double reviewStar = rarVO.getStar();
									// 별점을 소수로 받았다고 가정하면 별점을 그대로 표시하면 됩니다.
									for (int j = 1; j <= 5; j++) {
										if (j <= reviewStar) { // 소수로 받은 별점과 비교
									%>
									<span class="star on" style="width: 20px; height: 20px;"
										value="<%=j%>"></span>
									<%
									} else {
									%>
									<span class="star" value="<%=j%>"></span>
									<%
									}
									%>
									<%
									}
									%>
									(<%=rarVO.getStar()%>)
								</div>
								<div id="review_input_date" style="width: 250px;">
									<span style="width: 150px;"> 입력일 : <%=rarVO.getInputDate()%>
									</span>
								</div>
							</div>
							<br />
							<div style="text-align: left;">
								<%=rarVO.getNote()%>
							</div>
						</div>
						<br />
						<%
						} else {
						%>
						<div
							style="height: 100px; display: flex; flex-direction: column; border: 1px solid #ffffff; border-radius: 5px; background-color: #A8A8A8;">
							<div style="text-align: left;">블라인드 처리 된 글입니다.</div>
							<br />
							<%
							}
							%>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
	</div>
	</article>
	<!-- 제작&저작권 시작 -->
	<footer class="py-5 text-center text-body-secondary bg-white">
		<p>&copy;고속도로 휴게소 제작 by 4조.</p>
		<p class="mb-0">
			<a href="#">상단으로 올라가기</a>
		</p>
	</footer>
	<!-- 제작&저작권 끝 -->
</body>
</html>
