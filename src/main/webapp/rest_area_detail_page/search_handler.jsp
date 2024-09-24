<%@page import="location.LocationVO"%>
<%@page import="location.LocationDAO"%>
<%@page import="searchRestArea.RouteVO"%>
<%@page import="highway.HighwayDAO"%>
<%@page import="highway.HighwayVO"%>
<%@page import="searchRestArea.SearchRestAreaDAO"%>
<%@page import="searchRestArea.RestAreaNameVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
String searchType = request.getParameter("search-type");
String searchValue = request.getParameter("search-query");
SearchRestAreaDAO sraDAO = SearchRestAreaDAO.getInstance();
List<RestAreaNameVO> searchNameList = null;
%>
<%
if (searchType.equals("1")) {
	List<LocationVO>lcList = null;
	LocationDAO lcDAO = LocationDAO.getInstance();
	lcList = lcDAO.selectAllLocation();
    // 지역별 검색 처리
%>
<!-- 지역별 검색 결과 출력 -->
<div class="col-md-12">
    <div class="row">
        <div class="col-md-6">
            <table>
                <%
                for (LocationVO lcVO : lcList) {
                %>
                <tr>
                    <th><input type="button" data-value="<%=lcVO.getLocNum()%>" class="location_content btn btn-light" value="<%=lcVO.getLocationName()%>"></th>
                </tr>
                <%
                }
                %>
            </table>
        </div>
        <div class="col-md-6" style="overflow:auto;">
            <div id="restAreaListByLocation">
                <!-- 휴게소 정보를 여기에 로드 -->
            </div>
        </div>
    </div>
<%
} else if (searchType.equals("2")) {
    // 휴게소 이름별 검색 처리
    searchNameList = sraDAO.searchByRaName(searchValue);
%>
<!-- 휴게소 이름별 검색 결과 출력 -->
<%
    for (RestAreaNameVO ranVO : searchNameList) {
%>
<div class="col-md-12">
    <div class="row">
        <div class="col-md-12">
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm position-relative">
                <div id="rest_area_name" class="col p-4 d-flex flex-column position-static">
                    <div class="mb-0 rest_area_link">
                        <a href="#"><span data-lat="<%=ranVO.getLatitude()%>" data-lng="<%=ranVO.getLongitude()%>"></span><%=ranVO.getRaName()%></a>
                    </div>
                    <div class="mb-1 text-body-secondary"><%=ranVO.getRaAddr()%></div>
                    <p class="mb-auto">전화번호 <br><%=ranVO.getRaTel()%></p>
                    <div class="rest_area_detail">
                        <a href="http://localhost/Rest_Area_prj/rest_area_detail_page/rest_area_detail_page.jsp?raNum=<%=ranVO.getRaNum()%>&raName=<%=ranVO.getRaName()%>&addr=<%=ranVO.getRaAddr()%>" class="icon-link gap-1 icon-link-hover stretched-link">
                            <%=ranVO.getRaName()%> 상세페이지
                            <svg class="bi"><use xlink:href="#chevron-right"></use></svg>
                        </a>
                    </div>
                </div>
                <div class="col-auto d-none d-lg-block">
                    <svg class="bd-placeholder-img" width="200" height="250" xmlns="http://www.w3.org/2000/svg" role="img" aria-label="Placeholder: Thumbnail" preserveAspectRatio="xMidYMid slice" focusable="false">
                                            <svg xmlns="http://www.w3.org/2000/svg" width="200" height="250" fill="currentColor" class="bi bi-shop" viewBox="0 0 16 16">
  <path d="M2.97 1.35A1 1 0 0 1 3.73 1h8.54a1 1 0 0 1 .76.35l2.609 3.044A1.5 1.5 0 0 1 16 5.37v.255a2.375 2.375 0 0 1-4.25 1.458A2.37 2.37 0 0 1 9.875 8 2.37 2.37 0 0 1 8 7.083 2.37 2.37 0 0 1 6.125 8a2.37 2.37 0 0 1-1.875-.917A2.375 2.375 0 0 1 0 5.625V5.37a1.5 1.5 0 0 1 .361-.976zm1.78 4.275a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0 1.375 1.375 0 1 0 2.75 0V5.37a.5.5 0 0 0-.12-.325L12.27 2H3.73L1.12 5.045A.5.5 0 0 0 1 5.37v.255a1.375 1.375 0 0 0 2.75 0 .5.5 0 0 1 1 0M1.5 8.5A.5.5 0 0 1 2 9v6h1v-5a1 1 0 0 1 1-1h3a1 1 0 0 1 1 1v5h6V9a.5.5 0 0 1 1 0v6h.5a.5.5 0 0 1 0 1H.5a.5.5 0 0 1 0-1H1V9a.5.5 0 0 1 .5-.5M4 15h3v-5H4zm5-5a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1v3a1 1 0 0 1-1 1h-2a1 1 0 0 1-1-1zm3 0h-2v3h2z"/>
					</svg>
                    </svg>
                </div>
            </div>
        </div>
    </div>
</div>
<%
    }
} else if (searchType.equals("3")) {
    // 고속도로별 검색 처리
    List<HighwayVO> hwList = null;
    HighwayDAO hwDAO = HighwayDAO.getInstance();
    hwList = hwDAO.selectAllHighway();
%>
<!-- 고속도로별 검색 결과 출력 -->
<div class="col-md-12">
    <div class="row">
        <div class="col-md-6">
            <table>
                <%
                for (HighwayVO hwVO : hwList) {
                %>
                <tr>
                    <th><input type="button" data-value="<%=hwVO.getRouteId()%>" class="route_content btn btn-light" value="<%=hwVO.getHighwayName()%>"></th>
                </tr>
                <%
                }
                %>
            </table>
        </div>
        <div class="col-md-6" style="overflow:auto;">
            <div id="restAreaList">
                <!-- 휴게소 정보를 여기에 로드 -->
            </div>
        </div>
    </div>
</div>
<%
}
%>
<script type="text/javascript">
$(document).ready(function() {
    // 고속도로 버튼 클릭 이벤트
    $(document).on('click', '.route_content', function() {
        var routeId = $(this).data('value');

        // AJAX 요청
        $.ajax({
            url: '../rest_area_detail_page/highway_handler.jsp',
            type: 'GET',
            data: {
                'routeId': routeId
            },
            success: function(data) {
                $('#restAreaList').html(data);
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
                alert('휴게소 정보를 불러오는 데 실패했습니다. 다시 시도해 주세요.');
            }
        });
    });
    
    $(document).on('click', '.location_content', function(){
    	var locNum = $(this).data('value');
    	$.ajax({
    		url: '../rest_area_detail_page/location_handler.jsp',
    		type: 'GET',
    		data: {
    			'locNum':locNum
    		},
    		success: function(data) {
    			$('#restAreaListByLocation').html(data);
    		},
    		error: function(xhr, status, error) {
    			console.err('AJAX 못 불러옴:', status, error);
    			aler('휴게소 없음');
    		}
    	});
    });
});
</script>
