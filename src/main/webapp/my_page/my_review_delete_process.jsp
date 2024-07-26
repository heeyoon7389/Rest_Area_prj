<%@page import="prj2DAO.MyReviewDAO"%>
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
<jsp:useBean id="mrVO" class="prj2VO.MyReviewVO" scope="page"/>
<jsp:setProperty property="*" name="mrVO"/>
<script type="text/javascript">
<%
try{
	mrVO.setMemId(((LoginVO) session.getAttribute("loginData")).getMemId());
	MyReviewDAO mrDAO = MyReviewDAO.getInstance();
	//몇 건이 변경되었는지
	int cnt = mrDAO.updateDeleteFlag(mrVO); 
	int cntStar = mrDAO.deleteStar(mrVO);
	if( cnt == 1 && cntStar == 1){
		%>
		alert("리뷰를 삭제했습니다");
		location.href="../main_page/main_page.jsp?link=myPage&my=myReview&currentPage=${ param.currentPage }";
		<%
	}else{
		%>
		alert("리뷰 삭제에 실패했습니다");
		history.back();
		<%
	}//end else
}catch(SQLException e){
	e.printStackTrace();
	%>
	alert("죄송합니다. 잠시후 다시 시도해주세요.");
	location.href="../main_page/main_page.jsp";
	<%
}
%>
</script>