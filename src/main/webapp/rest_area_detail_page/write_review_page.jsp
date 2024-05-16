<%@page import="restAreaReview.RestAreaReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" info="휴게소 리뷰 작성 페이지"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>휴게소 리뷰 작성</title>
<link rel="icon"
	href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link rel="stylesheet" href="css/review_content.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<style type="text/css">

</style>

<script type="text/javascript">
	$(function() {
		$('.star_rating > .star').click(function() {
			$(this).parent().children('span').removeClass('on');
			$(this).addClass('on').prevAll('span').addClass('on');
			var value = $(this).attr('value');
			$('#selectedStar').text('선택한 별점: ' + value);
			$('#ratingValue').val(value); // 숨겨진 입력 필드 값 설정
		});
	});

	function chkNull() {
		var content = document.getElementById("reviewTextarea").value;
		var rating = document.getElementById("ratingValue").value;
		if (!content.trim()) {
			alert("리뷰 내용을 입력해주세요.");
			return false;
		} else if (!rating) {
			alert("별점을 선택해주세요.");
			return false;
		} else {
			return true;
		}
	}
</script>
</head>
<body>
	<div id="reviewModal" class="modal-dialog">
		<div class="modal-content">
			<span class="close" onclick="closeReviewModal()"></span>
			<h2>
				<strong>리뷰 작성</strong>
			</h2>
			<%
			String raNum = request.getParameter("raNum");
			String memberId = request.getParameter("memberId");
			%>
			<form action="write_review_process.jsp" method="post"
				onsubmit="return chkNull();">
				<div>
					<div class="star_rating">
					<h3>별점: </h3>
						<span class="star" value="1"></span> <span class="star" value="2"></span>
						<span class="star" value="3"></span> <span class="star" value="4"></span>
						<span class="star" value="5"></span>
					 <input type="hidden" id="ratingValue" name="ratingValue">
					 </div>
					<p id="selectedStar" name="selectedStar"></p>
				</div>
				<div>
				<textarea name="content" id="reviewTextarea" placeholder="리뷰를 입력해주세요!" rows="10" cols="50"></textarea>
				</div>
				<input type="hidden" name="raNum" value="<%=raNum%>"> <input
					type="hidden" name="memberId" value="<%=memberId%>">
				<button type="submit" class="btn btn-primary">리뷰 등록</button>
			</form>
		</div>
	</div>
</body>
</html>
