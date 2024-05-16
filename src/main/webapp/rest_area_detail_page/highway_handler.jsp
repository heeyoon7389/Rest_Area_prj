<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="searchRestArea.SearchRestAreaDAO"%>
<%@ page import="searchRestArea.RouteVO"%>
<%@ page import="java.util.List"%>

<%
String routeId = request.getParameter("routeId");
SearchRestAreaDAO sraDAO = SearchRestAreaDAO.getInstance();
List<RouteVO> routeList = null;


    routeList = sraDAO.searchByRoute(routeId);

%>
<div class="container">
    <div class="row">
        <%
        if (routeList != null && !routeList.isEmpty()) {
            for (RouteVO route : routeList) {
        %>
        <div class="col-md-12">
            <div class="row g-0 border rounded overflow-hidden flex-md-row mb-4 shadow-sm position-relative">
                <div class="col p-4 d-flex flex-column position-static">
                    <div class="mb-0 rest_area_link">
                        <a href="#"><span data-lat="<%= route.getRestAreaLatitude() %>" data-lng="<%= route.getRestAreaLongitude() %>"></span><%= route.getRaName() %></a>
                    </div>
                    <div class="mb-1 text-body-secondary"><%= route.getRaAddr() %></div>
                    <p class="mb-auto">전화번호: <%= route.getRaTel() %></p>
                    <div class="rest_area_detail">
                        <a href="rest_area_detail_page.jsp?raNum=<%= route.getRaNum() %>&raName=<%= route.getRaName() %>&addr=<%= route.getRaAddr() %>" class="icon-link gap-1 icon-link-hover stretched-link">
                            <%= route.getRaName() %> 상세페이지
                        </a>
                    </div>
                </div>
                <div class="col-auto d-none d-lg-block">
                    <img src="images/bugger.png" width="200" height="250" />
                </div>
            </div>
        </div>
        <%
            }
        } else {
        %>
        <div class="col-md-12">
            <p>해당 고속도로에 휴게소가 없습니다.</p>
        </div>
        <%
        }
        %>
    </div>
</div>
