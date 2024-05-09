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
	<!-- 지도 & 이달의 맛집 시작 -->
    <div class="row">
		<!-- 지도 시작 -->
		<div class="col-md-6">
			<div id="map" style="width:644px; height:525px"></div>
			<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=8d3586aeb6c2239e14526eef8de731f9"></script>
			<script type="text/javascript">
				var container = document.getElementById('map');//지도를 담을 영역의 DOM 레퍼런스
				var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(37.499515, 127.033212),//지도의 중심좌표.
				level: 3 //지도의 레벨(확대, 축소 정도)
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
		<!-- 이달의 맛집 시작 -->
		<div class="col-md-6">
    		<div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative set-height">
        		<div class="col p-4 d-flex flex-column position-static">
            		<strong class="d-inline-block mb-2 text-success-emphasis">이달의 맛집</strong>
            		<h3 class="mb-0">얼큰한 선지해장국</h3>
            		<div class="mb-1 text-body-secondary">강남휴게소</div>
            		<p class="mb-auto">지금까지 이런 맛을 없었다!! <br> 앞으로도 없을 것 같은 맛!!</p>
            		<a href="#" class="icon-link gap-1 icon-link-hover stretched-link">
                		강남휴게소 바로가기
                		<svg class="bi"><use xlink:href="#chevron-right"></use></svg>
            		</a>
        		</div>
        		<div class="col-auto d-none d-lg-block">
            		<svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
                		<image href="../images/sunji2.png" width="200" height="250" />
            		</svg>
        		</div>
    		</div>
		</div>
		<!-- 이달의 맛집 끝 -->
	</div>
	<!-- 지도 & 이달의 맛집 끝-->
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
            <table class="table">
                <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col" class="text-start">FAQ <span id="plus_FAQ" class="float-end">더보기+</span></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td colspan="3">휴게소 상세정보가 알고 싶어요</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
                </tr>
                <tr>
                    <th scope="row">4</th>
                    <td colspan="3">휴게소 상세정보가 알고 싶어요</td>
                </tr>
                <tr>
                    <th scope="row">5</th>
                    <td colspan="3">이 휴게소 사이트는 언제 끝나나요</td>
                </tr>
                <tr>
                    <th scope="row">6</th>
                    <td colspan="3">회원탈퇴 하는 법을 알려주세요</td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- FAQ 끝 -->
        <!-- 공지사항 시작 -->
        <div class="col-md-6">
            <table class="table">
                <thead>
                <tr>
                    <th scope="col"></th>
                    <th scope="col" colspan="2">공지사항</th>
                    <th scope="col">입력일 <span id="plus_announce" class="float-end">더보기+</span></th>
                </tr>
                </thead>
                <tbody>
                <tr>
                    <th scope="row">1</th>
                    <td colspan="2">댕 큰 공지사항이 있어요</td>
                    <td>2024-12-32</td>
                </tr>
                <tr>
                    <th scope="row">2</th>
                    <td colspan="2">조금 작은 공지사항이 있어요</td>
                    <td>2024-13-01</td>
                </tr>
                <tr>
                    <th scope="row">3</th>
                    <td colspan="2">암튼 공지사항이 있어요</td>
                    <td>2024-01-33</td>
                </tr>
                <tr>
                    <th scope="row">4</th>
                    <td colspan="2">댕 큰 공지사항이 있어요</td>
                    <td>2024-12-32</td>
                </tr>
                <tr>
                    <th scope="row">5</th>
                    <td colspan="2">조금 작은 공지사항이 있어요</td>
                    <td>2024-13-01</td>
                </tr>
                <tr>
                    <th scope="row">6</th>
                    <td colspan="2">암튼 공지사항이 있어요</td>
                    <td>2024-01-33</td>
                </tr>
                </tbody>
            </table>
        </div>
        <!-- 공지사항 끝 -->
    </div>
    <!-- 공지사항&FAQ 끝 -->
<!-- ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->
