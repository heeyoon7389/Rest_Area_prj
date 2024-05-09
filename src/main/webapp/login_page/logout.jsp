<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
session.removeAttribute("loginData");
%>
<script type="text/javascript">
alert("로그아웃 되었습니다.");
location.href="../main_page/main_page.jsp";

</script>