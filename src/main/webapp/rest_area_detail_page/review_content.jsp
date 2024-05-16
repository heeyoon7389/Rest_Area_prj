<%@page import="java.util.ArrayList"%>
<%@page import="restAreaReview.RestAreaReviewDAO"%>
<%@page import="restAreaReview.RestAreaReviewVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 리뷰 콘텐츠 -->
<div class="review">
	<div id="review_info" style="overflow-x: auto; overflow-y: hidden;">
		<h1>리뷰</h1>
		<br />
		<%
		String raNum = request.getParameter("raNum");
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
