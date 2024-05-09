<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="휴게소 리뷰 작성 페이지"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert title here</title>
	<link rel="icon" href="http://192.168.10.219/jsp_prj/common/favicon/favicon.ico"/>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
		integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
		crossorigin="anonymous"></script>
	<style type="text/css">
	#reviewTextarea{
		position: relative;
		margin-bottom: 
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
  background: url('https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FE2bww%2FbtsviSSBz4Q%2F5UYnwSWgTlFt6CEFZ1L3Q0%2Fimg.png') no-repeat; 
  background-size: 100%; 
  box-sizing: border-box; 
}
.star_rating .star.on {
  width: 25px; 
  height: 25px;
  margin-right: 10px;
  display: inline-block; 
  background: url('https://blog.kakaocdn.net/dn/b2d6gV/btsvbDoal87/XH5b17uLeEJcBP3RV3FyDk/img.png') no-repeat;
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
.btn02 {
  display:block;
  width: 400px;
  font-weight: bold;
  border: 0;
  border-radius: 10px;
  max-height: 50px;
  padding: 15px 0;
  font-size: 1.1em;
  text-align: center;
  background:bisque;
}
	</style>
	<!--jQuery CDN 시작-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js">
	</script>
	<script type="text/javascript">
		$(function () {
			$('.star_rating > .star').click(function() {
				  $(this).parent().children('span').removeClass('on');
				  $(this).addClass('on').prevAll('span').addClass('on');
				  var value = $(this).attr('value');
				  $('#selectedStar').text('선택한 별점: ' + value);
				});
		});
	</script>
</head>
<body>
	<!-- 리뷰 작성 모달 -->
<div id="reviewModal" class="modal-dialog">
  <div class="modal-content">
    <span class="close" onclick="closeReviewModal()"></span>
    <h2><strong>리뷰 작성</strong></h2>
    <span><h3>별점</h3>
    <div class ="star_rating">
  <span class="star on" value="1"> </span>
  <span class="star" value="2"> </span>
  <span class="star" value="3"> </span>
  <span class="star" value="4"> </span>
  <span class="star" value="5"> </span>
</div>
  <p id="selectedStar"></p>
    
    </span><br/>
    <p>리뷰를 입력해주세요</p>
    <textarea id="reviewTextarea" rows="10" cols="50"></textarea>
    <button class="btn btn-primary" onclick="submitReview()">제출</button>
  </div>
</div>
</body>
</html>