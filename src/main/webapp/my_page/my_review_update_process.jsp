<%@page import="prj2DAO.MyReviewDAO"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://localhost/RestArea_Project/main_page/main_page.jsp"/>
</c:if>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="mrVO" class="prj2VO.MyReviewVO" scope="page"/>
<jsp:setProperty property="*" name="mrVO"/>
<script type="text/javascript">
<%
try{
	//별점 받아서 값 설정
	String starStr = request.getParameter("star");
	double star = Double.parseDouble(starStr);
	mrVO.setStar(star);
	
	mrVO.setMemId(((LoginVO) session.getAttribute("loginData")).getMemId());
	MyReviewDAO mrDAO = MyReviewDAO.getInstance();
	
	int cnt = mrDAO.updateBoard(mrVO);
	int cntStar = mrDAO.updateStar(mrVO);
	if(cnt == 1 && cntStar == 1){
 		%> 
		alert("리뷰를 수정했습니다");
		location.href="../main_page/main_page.jsp?link=myPage&my=myReview&currentPage=${ param.currentPage }";
		<%
	}else{
 		%> 
		alert("리뷰 수정에 실패하였습니다.");
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
