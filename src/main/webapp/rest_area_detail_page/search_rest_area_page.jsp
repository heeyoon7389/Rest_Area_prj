<%@page import="searchRestArea.SearchRestAreaDAO"%>
<%@page import="searchRestArea.RestAreaNameVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="휴게소 검색 페이지"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon"
	href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
/* 네비게이션 바 스타일 */
.nav-item {
	margin-top: 15px;
}

#login {
	cursor: pointer;
}
/* 검색창 스타일 */
.search-container form {
	width: 100%;
}
/* 검색창 select 스타일 */
.form-select {
	width: 185px;
}
/* 검색 버튼 크기 조절 */
.btn-primary {
	flex-shrink: 0;
	width: 100px;
	height: 65px;
}

.main {
	margin-top: 15px;
	width: 100%;
	float: left;
	width: 100%;
}

#main_1 {
	float: left;
	overflow: auto;
	width: 50%;
	height: 750px;
}

#main_2 {
	float: right;
	width: 50%;
	height: 750px;
}

.col-md-6 {
	margin-top: 20px;
}

a {
	text-decoration: none;
	color: black;
}

footer {
	margin-top: 150px;
}
</style>
<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js">
	
</script>
<script type="text/javascript">
$(document).ready(function(){
    // 휴게소 링크를 클릭했을 때
    $(document).on("click", ".rest_area_link", function() {
        var latitude = $(this).data('lat');
        var longitude = $(this).data('lng');
        var name = $(this).text(); // 휴게소 이름
        
        // 가져온 값을 콘솔에 출력합니다.
        console.log("Clicked Rest Area:", name);
        console.log("Latitude:", latitude);
        console.log("Longitude:", longitude);
        
        // 가져온 위도와 경도 값을 이용하여 showRestArea 함수를 호출합니다.
        showRestArea(latitude, longitude);
    });
});

function showRestArea(latitude, longitude) {
    // 여기에 지도 표시 코드를 추가합니다.
    // var container = document.getElementById('map');
    // var options = {
    //     center: new kakao.maps.LatLng(latitude, longitude),
    //     level : 3
    // };
    // var map = new kakao.maps.Map(container, options);
}
</script>

