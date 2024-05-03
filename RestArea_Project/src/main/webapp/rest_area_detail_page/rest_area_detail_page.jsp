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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
a{
	text-decoration:none;
	color: black;	
}

#wrap {
	min-height: 100vh;
	position: relative;
	width: 100%;
}

#header {
	width: 100%;
	text-align: center;
	background-color: teal;
	position: fixed;
	color: white;
	top: 0;
	margin-bottom: 50px;
}

#main {
	padding-top: 60px;
	height: 70%;
	margin-top: 100px;
}

#title {
	text-align: center;
	font-family: sans-serif;
	font-weight: bold;
}

#nav {
	display: flex;
	position: fixed;
	width: 100%;
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

#facil_ {
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
	overflow: auto;
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 100%;
}

.store_detail {
	text-align: left;
	display: flex;
	width: 50%;
	height: 10%;
	align-items: center;
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
	width: 80%; display : flex; flex-direction : column; justify-content :
	center; align-items : center;
	height: 1000px;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

#review_info {
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	height: 1000px;
	overflow: hidden;
}

#review_info h1 {
	margin-top: 0;
	text-align: left; /* h1 요소의 상단 마진을 0으로 설정하여 리뷰 텍스트를 위쪽으로 이동 */
}

#review_info span {
	margin-top: 0;
	text-align: left;
}

#review_info a {
	margin-top: 0;
	text-align: right;
}

#review_button {
	margin-top: 20px;
}
</style>
<!--jQuery CDN 시작-->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#write_review")
				.click(
						function() {
							var url = "http://localhost/RestArea_Project/rest_area_detail_page/write_review_page.jsp";
							var name = "리뷰 작성";
							var option = "width = 500, height = 500, top = 100, left = 200, location = no";
							window.open(url, name, option)
						});
		$(".store_note a").click(function(){
			var url = "http://localhost/RestArea_Project/rest_area_detail_page/menu_detail.jsp";
			var name = "메뉴 상세정보";
			var option = "width = 550, height = 500, top ="+(window.screenY+150)+", left = "+(window.screenX+150);
			window.open(url, name, option)
		})
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
				<a href="#store_">매장</a> <a href="#facil_">편의시설</a> <a href="#gs_">주유소</a>
				<a href="#review_">리뷰</a>
			</div>
		</div>
		<div id="main">
			<div class="store">
				<div id="store_">매장</div>
				<div class="store_info">
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
					<div class="store_detail"
						style="margin-right: 20px; margin-bottom: 20px;">
						<img src="images/koreanfood.png" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px;">
						<div class="store_note" style = "margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">한식 전문점</h3></a>
							<p style="margin: 0;">한식 전문점 설명 들어갈 부분</p>
						</div>
						<div class="store_rep" style="bottom: 0px; margin-left: auto; margin-top: auto;">
							<a href="#void">신고하기</a>
						</div>
					</div>
				</div>
			</div>
			<div class="facil">
				<div id="facil_info" style="overflow: auto;">
					<table>
						<tr style="border: 1px solid #333;">
							<td style="border: 1px solid #333;">편의시설 이름</td>
							<td style="border: 1px solid #333;" colspan="2">편의시설 이미지 정보
							</td>
							<td style="border: 1px solid #333;">이 편지는 영국에서 최초로 시작되어 일년에
								한바퀴를 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야
								합니다.</td>
						</tr>
						<tr style="border: 1px solid #333;">
							<td style="border: 1px solid #333;">편의시설 이름</td>
							<td style="border: 1px solid #333;" colspan="2">편의시설 이미지 정보
							</td>
							<td style="border: 1px solid #333;">이 편지는 영국에서 최초로 시작되어 일년에
								한바퀴를 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야
								합니다.</td>
						</tr>
						<tr style="border: 1px solid #333;">
							<td style="border: 1px solid #333;">편의시설 이름</td>
							<td style="border: 1px solid #333;" colspan="2">편의시설 이미지 정보
							</td>
							<td style="border: 1px solid #333;">이 편지는 영국에서 최초로 시작되어 일년에
								한바퀴를 돌면서 받는 사람에게 행운을 주었고 지금은 당신에게로 옮겨진 이 편지는 4일 안에 당신 곁을 떠나야
								합니다.</td>
						</tr>
					</table>
				</div>
				<div id="facil_">편의시설</div>
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
				<br> <span><h2>별점 : 4.5</h2></span>
				<div id="review_button" class="text-end">
					<input type="button" id="write_review" class="btn btn-primary"
						value="리뷰쓰기">
				</div>
				<br />
				<textarea readonly="readonly" rows="8" cols="200"></textarea>
				<br>
				<textarea readonly="readonly" rows="8" cols="200"></textarea>
				<br>
				<textarea readonly="readonly" rows="8" cols="200"></textarea>
				<br>
				<textarea readonly="readonly" rows="8" cols="200"></textarea>
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