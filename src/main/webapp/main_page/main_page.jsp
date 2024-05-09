<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="메인페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>고속도로 휴게소</title>
<link rel="icon" href="http://192.168.10.218/jsp_prj/common/favicon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<link rel="stylesheet" href="http://192.168.10.218/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.218/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
/* ///////////////////공통부분 시작/////////////////// */
    /* 네비게이션 바 스타일 */
    .nav-item {
       margin-top: 15px;
    }
        
    #user_login{cursor: pointer;}
/* ///////////////////공통부분 끝/////////////////// */    
</style>

<script type="text/javascript">
	$(function(){
		//////////////////////////////////////////////////////////////////////////
		$("#user_login").click(function(){
			window.open("../login_page/login.jsp", "login", "width=600, height=515, top="+
					(window.screenY+150)+", left="+(window.screenX+150));
		});
		/////////////////////////////////////////////////////////////////////////
		$("#logout").click(function() {
			location.href="../login_page/logout.jsp"
		});
		
		$("#plus_FAQ").click(function(){
			alert("FAQ 더보기!!");
		});
		$("#plus_announce").click(function(){
			alert("공지사항 더보기!!");
		});
		
	});//ready
	
	function winReload( ){
	
	location.href="../main_page/main_page.jsp";
	}
	
</script>

</head>
<body>
<!-- 메인 페이지 시작 -->
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
<div class="container">
    <!-- 메뉴바 시작-->
    <header id="header1" class="d-flex flex-wrap justify-content-center py-3 mb-4 border-bottom">
        <a href="main_page.jsp?link=logo" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto link-body-emphasis text-decoration-none">
            <img src="https://data.ex.co.kr/images/common/logo.png">
            <span class="fs-4">고속도로 휴게소</span>
        </a>
<!--         로그인 전 -->
    <c:if test="${ empty sessionScope.loginData.memId }">
        <ul class="nav justify-content-end">
            <li class="nav-item">
                <a class="nav-link" id="user_login">로그인</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="main_page.jsp?link=join">회원가입</a>
            </li>
        </ul>
    </c:if>
<!--     로그인 후 -->
	<c:if test="${ not empty sessionScope.loginData.memId }">
        <ul class="nav justify-content-end">
            <li class="nav-item">
                <a class="nav-link">환영합니다, <c:out value="${ sessionScope.loginData.nick }"/>님</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="main_page.jsp?link=myPage">마이페이지</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">문의</a>
            </li>
            <li class="nav-item">
                <a href="../login_page/logout.jsp" class="nav-link">로그아웃</a>
            </li>
        </ul>
    </c:if>
    </header>
<!-- ////////////////////////////////여기에 내용 넣기////////////////////////////////////////////////////////////////////////////// -->
<div>
<!-- 기본값 설정 -->
<c:if test="${ empty param.link }">
<c:import url="main_page_content.jsp"/>
</c:if>
<!-- include될 jsp 지정 -->
<c:if test="${ not empty param.link }">
	<c:choose>
		<c:when test="${ param.link eq 'logo' }"><!-- 	로고 클릭 시 -->
		<c:import url="main_page_content.jsp"/>
		</c:when>
 		<c:when test="${ param.link eq 'join' }"><!-- 	회원가입 클릭 시 --> 
		<c:import url="../join_page/mem_join.jsp"/> 
 		</c:when> 
		<c:when test="${ param.link eq 'searchIdPass' }"><!-- 	아이디/비밀번호 클릭 시 -->
		<c:import url="../login_page/search_id_pass.jsp"/>
		</c:when>
		<c:when test="${ param.link eq 'myPage' }"><!-- 	마이페이지 클릭 시 -->
		<c:import url="../my_page/my_page.jsp"/>
		</c:when>
	</c:choose>
</c:if>
<!-- 	v로고, v아이디비번, v회원가입, 공지사항, faq, 맛집, v마이페이지, 문의 	 -->
</div>



<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
    <!-- 제작&저작권 시작 -->
    <footer class="py-5 text-center text-body-secondary bg-white">
  		<p>&copy;고속도로 휴게소 제작 by 4조.</p>
  		<p class="mb-0">
    	<a href="#">상단으로 올라가기</a>
  		</p>
	</footer>
<!-- 제작&저작권 끝 -->
    <!-- 메인 페이지 끝 -->
</div>
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
</body>
</html>