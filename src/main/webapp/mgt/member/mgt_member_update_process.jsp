<%@page import="prj2.mgt.manageMember.dao.MgtMemberDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page import="prj2.mgt.manageMember.vo.MemberVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 - 회원관리 - 회원 상세 - 회원 활동정지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%>

<!-- 로그인 세션 없으면 리다이렉트 -->
<c:if test="${empty sessionScope.loginData2 }"><c:redirect url="http://192.168.10.214/Rest_Area_prj/mgt/login/mgt_login_frm.jsp" /></c:if>
<!-- 로그인 세션 없으면 리다이렉트 -->


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>

<!-- 파라미터 받기 -->
<jsp:useBean id="mVO" class="prj2.mgt.manageMember.vo.MemberVO" scope="page"></jsp:useBean>
<jsp:setProperty property="*" name="mVO"/>

<script type="text/javascript">
	<%
	try {
		MgtMemberDAO mmDAO = MgtMemberDAO.getInstance();
		int cnt = mmDAO.updateMemberSuspend(mVO.getMemId(), !mVO.isSuspendFlag());
		switch (cnt) {
		case 1:
 			if(mVO.isSuspendFlag()){ 
 		%>
				alert('회원의 정지가 해제되었습니다');
		<%
 			} else {
		%>
				alert('회원이 정지되었습니다');
		<%
 			}// end else
 		%>
			location.href = "mgt_member_detail_frm.jsp?rnum=${param.rnum}&memId=${param.memId}&currentPage=${param.currentPage}";
 		<%
 			break;
 		default:
 		%>
 			alert('문제가 발생했습니다');
 			window.opener.location.reload();
			window.close();
		<%
		} // end case
	} catch (SQLException se) {
		se.printStackTrace();
 		%> 
		alert('문제가 발생하였습니다');
		history.back();
		<%
	} // end catch
		
 	%>
</script>
</head>
<body>

<div>

</div>

</body>
</html>