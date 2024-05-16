<%@page import="prj2VO.LoginVO"%>
<%@page import="restAreaInquiry.InquiryDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="글 쓰기 DB 추가 페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://localhost/Rest_Area_prj/main_page/main_page.jsp"/>
</c:if>

<style type="text/css">
	
</style>
<% request.setCharacterEncoding("UTF-8"); %>
<!--  parameter 받기 -->
<jsp:useBean id="idVO" class="restAreaInquiry.InquirydetailVO" scope="page"/>
<jsp:setProperty property="*" name="idVO"/>
<script type="text/javascript">
	
	<%
	try{
		//아이디는 세션에 저장된 값을 받아서 설정.( 외부에서 조작 불가 )
	idVO.setMemid(((LoginVO)session.getAttribute("loginData")).getMemId());	
		
	InquiryDAO iDAO=InquiryDAO.getInstance();
	iDAO.insertInquiry(idVO);
	%>
	alert("글을 작성하였습니다.");
	location.href="../main_page/main_page.jsp?link=inquiry";
	<%
	
	}catch(SQLException se){
		se.printStackTrace();
		%>
		location.href="../common/err_500.html";
		<%
	}//end catch
	
	%>
	
</script>