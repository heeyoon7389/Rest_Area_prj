<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="휴게소 상세 페이지"%>
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
#wrap {
	min-height: 100vh;
	position: relative;
	width: 100%;
}

#header{
	width: 100%;
	text-align: center;
	background-color : teal;
	position: fixed;
	color: white;
}

#title {
	text-align: center;
	font-family: sans-serif;
	font-weight: bold;
}

#nav {
	display: flex;
	position : fixed;
	width : 100%;
	justify-content: space-between;
	align-items: center;
	background: teal;
	padding: 8px 12px;
	border: 1px solid #333;
}

#nav a {
	text-decoration: none;
	color: white;
}

.store {
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 1000px;
	text-align: center;
}

.facil, .gs, .review {
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 1000px;
	text-align: center;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	flex-direction: column;
}

.slider-images {
	display: flex;
	justify-content: space-around;
	width: 100%;
}

.slider-images img {
	max-width: 100%;
	max-height: 100%;
}

#store_, #gs_, #review_ {
	float: left;
	width: 20%;
	height: 50%;
	margin-top: 250px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid #333;
	border-radius: 40px;
}
#facil_{
	float: left;
	width: 20%;
	height: 50%;
	margin-top: 250px;
	display: flex;
	justify-content: center;
	align-items: center;
	border: 1px solid #333;
	border-radius: 40px;
}

.store_info {
	overflow-y: auto;
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 1000px;
}

#gs_info {
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 1000px;
}

}
#facil_info {
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 1000px;
}

#review_info {
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	height: 1000px;
}

#review_info h1 {
	margin-top: 0;
	text-align: left; /* h1 요소의 상단 마진을 0으로 설정하여 리뷰 텍스트를 위쪽으로 이동 */
}

#review_info a {
	margin-top: 0;
	text-align: right;
}

.image-container {
	display: flex;
	flex-direction: column;
	
}
.store {
	background: #ff0000;
}
</style>
<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript"
	src="http://localhost/RestArea_Project/common/js/coinSlider/coin-slider.min.js"></script>
<link rel="stylesheet"
	href="http://localhost/RestArea_Project/common/js/coinSlider/coin-slider-styles.css">
<script type="text/javascript">
	$(function() {
		$('#facil_info').coinslider({
			navigation : true,
			delay : 5000
		});
		$("#review_info a").click(function() {
			var url = "http://localhost/RestArea_Project/rest_area_detail_page/write_review_page.jsp";
			var name = "리뷰 작성";
			var option = "width = 500, height = 500, top = 100, left = 200, location = no";
			window.open(url, name, option)
		});
	});
</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<div id="title">
				휴게소 상세 페이지<br> OO휴게소<br /> OO구 OO동 xxx-xx<br />
			</div>
			<div id="nav" style="font-weight: bold;">
				<a href="#store_">매장</a> <a href="#facil_">편의시설</a> <a
					href="#gs_">주유소</a>
				<hr />
				<a href="#review_">리뷰</a>
			</div>
		</div>
		<div id="main">
			<div class="store">
				<div id="store_">매장</div>
				<div class="store_info">
					<ul>
						<li>1</li>
						<li>2</li>
						<li>3</li>
						<li>4</li>
						<li>5</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
						<li>6</li>
					</ul>
				</div>
			</div>
			<div class="facil">
				<div id="facil_info">
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col p-4 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-success-emphasis">OO
								주유소</strong>
							<h3 class="mb-0">편의 시설</h3>
							<p class="mb-auto">어쩌구 저쩌구~~~</p>
						</div>
						<div class="col-auto d-none d-lg-block">
							<img src="icons/shower.png" width="200" height="250"
								class="bd-placeholder-img" role="img"
								aria-label="Placeholder: Thumbnail">
						</div>
					</div>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative">
						<div class="col p-4 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-success-emphasis">OO
								주유소</strong>
							<h3 class="mb-0">편의 시설</h3>
							<p class="mb-auto">어쩌구 저쩌구~~~</p>
						</div>
						<div class="col-auto d-none d-lg-block">
							<img src="icons/pharmacy.png" width="200" height="250"
								class="bd-placeholder-img" role="img"
								aria-label="Placeholder: Thumbnail">
						</div>
					</div>
					<div
						class="row g-0 border rounded overflow-hidden flex-md-column mb-4 shadow-sm h-md-250 position-relative">
						<div class="col p-4 d-flex flex-column position-static">
							<strong class="d-inline-block mb-2 text-success-emphasis">OO
								주유소</strong>
							<h3 class="mb-0">편의 시설</h3>
							<p class="mb-auto">어쩌구 저쩌구~~~</p>
						</div>
						<div class="col-auto d-none d-lg-block">
							<img src="icons/gasstaion.png" width="1000" height="250"
								class="bd-placeholder-img" role="img"
								aria-label="Placeholder: Thumbnail">
						</div>
					</div>
				</div>
			<div id="facil_">편의시설</div>
			</div>
			</div>
		</div>
		<div class="gs">
			<div id="gs_">주유소</div>
			<div id="gs_info">
				<img src='icons/gasstaion.png'>
				<h1>OO 휴게소 주유소</h1>
				<br /> OO 주유소<br> lpg : 2000원<br> tel:010-7255-5901<br>
			</div>
		</div>
		<div class="review">
			<div id="review_info">
				<h1>리뷰</h1>
				<a href="">리뷰 쓰기</a>
				<!-- <input type="button" name="review_btn" class="btn btn-success" value="리뷰 쓰러가기"> -->
				<br />
				<textarea rows="4" cols="200"></textarea>
				<br>
				<textarea rows="4" cols="200"></textarea>
				<br>
				<textarea rows="4" cols="200"></textarea>
				<br>
				<textarea rows="4" cols="200"></textarea>
				<br>

			</div>
			<div id="review_">리뷰</div>
		</div>
	</div>
	<div id="footer">
		<nav>
			<a href="https://github.com/KimByeongNyeon">GitHub</a>
		</nav>
	</div>
	</div>
</body>
</html>



