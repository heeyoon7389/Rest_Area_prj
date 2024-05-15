<%@page import="searchRestArea.SearchRestAreaDAO"%>
<%@page import="searchRestArea.RestAreaNameVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="휴게소 검색 페이지"%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>

<div id="main_1" style="overflow-y: auto; overflow-x: hidden;">
		<%-- <%
		String searchValue = request.getParameter("search-query");
		List<RestAreaNameVO> searchNameList = null;
		SearchRestAreaDAO sraDAO = SearchRestAreaDAO.getInstance();
		searchNameList = sraDAO.searchByRaName(searchValue);
		RestAreaNameVO ranVO = null;
		%>
		<%
		for (int i = 0; i < searchNameList.size(); i++) {
		%>
		<%
		ranVO = searchNameList.get(i);
		%>
		<div class="col-md-12">

			<div class="row">
				<div class="col-md-12">
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm position-relative">
						<div id="rest_area_name"
							class="col p-4 d-flex flex-column position-static">
							<div class="mb-0 rest_area_link">
								<a href="#"><span data-lat="<%=ranVO.getLatitude()%>"
									data-lng="<%=ranVO.getLongitude()%>"></span><%=ranVO.getRaName()%></a>
							</div>
							<div class="mb-1 text-body-secondary"><%=ranVO.getRaAddr()%></div>
							<p class="mb-auto">
								전화번호 <br>
								<%=ranVO.getRaTel()%>
							</p>
							<div class="rest_area_detail">
								<a
									href="http://localhost/Rest_Area_prj/rest_area_detail_page/rest_area_detail_page.jsp?raNum=<%=ranVO.getRaNum()%>&raName=<%=ranVO.getRaName()%>&addr=<%=ranVO.getRaAddr()%>"
									class="icon-link gap-1 icon-link-hover stretched-link"> <%=ranVO.getRaName()%>
									상세페이지 <svg class="bi"> 
                                <use xlink:href="#chevron-right"></use>
                            </svg>
								</a>
							</div>
						</div>
						<div class="col-auto d-none d-lg-block">
							<svg class="bd-placeholder-img" width="200" height="250"
								xmlns="http://www.w3.org/2000/svg" role="img"
								aria-label="Placeholder: Thumbnail"
								preserveAspectRatio="xMidYMid slice" focusable="false"> 
                            <image href="images/bugger.png" width="200"
									height="250" /> 
                        </svg>
						</div>
					</div>
				</div>
			</div>
		</div>
		<!-- 이름으로 검색 시 휴게소 지도 출력 -->
		<!-- 휴게소 목록 출력 끝 -->
		<%
		}
		%>
	</div>
	<div class="main_2" style="margin-bottom: auto;">
		<div class="row">
			<!-- 지도 시작 -->
			<div id="map" style="margin-left: auto; width: 600px; height: 500px;"
				class="col-md-6">
				<!-- 여기에 지도를 표시할 준비를 합니다. -->
				<script type="text/javascript"
					src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16ee3555fcc7fa1f7c8e630d95b34e4f"></script>
				<script type="text/javascript">
					var container = document.getElementById('map');//지도를 담을 영역의 DOM 레퍼런스

					var spanElement = document
							.querySelector('.rest_area_link span');

					// span 요소가 존재하는 경우에만 값을 가져옵니다.
					if (spanElement) {
						// data-lat와 data-lng 속성 값을 가져옵니다.
						var latitude = spanElement.dataset.lat;
						var longitude = spanElement.dataset.lng;

						// 가져온 값이 유효한지 확인합니다.
						if (latitude && longitude) {
							// 가져온 위도와 경도 값을 이용하여 원하는 작업을 수행합니다.
							console.log("Latitude:", latitude, "Longitude:",
									longitude);

							// 이제 위도와 경도 값을 사용하여 지도에 마커를 표시하거나 다른 작업을 수행할 수 있습니다.
						} else {
							console
									.error("Failed to retrieve latitude and longitude values.");
						}
					} else {
						console
								.error("Could not find span element with class 'rest_area_link'");
					}

					var options = { //지도를 생성할 때 필요한 기본 옵션
						center : new kakao.maps.LatLng(latitude, longitude),//지도의 중심좌표.
						level : 3
					//지도의 레벨(확대, 축소 정도)
					};

					var map = new kakao.maps.Map(container, options);//지도 생성 및 객체 리턴

					// 마커가 표시될 위치입니다 
					var markerPosition = new kakao.maps.LatLng(latitude,
							longitude);

					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						position : markerPosition
					});

					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
				</script>
			</div>
		</div>
	</div> --%>
</div>