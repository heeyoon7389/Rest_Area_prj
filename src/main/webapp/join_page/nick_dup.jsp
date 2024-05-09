<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.JoinMemDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>닉네임 중복 검사</title>
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
#dupResult{position: absolute; top: 275px; left: 60px}
#btns{position: absolute; font-size:19px; color: black; text-decoration: none; top: 50px; left: 120px;}
#btns strong{border:solid 2px #666666; border-radius: 7px; padding: 7px; background-color: #BEEFFF;}
</style>

<script type="text/javascript">
<!-- DB연동으로 중복확인 -->
<% 

request.setCharacterEncoding("UTF-8");
String paramnick = request.getParameter("nick");
if(paramnick != null){
	JoinMemDAO jmDAO = JoinMemDAO.getInstance();
	try{
		Boolean result = jmDAO.selectDupNick(paramnick);
// 		true면 중복, false면 사용가능
		if(result == false){
		} else{
			pageContext.setAttribute("flag", result);
		}
	}catch(SQLException e){
		e.printStackTrace();
	}//end catch
}
%>


// var reg = /^[A-z0-9]{5,12}$/; //nick : 5~12자 이내의 영대소문/숫자
// var ko_reg = /^[ㄱ-ㅎ가-힣a-zA-Z0-9]{5,12}$/; //nick: 한글가능할 때

//추가로 검색할 경우
function nickChk() { 
	var obj = document.board;
	var nick= obj.nick.value;
	var ko_reg = /^[ㄱ-ㅎ가-힣a-zA-Z0-9]{1,12}$/; //nick: 한글가능할 때
	if( nick == "" ){
		alert("닉네임 한글/영문/숫자 1~12자 이내로 입력해주세요.");
		obj.nick.value="";
		obj.nick.focus();
		return;
	} else if( !ko_reg.test(nick) ){
		alert("닉네임 한글/영문/숫자 1~12자 이내로 입력해주세요.");
		obj.nick.value="";
		obj.nick.focus();
		return;
	} else{
		obj.submit();
	}
}

function goSave() {
	$(opener.document).find("#nick").val($("#nick").val());
	$(opener.document).find("#nick").attr("readonly","readonly");

	$(opener.document).find("#loginChecked").val( $('#loginChecked').val() );
	window.close();
}
</script>

</head>
<body onload="document.board.nick.focus();">

<div id="wrap">

	<div id="member" class="idCheck_wrap">
		<div id="mpop">
			<form name="board" method="post" action="nick_dup.jsp">
					<h2>NickName CHECK<br> <span>닉네임 중복확인</span></h2>
					<p>사용하고자 하는 닉네임를 입력해주세요. <br />닉네임 중복확인 후 사용 가능한 닉네임로 선택해주세요.</p>
					<div class="bgBox">
						<dl class="conBox">
							<dd>
								<input type="text" id="nick" name="nick" maxlength="50" class="inw195" title="사용하실 닉네임을 입력주세요." value="${param.nick}" maxlength="20" />
								<input type="text" style="display: none"/>
							</dd>
							<dd>
								<input type="button" onclick="nickChk();" class="popcheckBtn btn btn-success" value="닉네임 중복확인" />
							</dd>
						</dl>
					</div>
			</form>
					<div id="dupResult">
						<c:if test="${ not empty param.nick }">
							입력하신 닉네임 [<strong><c:out value="${ param.nick }"/></strong>]는
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