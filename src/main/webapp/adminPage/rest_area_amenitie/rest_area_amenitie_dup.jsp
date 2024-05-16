<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>편의시설관리</title>
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
		width: 500px;
		height: 700px;
		margin: 0px auto;
		background: #B3B3B3;
		position: relative;
	}
	
	#tableWrap{
		width: 450px;
		height: auto;
		max-height: 600px;
		overflow: auto;
		padding: 15px;
		background: #FFFFFF;
		margin-top: 25px;
		margin-left: 25px;
		box-shadow: 10px 10px 1px rgb(90,90,90);
	}
	
	#amenitie_management{
		width: 500px;
		height: 50px;
		padding: 10px;
		background-color: #E0E0E0;
	}
	
	#okBtn{ /* 확인버튼 */
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
	
	#amenitie_table{ /* 메인 테이블 */
		width: 400px;
		border: 1px solid #B1B1B1;
		text-align: center;
	}
		
	th{
		height: 40px;
		border: 1px solid #B1B1B1;
		background-color: #D0D0D0;
	}
	
	tr, td{
		height: 35px;
		border: 1px solid #B1B1B1;
	}
	
</style>
<script type="text/javascript">
	$(function(){
		/* 닫기 */
		$("#okBtn").click(function(){
			alert("asdf");
		});
		
	});//ready
</script>
</head>
<body>
<div id="wrap">
	<div id="amenitie_management"><h3><strong>고창고인돌(목포)</strong></h3></div>
	<div id="tableWrap">
	
	<table id="amenitie_table"/>
		<tr>
			<th>편의시설명</th>
			<th>휴게소</th>
			<th>주유소</th>
		</tr>
		<tr>
			<td>수면실</td>
			<td><input type="checkbox" id=chk value="수면실/휴게소"></td>
			<td><input type="checkbox" id=chk value="수면실/주유소"></td>
		</tr>
	</table></br>
	<div id="btnWrap">
	<input type="button" value="확인" id="okBtn"/>
	</div>
	</div>
</div>
</body>
</html>