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
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
	crossorigin="anonymous"></script>
<style type="text/css">
a {
	text-decoration: none;
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

#facil_info {
	float: left;
	width: 80%;
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	height: 1000px;
	align-items: center;
	justify-content: center;
	flex-direction: column;
}

#review_info {
	float: left;
	width: 60%;
	display: flex;
	flex-direction: column;
	justify-content: flex-start;
	height: 1000px;
	overflow: hidden;
}

#review_info h1 {
	margin-top: 0;
	text-align: left;
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

.star_rating {
	width: 100%;
	box-sizing: border-box;
	display: inline-flex;
	float: left;
	flex-direction: row;
	justify-content: flex-start;
}

.star_rating .star {
	width: 25px;
	height: 25px;
	margin-right: 10px;
	display: inline-block;
	background:
		url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png')
		no-repeat;
	background-size: 100%;
	box-sizing: border-box;
}

.star_rating .star.on {
	width: 25px;
	height: 25px;
	margin-right: 10px;
	display: inline-block;
	background:
		url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png')
		no-repeat;
	background-size: 100%;
	box-sizing: border-box;
}

.star_box {
	width: 400px;
	box-sizing: border-box;
	display: inline-block;
	margin: 15px 0;
	background: #F3F4F8;
	border: 0;
	border-radius: 10px;
	height: 100px;
	resize: none;
	padding: 15px;
	font-size: 13px;
	font-family: sans-serif;
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
							var raNum = document.review_form.raNum.value;
							var memberId = document.review_form.memberId.value;
							var url = "http://localhost/Rest_Area_prj/rest_area_detail_page/write_review_page.jsp?raNum="+raNum + "&memberId="+memberId;
							var name = "리뷰 작성";
							var option = "width = 500, height = 500, top = 100, left = 200, location = no";
							window.open(url, name, option)
							$("#review_form").submit();
						});
		$(".store_note a")
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
	});
</script>
</head>
<body>
	<div id="wrap">
		<div id="header">
			<div id="title">
				<%
				String raNum = request.getParameter("raNum");
				RestAreaInfoVO raiVO = null;
				RestAreaInfoDAO raiDAO = RestAreaInfoDAO.getInstance();
				raiVO = raiDAO.selectRestAreaInfo(raNum);
				%>
				휴게소 상세 페이지<br><%=raiVO.getRaName()%><br />
				<%=raiVO.getRaAddr()%><br />
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
						style="margin-right: 20px; margin-bottom: 20px; border: 1px solid #333; border-radius: 10px;">
						<img src="images/<%=rsVO.getStoreImg()%>" alt="avatar"
							style="width: 50px; height: 50px; margin-right: 10px; top: 0;">
						<div class="store_note" style="margin-top: 0; text-align: left;">
							<a href=""><h3 style="margin: 0;">
									<span data-value="<%=rsVO.getStoreNum()%>"><%=rsVO.getStoreName()%></span>
								</h3></a>
							<p style="margin: 0;"><%=rsVO.getStoreNote()%></p>
						</div>
						<div class="store_rep"
							style="bottom: 0px; margin-left: auto; margin-top: auto;">
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
					<table>
						<tbody>
							<tr>
								<th>편의시설 이름</th>
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
								<td>편의시설 이미지 정보</td>
								<td><%=rafVO.getFacilNote()%></td>
							</tr>
							<%
							}
							%>
						</tbody>
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
				<form id ="review_form" name = "review_form" action="rest_area_detail_page.jsp" method="post">
				<div id="review_button" class="text-end">
					<input type="button" id="write_review" class="btn btn-primary"
						value="리뷰쓰기">
				</div>
				<input type="hidden" name="raNum" value="<%=raNum%>">
				<input type="hidden" name="memberId" value="kimking">
				
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
						style="height: 100px; display: flex; flex-direction: column; border: 0.5px solid #333; border-radius: 5px;">
						<div style="display: flex; justify-content: space-between;">
							<span style="width: 250px;">
							아이디 :
							<%=rarVO.getMemberId()%>
							별점 :</span>
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
							(<%= rarVO.getStar() %>)
							</div>
							<div id="review_input_date" style ="width: 250px;">
							<span style="width: 150px;"> 입력일 : 
							<%=rarVO.getInputDate()%>
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
						style="height: 100px; border: 1px solid #ffffff; border-radius: 5px; background-color: #A8A8A8;">
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
			<div id="review_">리뷰</div>
		</div>
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
