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

if (searchType.equals("1")) {
    // 지역별 검색 처리
%>
<!-- 지역별 검색 결과 출력 -->
<div>지역별 검색 결과</div>
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
                        <image href="images/bugger.png" width="200" height="250" />
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
            url: 'highway_handler.jsp',
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
});
</script>
