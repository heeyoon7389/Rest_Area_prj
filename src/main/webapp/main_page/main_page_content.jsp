<%@page import="prj2VO.FAQAnnounceVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2DAO.FAQAnnounceDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="메인페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css">
    /* 검색창 스타일 */
    .search-container form {
        width: 100%;
    }
    /* 검색창 select 스타일 */
    .form-select{
    	width: 185px;
    }
    /* 검색 버튼 크기 조절 */
    .btn-primary {
        flex-shrink: 0;
        width: 100px;
        height: 65px;
    }
    
/*     더보기 마우스 커서 */
     span{cursor: pointer;} 
     
/*      이달의 맛집 높이 설정 */
    .set-height{height: 100%;}
     
/*      배너 위 공백 설정 */
     #myCarousel{margin-top: 25px;}
    
/*    배너 아래 이동버튼 색상 변경 */
	.carousel-indicators button {
    background-color: black !important;
	}
	
    /* 공지사항 & FAQ 위치 조정 */
    .col-md-6{
	 	margin-top: 25px; 
    }
    
</style>
<script type="text/javascript">
$(function(){
	$("#plus_FAQ").click(function(){
		alert("FAQ 더보기!!");
	});
	
	$("#plus_announce").click(function(){
		alert("공지사항 더보기!!");
	});
});//ready
</script>
<%
try{
	FAQAnnounceDAO faDAO = FAQAnnounceDAO.getInstance();
	List<FAQAnnounceVO> listFAQ = faDAO.selectFAQ();
	List<FAQAnnounceVO> listAn = faDAO.selectAn();
	pageContext.setAttribute("listFAQ", listFAQ);
	pageContext.setAttribute("listAn", listAn);
%>
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
    <!-- 메뉴바 끝-->
    <!-- 검색창 시작-->
    <div class="search-container">
        <form class="d-flex" role="search">
    		<select class="form-select" aria-label="고속도로 검색 유형">
  				<option value="1" selected>지역별</option>
  				<option value="2">휴게소별</option>
  				<option value="3">고속도로별</option>
			</select>
            <input class="form-control me-2" type="search" placeholder="찾으시는 휴게소를 검색해주세요" aria-label="Search">
            <button class="btn btn-primary" type="submit">검색</button>
        </form>
    </div>
    <!-- 검색창 끝-->
		<!-- 지도 시작 -->
		<div style="margin-top: 20px; margin-bottom: 30px;">
			<div id="map" style="width:1297px; height:525px; margin: 0 auto;"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d3586aeb6c2239e14526eef8de731f9"></script>
			<script type="text/javascript">
				var container = document.getElementById('map');//지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(37.499515, 127.033212),//지도의 중심좌표.
				level: 10 //지도의 레벨(확대, 축소 정도)
				};

				var map = new kakao.maps.Map(container, options);//지도 생성 및 객체 리턴
				
				// 마커가 표시될 위치입니다 
				var markerPosition  = new kakao.maps.LatLng(37.499515, 127.033212); 

				// 마커를 생성합니다
				var marker = new kakao.maps.Marker({
				    position: markerPosition
				});

				// 마커가 지도 위에 표시되도록 설정합니다
				marker.setMap(map);
			</script>
		</div>
		<!-- 지도 끝 -->
		<!-- 아이콘 바 시작 -->
	<div class="row g-1 row-cols-lg-4" style="border: 1px solid #333;">
      <div class="feature col" style="padding: 10px;">
      <div style="text-align: center; padding-top: 17px">
        <a href="#void" style="text-decoration: none; color: black;">
        <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3" style="border-radius: 10px;">
          <svg class="bi" width="2em" height="2em">
          	<svg xmlns="http://www.w3.org/2000/svg" width="90%" height="90%" fill="currentColor" class="bi bi-map-fill" viewBox="-3 -3 20 20">
  				<path fill-rule="evenodd" d="M16 .5a.5.5 0 0 0-.598-.49L10.5.99 5.598.01a.5.5 0 0 0-.196 0l-5 1A.5.5 0 0 0 0 1.5v14a.5.5 0 0 0 .598.49l4.902-.98 4.902.98a.5.5 0 0 0 .196 0l5-1A.5.5 0 0 0 16 14.5zM5 14.09V1.11l.5-.1.5.1v12.98l-.402-.08a.5.5 0 0 0-.196 0zm5 .8V1.91l.402.08a.5.5 0 0 0 .196 0L11 1.91v12.98l-.5.1z"/>
			</svg>
		  </svg>
        </div>
        <h3 class="fs-3 fw-medium">지도보기</h3>
        </a>
      </div>
      </div>
      <div class="feature col" style="padding: 10px;">
      <div style="text-align: center; padding-top: 17px">
      <a href="#void" style="text-decoration: none; color: black;">
        <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3" style="border-radius: 10px;">
          <svg class="bi" width="2em" height="2em">
          	<svg xmlns="http://www.w3.org/2000/svg" width="90%" height="90%" fill="currentColor" class="bi bi-house-exclamation-fill" viewBox="-3 -3 20 20">
  				<path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293z"/>
  				<path d="m8 3.293 4.712 4.712A4.5 4.5 0 0 0 8.758 15H3.5A1.5 1.5 0 0 1 2 13.5V9.293z"/>
  				<path d="M16 12.5a3.5 3.5 0 1 1-7 0 3.5 3.5 0 0 1 7 0m-3.5-2a.5.5 0 0 0-.5.5v1.5a.5.5 0 1 0 1 0V11a.5.5 0 0 0-.5-.5m0 4a.5.5 0 1 0 0-1 .5.5 0 0 0 0 1"/>
			</svg>
		  </svg>
        </div>
        <h3 class="fs-3 fw-medium">휴게소안내</h3>
        </a>
      </div>
      </div>
      <div class="feature col" style="padding: 10px;">
      <div style="text-align: center; padding-top: 17px">
      <a href="#void" style="text-decoration: none; color: black;">
        <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3" style="border-radius: 10px;">
          <svg class="bi" width="2em" height="2em">
          	<svg xmlns="http://www.w3.org/2000/svg" width="90%" height="90%" fill="currentColor" class="bi bi-sign-turn-slight-right-fill" viewBox="-3 -3 20 20">
  				<path d="M6.95.435c.58-.58 1.52-.58 2.1 0l6.515 6.516c.58.58.58 1.519 0 2.098L9.05 15.565c-.58.58-1.519.58-2.098 0L.435 9.05a1.48 1.48 0 0 1 0-2.098zm1.385 6.547.8 1.386a.25.25 0 0 0 .451-.039l1.06-2.882a.25.25 0 0 0-.192-.333l-3.026-.523a.25.25 0 0 0-.26.371l.667 1.154-.621.373A2.5 2.5 0 0 0 6 8.632V11h1V8.632a1.5 1.5 0 0 1 .728-1.286z"/>
			</svg>
		  </svg>
        </div>
        <h3 class="fs-3 fw-medium">고속도로</h3>
        </a>
      </div>
      </div>
      <div class="feature col" style="padding: 10px;">
      <div style="text-align: center; padding-top: 17px">
      <a href="#void" style="text-decoration: none; color: black;">
        <div class="feature-icon d-inline-flex align-items-center justify-content-center text-bg-primary bg-gradient fs-2 mb-3" style="border-radius: 10px;">
          <svg class="bi" width="2em" height="2em">
          	<svg xmlns="http://www.w3.org/2000/svg" width="90%" height="90%" fill="currentColor" class="bi bi-question-circle-fill" viewBox="-3 -3 20 20">
  				<path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M5.496 6.033h.825c.138 0 .248-.113.266-.25.09-.656.54-1.134 1.342-1.134.686 0 1.314.343 1.314 1.168 0 .635-.374.927-.965 1.371-.673.489-1.206 1.06-1.168 1.987l.003.217a.25.25 0 0 0 .25.246h.811a.25.25 0 0 0 .25-.25v-.105c0-.718.273-.927 1.01-1.486.609-.463 1.244-.977 1.244-2.056 0-1.511-1.276-2.241-2.673-2.241-1.267 0-2.655.59-2.75 2.286a.237.237 0 0 0 .241.247m2.325 6.443c.61 0 1.029-.394 1.029-.927 0-.552-.42-.94-1.029-.94-.584 0-1.009.388-1.009.94 0 .533.425.927 1.01.927z"/>
			</svg>
		  </svg>
        </div>
        <h3 class="fs-3 fw-medium">자주묻는질문</h3>
        </a>
      </div>
      </div>
      </div>
		<!-- 아이콘 바 끝 -->
 <!-- 	사이트 광고 배너 시작 -->
    <div id="myCarousel" class="carousel slide mb-6" data-bs-ride="carousel">
        <!-- 하단이동버튼 시작 -->
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="0" class="active" aria-label="Slide 1" aria-current="true"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="1" class="" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#myCarousel" data-bs-slide-to="2" class="" aria-label="Slide 3"></button>
        </div>
        <!-- 하단이동버튼 끝 -->
        <div class="carousel-inner">
            <div class="carousel-item active">
            	<a href="https://www.kpetro.or.kr/index.dos" target="_blank">
					<svg width="1297" height="300" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        				<image xlink:href="../images/Kpetro.jpg" width="100%" height="100%" />
    				</svg>
    			</a>
            </div>
            <div class="carousel-item">
            	<a href="https://www.oilbankcard.com/card2012/main.do" target="_blank">
					<svg width="1297" height="300" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        				<image xlink:href="../images/oilbankcard.jpg" width="100%" height="100%" />
    				</svg>
    			</a>
            </div>
            <div class="carousel-item">
            	<a href="https://www.s-oilbonus.com/main" target="_blank">
					<svg width="1297" height="300" xmlns="http://www.w3.org/2000/svg" aria-hidden="true" preserveAspectRatio="xMidYMid slice" focusable="false">
        				<image xlink:href="../images/s-oilbonus.jpg" width="100%" height="100%" />
    				</svg>
    			</a>
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#myCarousel" data-bs-slide="prev">
        	<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="black" class="bi bi-chevron-left" viewBox="0 0 16 16">
  			<path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0"/>
			</svg>
            <span class="visually-hidden">앞으로</span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#myCarousel" data-bs-slide="next">
        	<svg xmlns="http://www.w3.org/2000/svg" width="50" height="50" fill="black" class="bi bi-chevron-right" viewBox="0 0 16 16">
  			<path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
			</svg>
            <span class="visually-hidden">뒤로</span>
        </button>
    </div>
    <!-- 	사이트 광고 배너 끝 -->
    <!-- 공지사항&FAQ 시작 -->
    <div class="row">
        <!-- FAQ 시작 -->
        <div class="col-md-6">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" class="text-start">FAQ <span id="plus_FAQ" class="float-end">더보기+</span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="faVO" items="${ listFAQ }" varStatus="i">
                <tr>
                    <th scope="row"><c:out value="${i.count}"/></th>
                    <td colspan="3">
                    <a href="#void" style="text-decoration:none; color: black;">
                    <c:out value="${ faVO.QStr }"/>
      				</a>
                    </td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- FAQ 끝 -->
        <!-- 공지사항 시작 -->
        <div class="col-md-6">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th scope="col">#</th>
                    <th scope="col" colspan="3">공지사항</th>
                    <th scope="col">입력일 <span id="plus_announce" class="float-end">더보기+</span></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="faVO" items="${ listAn }" varStatus="i">
                <tr>
                    <th scope="row"><c:out value="${i.count}"/></th>
                    <td colspan="3">
                    <a href="#void" style="text-decoration:none; color: black;">
                    <c:out value="${ faVO.title }"/>
      				</a>
                    </td>
                    <td><c:out value="${ faVO.inputDate }"/></td>
                </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
        <!-- 공지사항 끝 -->
    </div>
    <!-- 공지사항&FAQ 끝 -->
<%
}catch(SQLException e){
	e.printStackTrace();
}//end catch
%>
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
