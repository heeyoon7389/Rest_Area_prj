<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="세션이 없으면 로그인 페이지로 리다이렉트"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>

<c:if test="${empty sessionScope.loginData2 }">
	<c:redirect url="http://192.168.10.214/Rest_Area_prj/mgt/index.html" />
</c:if>