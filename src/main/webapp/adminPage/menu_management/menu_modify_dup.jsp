<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>
<link rel="icon" href="http://192.168.10.220/jsp_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.220/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.220/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
	#wrap{
		width: 450px;
		height: 700px;
		margin: 0px auto;
		background: #B3B3B3;
		position: relative;
	}
	
	#inputWrap{
		width: 350px;
		height: 580px;
		padding: 15px;
		background: #FFFFFF;
		margin-top: 35px;
		margin-left: 50px;
		box-shadow: 10px 10px 1px rgb(90,90,90);
	}
	
	#modifyMenu{
		width: 450px;
		height: 50px;
		padding: 10px;
		background-color: #E0E0E0;
	}
	
	#addMenuBtn{ /* 추가버튼 */
		width: 100px;
		height: 39px;
		border: 1px solid #3498DB;
		background-color: #3498DB;
		border-radius: 5px;
		color: white;
	}
	
	#cancleBtn{ /* 취소버튼 */
		width: 100px;
		height: 39px;
		border: 1px solid #B3B3B3;
		background-color: #B3B3B3;
		border-radius: 5px;
		color: white;
	}
	
	#btnWrap{
		text-align: center;
	}
	
	
</style>
<script type="text/javascript">
	$(function(){
		/* 추가 */
		$("#addMenuBtn").click(function(){
			alert("추가");
		});
		
		/* 취소 */
		$("#cancleBtn").click(function(){
			self.close();
		});
	});//ready
</script>
</head>
<body>
<div id="wrap">
	<div id="modifyMenu"><h5><strong>메뉴 수정</strong>>경산(서울)휴게소>ㅁㅁ전문점</h5></div>
	<div id="inputWrap">
	<label>메뉴명</label><br>
	<input type="text" placeholder="메뉴 이름" value="된장찌개"><br/><br/>
	
	<label>매장명</label><br>
	<label><h4>한식전문점</h4></label><br><br>
	
	<label>가격</label><br>
	<input type="text" placeholder="가격" value="7500"><br/><br/>
	
	<label>상세정보</label><br>
	<textarea id="menuMeno" rows="9" cols="40" placeholder="내용을 입력해주세요." style="resize: none;">두부가 잔뜩 들어간 된장찌개</textarea><br/><br/>
	
	<div id="btnWrap">
	<input type="button" value="추가" id="addMenuBtn"/>　
	<input type="button" value="취소" id="cancleBtn"/>
	</div>
	</div>
</div>
</body>
</html>