<%@page import="restAreaStore.RestAreaStoreDAO"%>
<%@page import="restAreaStore.RestAreaStoreVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" info="" %>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<div class="store_info">
    <!-- ///////////////////////////매장 정보 시작///////////////////////////////// -->
    <%
    String raNum = request.getParameter("raNum");
    List<RestAreaStoreVO> storeList = null;
    RestAreaStoreDAO rsDAO = RestAreaStoreDAO.getInstance();
    storeList = rsDAO.selectStore(raNum);
    RestAreaStoreVO rsVO = null;
    %>
    <%
    for (int i = 0; i < storeList.size(); i++) {
        rsVO = storeList.get(i);
    %>
    <div class="store_detail" style="margin-right: 20px; margin-bottom: 20px; display: flex; align-items: center;">
        <img src="images/<%=rsVO.getStoreImg()%>" alt="avatar" style="width: 100px; height: 100px; margin-right: 10px; top: 0;">
        <div class="store_info">
            <a href="javascript:void(0);" class="menu_detail_link">
                <h3 style="margin: 0;">
                    <span data-value="<%=rsVO.getStoreNum()%>"><%=rsVO.getStoreName()%></span>
                </h3>
            </a>
            <p style="margin: 0;"><%=rsVO.getStoreNote()%></p>
        </div>
        <div class="store_rep" style="margin-left: auto; position: relative; bottom: 0;">
            <a href="javascript:void(0);" class="report_link"><span data-value="<%=rsVO.getStoreNum()%>">신고하기</span></a>
        </div>
    </div>
    <%
    }
    %>
</div>
<!-- /////////////////////////////////매장 정보 끝////////////////////////////////// -->