</head>
<body>
	<div class="container">
		<!-- 메뉴바 시작-->
		<header
			class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
			<a href="mainPage.jsp"
				class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
				<img src="https://data.ex.co.kr/images/common/logo.png"> <span
				class="fs-4">고속도로 휴게소</span>
			</a>

			<ul class="nav justify-content-end">
				<li class="nav-item"><a class="nav-link" id="login">로그인</a></li>
				<li class="nav-item"><a class="nav-link" href="join.jsp">회원가입</a>
				</li>
			</ul>
		</header>
		<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
		<!-- 메뉴바 끝-->
		<!-- 검색창 시작-->
		<div class="search-container">
			<form class="d-flex" role="search">
				<select class="form-select" aria-label="고속도로 검색 유형">
					<option value="1" selected>지역별</option>
					<option value="2">휴게소별</option>
					<option value="3">고속도로별</option>
				</select> <input class="form-control me-2" type="search"
					placeholder="찾으시는 휴게소를 검색해주세요" aria-label="Search">
				<button class="btn btn-primary" type="submit">검색</button>
			</form>
		</div>
		<!-- 검색창 끝-->
		<!-- 지도 & 이달의 맛집 시작 -->
		<div class="main">
			<div id="main_1" style="overflow: auto;">
				<%
				String raName = "서울만남";
				List<RestAreaNameVO> searchNameList = null;
				SearchRestAreaDAO sraDAO = SearchRestAreaDAO.getInstance();
				searchNameList = sraDAO.searchByRaName(raName);
				RestAreaNameVO ranVO = null;
				%>
				<%
				for (int i = 0; i < searchNameList.size(); i++) {
				%>
				<%
				ranVO = searchNameList.get(i);
				%>
				<div class="col-md-12">
					<!-- 휴게소 정보 -->
					<!-- 이달의 맛집1 시작 -->
					<div class="row">
						<div class="col-md-12">
							<div
								class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm position-relative">
								<div id="rest_area_name"
									class="col p-4 d-flex flex-column position-static">
									<!-- 여기서 showRestArea 함수를 호출하도록 수정 -->
									<div class="mb-0 rest_area_link"
										data-lat="<%=ranVO.getLatitude()%>"
										data-lng="<%=ranVO.getLongitude()%>"><%=ranVO.getRaName()%></div>
									<div class="mb-1 text-body-secondary"><%=ranVO.getRaAddr()%></div>
									<p class="mb-auto">
										전화번호 <br>
										<%=ranVO.getRaTel()%>
									</p>
									<a
										href="http://localhost/Rest_Area_prj/rest_area_detail_page/rest_area_detail_page.jsp"
										class="icon-link gap-1 icon-link-hover stretched-link"> <%=ranVO.getRaName()%>
										상세페이지 <svg class="bi"> 
                            <use xlink:href="#chevron-right"></use></svg>
									</a>
								</div>
								<div class="col-auto d-none d-lg-block">
									<svg class="bd-placeholder-img" width="200" height="250"
										xmlns="http://www.w3.org/2000/svg" role="img"
										aria-label="Placeholder: Thumbnail"
										preserveAspectRatio="xMidYMid slice" focusable="false"> 
                            <image href="images/sunji2.png" width="200"
											height="250" /> 
                        </svg>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%
				}
				%>
				<!-- 맛집들 끝 -->
			</div>

			<div id="main_2" style="margin-bottom: auto;">
				<div class="row">
					<!-- 지도 시작 -->
					<div id="map"
						style="margin-left: auto; width: 600px; height: 500px;"
						class="col-md-6">
						<!-- 여기에 지도를 표시할 준비를 합니다. -->
					</div>
				</div>
			</div>

			<script type="text/javascript">
				/* // 여기에 지도 표시 코드를 추가합니다.
				var container = document.getElementById('map');
				var options = {
				    center: new kakao.maps.LatLng(latitude, longitude),
				    level : 3
				};
				var map = new kakao.maps.Map(container, options); */
			</script>




			<!-- 지도 & 이달의 맛집 끝-->
			<!-- 	사이트 광고 배너 시작 -->
			<div id="myCarousel" class="carousel slide mb-6"
				data-bs-ride="carousel">
				<!-- 하단이동버튼 시작 -->
				<div class="carousel-indicators">
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="0" class="" aria-label="Slide 1"></button>
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="1" aria-label="Slide 2" class=""></button>
					<button type="button" data-bs-target="#myCarousel"
						data-bs-slide-to="2" aria-label="Slide 3" class="active"
						aria-current="true"></button>
				</div>
				<!-- 하단이동버튼 끝 -->
				<div class="carousel-inner">
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
							preserveAspectRatio="xMidYMid slice" focusable="false">
                    <rect width="100%" height="100%"
								fill="var(--bs-secondary-color)"></rect></svg>
						<div class="container">
							<div class="carousel-caption text-start">
								<h1>한국에서 석유나면 좋겠다.</h1>
								<p class="opacity-75">대한민국에서 석유 나기 VS 초천도체 만들기</p>
							</div>
						</div>
					</div>
					<div class="carousel-item">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
							preserveAspectRatio="xMidYMid slice" focusable="false">
                    <rect width="100%" height="100%"
								fill="var(--bs-secondary-color)"></rect></svg>
						<div class="container">
							<div class="carousel-caption">
								<h1>주요 공지 사항</h1>
								<p>오늘 점심 뭐 먹어야하는지 고민이 됨. 추천 바람.</p>
							</div>
						</div>
					</div>
					<div class="carousel-item active">
						<svg class="bd-placeholder-img" width="100%" height="100%"
							xmlns="http://www.w3.org/2000/svg" aria-hidden="true"
							preserveAspectRatio="xMidYMid slice" focusable="false">
                    <rect width="100%" height="100%"
								fill="var(--bs-secondary-color)"></rect></svg>
						<div class="container">
							<div class="carousel-caption text-end">
								<h1>오늘은 뭐 할 거냐면</h1>
								<p>JSP를 웹에서 요청해 볼 겁니다. 몇개다? 2개~ 어떤 방식 어떤 방식?</p>
							</div>
						</div>
					</div>
				</div>
				<button class="carousel-control-prev" type="button"
					data-bs-target="#myCarousel" data-bs-slide="prev">
					<span class="carousel-control-prev-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Previous</span>
				</button>
				<button class="carousel-control-next" type="button"
					data-bs-target="#myCarousel" data-bs-slide="next">
					<span class="carousel-control-next-icon" aria-hidden="true"></span>
					<span class="visually-hidden">Next</span>
				</button>
			</div>
			<!--  사이트 광고 배너 끝 -->
			<div class="row">
				<!-- FAQ 시작 -->
				<div class="col-md-6">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col" class="text-start">FAQ <span id="plus_FAQ"
									class="float-end">더보기+</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">1</th>
								<td colspan="3">휴게소 상세정보가 알고 싶어요</td>
							</tr>
							<tr>
								<th scope="row">2</th>
								<td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
							</tr>
							<tr>
								<th scope="row">3</th>
								<td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
							</tr>
							<tr>
								<th scope="row">4</th>
								<td colspan="3">휴게소 상세정보가 알고 싶어요</td>
							</tr>
							<tr>
								<th scope="row">5</th>
								<td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
							</tr>
							<tr>
								<th scope="row">6</th>
								<td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- FAQ 끝 -->
				<!-- 공지사항 시작 -->
				<div class="col-md-6">
					<table class="table">
						<thead>
							<tr>
								<th scope="col"></th>
								<th scope="col" colspan="2">공지사항</th>
								<th scope="col">입력일 <span id="plus_announce"
									class="float-end">더보기+</span></th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th scope="row">1</th>
								<td colspan="2">댕 큰 공지사항이 있어요</td>
								<td>2024-12-32</td>
							</tr>
							<tr>
								<th scope="row">2</th>
								<td colspan="2">조금 작은 공지사항이 있어요</td>
								<td>2024-13-01</td>
							</tr>
							<tr>
								<th scope="row">3</th>
								<td colspan="2">암튼 공지사항이 있어요</td>
								<td>2024-01-33</td>
							</tr>
							<tr>
								<th scope="row">4</th>
								<td colspan="2">댕 큰 공지사항이 있어요</td>
								<td>2024-12-32</td>
							</tr>
							<tr>
								<th scope="row">5</th>
								<td colspan="2">조금 작은 공지사항이 있어요</td>
								<td>2024-13-01</td>
							</tr>
							<tr>
								<th scope="row">6</th>
								<td colspan="2">암튼 공지사항이 있어요</td>
								<td>2024-01-33</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- 공지사항 끝 -->
			</div>
			<!-- 공지사항&FAQ 끝 -->
		</div>
		<!-- 제작&저작권 시작 -->
		<footer class="py-5 text-center text-body-secondary bg-white">
			<p>&copy;고속도로 휴게소 제작 by 4조.</p>
			<p class="mb-0">
				<a href="#">상단으로 올라가기</a>
			</p>
		</footer>
		<!-- 제작&저작권 끝 -->
		<!-- 메인 페이지 끝 -->
	</div>
</body>

</html>