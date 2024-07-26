<%@page import="prj2DAO.MyInquiryDAO"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://localhost/Rest_Area_prj/main_page/main_page.jsp"/>
</c:if>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="miVO" class="prj2VO.MyInquiryVO" scope="page"/>
<jsp:setProperty property="*" name="miVO"/>
<script type="text/javascript">
<%
try{
	miVO.setMemId(((LoginVO) session.getAttribute("loginData")).getMemId());
	MyInquiryDAO miDAO = MyInquiryDAO.getInstance();
	
	int cnt = miDAO.updateBoard(miVO);
	if(cnt == 1){
		%>
		alert("문의를 수정했습니다");
		location.href="../main_page/main_page.jsp?link=myPage&my=myInquiry&currentPage=${ param.currentPage }";
		<%
	}else{
		%>
		alert("문의 삭제에 실패하였습니다.");
		history.back();
		<%
	}//end else
}catch(SQLException e){
	e.printStackTrace();
	%>
	alert("죄송합니다. 잠시후 다시 시도해주세요.");
	location.href="../main_page/main_page.jsp";
	<%
}//end catch
%>
</script>
