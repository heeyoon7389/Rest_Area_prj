<%@page import="prj2.common.dao.CntDAO"%>
<%@page import="prj2VO.LoginVO"%>
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
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="휴게소 상세 페이지"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 상세 페이지</title>
<link rel="icon" href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<link rel="stylesheet" href="css/detailpage_css.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<style type="text/css">
/* 기본 스타일 */
</style>
<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script src="JS/gs_info.js"></script>
<script type="text/javascript">
	$(function() {
		$("#write_review").click(function() {
	        var raNum = document.review_form.raNum.value;
	        var memberId = document.review_form.memberId.value;
	        var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/write_review_page.jsp?raNum=" + raNum + "&memberId=" + memberId;
	        var name = "리뷰 작성";
	        var option = "width=500, height=500, top=100, left=200, location=no";
	        window.open(url, name, option);
	        $("#review_form").submit();
	    });

	    // 매장 상세 정보 클릭 이벤트
	    $(".menu_detail_link").click(function(event) {
	        event.preventDefault(); // 기본 동작 막기
	        var storeNum = $(this).find('span').data('value');
	        var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/menu_detail.jsp?storeNum=" + storeNum;
	        var name = "메뉴 상세정보";
	        var options = "width=650,height=500,top=" + (window.screenY + 300) + ",left=" + (window.screenX + 740);
	        window.open(url, name, options);
	        event.stopPropagation(); // 이벤트 전파 막기
	    });

	    // 신고하기 클릭 이벤트
	    $(".report_link").click(function(event) {
	        event.preventDefault(); // 기본 동작 막기
	        var storeNum = $(this).find('span').data('value');
	        var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/store_report.jsp?storeNum=" + storeNum;
	        var name = "매장 신고";
	        var options = "width=600,height=400,top=" + (window.screenY + 300) + ",left=" + (window.screenX + 740);
	        window.open(url, name, options);
	        event.stopPropagation(); // 이벤트 전파 막기
	    });
		
		$('#switch').change(function() {
            var flag = $(this).is(':checked') ? "1" : "0";
            var raNum = document.review_form.raNum.value;
			var memberId = document.review_form.memberId.value;
            $.ajax({
                url: '../rest_area_detail_page/rest_area_detail_page.jsp',
                type: 'POST',
                data: {
                    'flag': flag,
                    'memberId': memberId,
                    'raNum': raNum
                },
                success: function(response) {
                    alert('즐겨 찾기 수정 완료!');
                    console.log(response);
                },
                error: function(xhr, status, error) {
                    console.error(error);
                }
            });
        });
	});
</script>
</head>
<body>
	<div class="container">
		<div id="header">
			<%
				String memberId = null;
		        LoginVO loginData = (LoginVO) session.getAttribute("loginData");
		        if (loginData != null) {
		            memberId = loginData.getMemId();
		        } else {
		            memberId = "nonMember";
		        }
				String raNum = request.getParameter("raNum");
				String raName = request.getParameter("raName");
				String addr = request.getParameter("addr");
				RestAreaInfoVO raiVO = null;
				RestAreaInfoDAO raiDAO = RestAreaInfoDAO.getInstance();
				raiVO = raiDAO.selectRestAreaInfo(raNum);
			%>
			<%
				CntDAO cDAO = CntDAO.getInstance();
				cDAO.insertRestAreaViewCnt(request.getParameter("raNum"));
			%>
			<%=raiVO.getRaName()%><br />
			<%=raiVO.getRaAddr()%>
			<%
				String flag = "0";
				raiDAO.updateFavorite(flag, memberId, raNum);
			%>
			<%-- <div class="wrapper">
				<input type="checkbox" id="switch" name="favorite_toggle" value="<%=flag%>"> 
				<input type="hidden" name="">
				<label for="switch" class="switch_label">
					<span class="onf_btn"></span>
				</label>
			</div> --%>
		</div>
		<main>
			<div id="main" style="overflow: auto;">
				<div class="ra_map">
					<div id="map_">
						<h1>지도</h1>
					</div>
					<br />
					<div id="map" style="height: 450px;">
						<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=16ee3555fcc7fa1f7c8e630d95b34e4f"></script>
						<script>
							var mapContainer = document.getElementById('map'),
								mapOption = {
									center: new kakao.maps.LatLng(<%=raiVO.getLatitude()%>, <%=raiVO.getLongitude()%>),
									level: 3
								};
							var map = new kakao.maps.Map(mapContainer, mapOption);
							var markerPosition = new kakao.maps.LatLng(<%=raiVO.getLatitude()%>, <%=raiVO.getLongitude()%>);
							var marker = new kakao.maps.Marker({
								position: markerPosition
							});
							marker.setMap(map);
						</script>
					</div>
				</div>
				<div class="store">
					<div id="store_">
						<h1>매장</h1>
					</div>
					<br />
					<jsp:include page="store_content.jsp" />
				</div>
				<jsp:include page="facil_content.jsp" />
				<div class="gs">
					<div id="gs_">
						<h1>주유소</h1>
					</div>
					<br />
					<div id="gs_info">
					</div>
				</div>
			</div>
		</main>
		<article>
			<jsp:include page="review_content.jsp" />
		</article>
	</div>
</body>
</html>
