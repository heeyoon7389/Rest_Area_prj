<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.JoinMemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 중복 검사</title>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<!-- sist스타일시트 -->
<link rel="stylesheet" href="https://www.sist.co.kr/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="https://www.sist.co.kr/css/board.css" type="text/css" media="all" />
<!-- sist스타일시트 -->

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
#dupResult{position: absolute; top: 250px; left: 60px}
#btns{position: absolute; font-size:19px; color: black; text-decoration: none; top: 50px; left: 120px;}
#btns strong{border:solid 2px #666666; border-radius: 7px; padding: 7px; background-color: #BEEFFF;}
</style>

<script type="text/javascript">
<!-- DB연동으로 중복확인 -->
<% 
String paramId = request.getParameter("id");
if(paramId != null){
	JoinMemDAO jmDAO = JoinMemDAO.getInstance();
	try{
		Boolean result = jmDAO.selectDupId(paramId);
// 		true면 중복, false면 사용가능
		if(result == false){
			
		} else{
			pageContext.setAttribute("flag", result);
		}
	}catch(SQLException e){
		e.printStackTrace();
		out.println("죄송합니다. 잠시후 다시 시도해주세요.");
	}//end catch
}
%>

// var reg = /^[A-z0-9]{5,12}$/; //id : 5~12자 이내의 영대소문/숫자
// var ko_reg = /^[ㄱ-ㅎ가-힣a-zA-Z0-9]{5,12}$/; //id: 한글가능할 때

//추가로 검색할 경우
function idChk() { 
	var obj = document.board;
	var id= obj.id.value;
	var reg = /^[A-z0-9]{5,12}$/;//영문/숫자 5~12자 이내인지 확인
	if( id == "" ){
		alert("아이디를 영문/숫자 5~12자 이내로 입력해주세요.");
		obj.id.value="";
		obj.id.focus();
		return;
	} else if( !reg.test(id) ){
		alert("아이디를 영문/숫자 5~12자 이내로 입력해주세요.");
		obj.id.value="";
		obj.id.focus();
		return;
	} else{
		obj.submit();
	}
}

function goSave() {
	$(opener.document).find("#id").val($("#id").val());
	$(opener.document).find("#id").attr("readonly","readonly");

	$(opener.document).find("#loginChecked").val( $('#loginChecked').val() );
	window.close();
}
</script>

</head>
<body onload="document.board.id.focus();">

<div id="wrap">
	<div id="member" class="idCheck_wrap">
		<div id="mpop">
			<form name="board" method="post" action="id_dup.jsp">
					<h2>ID CHECK <span>아이디 중복확인</span></h2>
					<p>사용하고자 하는 아이디를 입력해주세요. <br />아이디 중복확인 후 사용 가능한 아이디로 선택해주세요.</p>
					<div class="bgBox">
						<dl class="conBox">
							<dd>
								<input type="text" id="id" name="id" maxlength="50" class="inw195" title="사용하실 아이디를 입력주세요." value="${param.id}" maxlength="20" />
								<input type="text" style="display: none"/>
							</dd>
							<dd>
								<input type="button" onclick="idChk();" class="popcheckBtn btn btn-success" value="ID 중복확인" />
							</dd>
						</dl>
					</div>
			</form>
					<div id="dupResult">
						<c:if test="${ not empty param.id }">
							입력하신 아이디 [<strong><c:out value="${ param.id }"/></strong>]는
						<c:choose>
							<c:when test="${ pageScope.flag }">
								사용<strong style="color:#E53E30"> 불가능</strong>합니다.
							</c:when>
							<c:otherwise>
								사용 <strong style="color:#0055FF">가능</strong> 합니다.<br>
								<a id="btns" href="#" onclick="goSave();"><strong>사용하기</strong></a>
							</c:otherwise>
						</c:choose>
						</c:if>
					</div>
				<input type="hidden" id="loginChecked" value="true" />
		</div>
		<!-- //mpop -->
	</div>
	<!-- //member -->
</div>
</body>
</html>