<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="prj2.mgt.manageMember.vo.MemberVO"%>
<%@page import="prj2.mgt.manageMember.dao.MgtMemberDAO"%>
<%@page import="prj2.mgt.post.vo.AnnounceVO"%>
<%@page import="prj2.mgt.post.dao.MgtAnnounceDAO"%>
<%@page import="prj2.mgt.post.BoardUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 > 회원 관리 > 회원 리스트 > 회원 상세 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<!-- 로그인 세션 없으면 리다이렉트 -->
<c:if test="${empty sessionScope.loginData2 }"><c:redirect url="http://192.168.10.214/Rest_Area_prj/mgt/login/mgt_login_frm.jsp" /></c:if>
<!-- 로그인 세션 없으면 리다이렉트 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestArea - 관리자</title>
<link rel="icon" href="http://192.168.10.214/common/favicon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<link rel="stylesheet" href="http://192.168.10.214/Rest_Area_prj/CSS/etc/board.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.214/Rest_Area_prj/CSS/etc/main.css" type="text/css" media="all" />

<!-- jQuery CDN 시작 -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css"	rel="stylesheet">
<script	src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->

<!-- 관리자 페이지 사이드바 디자인 (html + css) 시작 -->
<c:import url="http://192.168.10.214/Rest_Area_prj/mgt/sidebar/mgt_sidebar.jsp"/>
<!-- 관리자 페이지 사이드바 디자인 (html + css) 끝 -->

<style type="text/css">

</style>

<script type="text/javascript">
	
	$(function() {
		callAjaxStarRate();
		//callAjaxReview();
		
		$("#btnCancel").click(function(){				
// 			history.back();
			let href = "http://192.168.10.214/Rest_Area_prj/mgt/member/mgt_member.jsp?currentPage=${param.currentPage }";
			if("${param.keyword}" != ''){
				href += "&keyword=${param.keyword}";
			} // end if
			if("${param.field}" != '') {
				href += "&field=${param.field}";
			} // end if
			if("${param.pageScale}" != '') {
				href += "&pageScale=${param.pageScale}";
			} // end if
			location.href = href;
		}); // click
		
		$("#btnSuspend").click(function() {
			if(confirm('회원을 정지시키겠습니까?')) {
				suspendMember();
			} // end if
		}) // click
		$("#btnUnSuspend").click(function() {
			if(confirm('회원 정지를 해제시키겠습니까?')) {
				suspendMember();
			} // end if
		}) // click
	}); // $(document).ready(function() { })
	
	function suspendMember() {
		let href = "http://192.168.10.214/Rest_Area_prj/mgt/member/mgt_member_update_process.jsp?currentPage=${param.currentPage }";
		if("${param.keyword}" != ''){
			href += "?keyword=${param.keyword}";
		} // end if
		if("${param.field}" != '') {
			href += "?field=${param.field}";
		} // end if
		if("${param.pageScale}" != '') {
			href += "?pageScale=${param.pageScale}";
		} // end if
		$("#frmDetail")[0].action = href;
		$("#frmDetail").submit();
		window.opener.location.reload();
	} // suspendMember
	
	function callAjaxStarRate() {
		var param = {memId: "${param.memId}"};
		
		var totalCount = 0;
		var pageScale = 5;
		var currentPage = 1;
		var list = new Array();
		
		$.ajax({
			url: "mgt_member_star_rate_process.jsp",
			type:"POST",
			data:param,
			dataType: "JSON",
			error: function(xhr) {
				alert('문제가 발생했습니다');
				console.log(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					totalCount = jsonObj.totalCount;
					pageScale = jsonObj.pageScale;
					currentPage = jsonObj.currentPage;
					list = jsonObj.data;
					
					var tabSR = '<table style="width:100%;"><tr><th>번호</th><th>휴게소</th><th>별점</th><th>작성자</th><th>작성일</th></tr>';
					for (let i = 0; i < list.length; i++){
						tabSR += '<tr>'
						+ '<td>' + (totalCount - ((currentPage - 1) * pageScale) - i) + '</td>'
						+ '<td>' + list[i].raName + '</td>'
						+ '<td>' + list[i].star + '</td>'
						+ '<td>' + list[i].memId + '</td>'
						+ '<td>' + list[i].inputDate + '</td>'
						+ '</tr>';
					} // end for
					tabSR += '</table>';
					$("#tab").html(tabSR);
				} // end if
			} // success
		}); // ajax
	} // callAjaxStarRate
	
	function callAjaxReview() {
		var param = {memId: "${param.memId}"};
		
		var totalCount = 0;
		var pageScale = 5;
		var currentPage = 1;
		var list = new Array();
		
		$.ajax({
			url: "mgt_member_review_process.jsp",
			type:"POST",
			data:param,
			dataType: "JSON",
			error: function(xhr) {
				alert('문제가 발생했습니다');
				console.log(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					totalCount = jsonObj.totalCount;
					pageScale = jsonObj.pageScale;
					currentPage = jsonObj.currentPage;
					list = jsonObj.data;
					
					var tabSR = '<table style="width:100%;"><tr><th>번호</th><th>간략 내용</th><th>휴게소</th><th>작성자</th><th>작성일</th><th>블라인드</th><th>삭제일</th></tr>';
					for (let i = 0; i < list.length; i++){
						tabSR += '<tr>'
						+ '<td>' + (totalCount - ((currentPage - 1) * pageScale) - i) + '</td>'
						+ '<td>' + list[i].title + '</td>'
						+ '<td>' + list[i].raName + '</td>'
						+ '<td>' + list[i].memId + '</td>'
						+ '<td>' + list[i].inputDate + '</td>'
						+ '<td>' + list[i].blindFlag + '</td>'
						+ '<td>' + list[i].deleteDate + '</td>'
						+ '</tr>';
					} // end for
					tabSR += '</table>';
					$("#tab").html(tabSR);
				} // end if
			} // success
		}); // ajax
	} // callAjaxStarRate
	
	document.getElementById('sideDash').setAttribute('class', 'sideText sideDisSelect');
	document.getElementById('sideMember').setAttribute('class', 'sideText sideSelect');

</script>

</head>
<body>
<%
MgtMemberDAO mmDAO = MgtMemberDAO.getInstance();
try {
	String memId = request.getParameter("memId");
	MemberVO mVO = mmDAO.selectOneMember(memId);
	
	DataDecrypt dd = new DataDecrypt("yIzLRfreATg/6wxHGia/4w==");
	mVO.setName( dd.decryption(mVO.getName()) );
	mVO.setEmail(dd.decryption(mVO.getEmail()));
	
	pageContext.setAttribute("mVO", mVO);
	
} catch (SQLException se) {
	se.printStackTrace();
%>
	<c:redirect url="mgt_member.jsp"/>
<%
}
%>
<div id="wrap">	
	<!-- 중앙 메인프레임 시작 -->
	<div id="mainFrame">
		<!-- 최상단 메뉴이름 타이틀바 시작 -->
		<div id="frmBackground">
			<span id="currentTopMenuName">회원</span>
			<span id="currentBottomMenuName"> > 회원 리스트 > 회원 상세조회</span>
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div id="contentWrap" style="margin:0px auto; width: 462px; height: 749px;">
			<form method="post" action="mgt_member_update_process.jsp" name="frmDetail" id="frmDetail">
				<input type="hidden" id="managerId" name="managerId" value="${sessionScope.loginData2.managerId }"/>
				<input type="hidden" id="memId" name="memId" value="${param.memId }"/>
				<input type="hidden" id="suspendFlag" name="suspendFlag" value="${mVO.suspendFlag }"/>
				<div style="margin:0px auto;" >
					<table>
						<tr>
							<th style="width: 60px;">아이디</th>
							<td style="width:400px;" colspan=3><c:out value="${mVO.memId }"/></td>
						</tr>
						<tr>
							<th>이름</th>
							<td colspan=3><c:out value="${mVO.name }"/></td>
						</tr>
						<tr>
							<th>닉네임</th>
							<td colspan=3><c:out value="${mVO.nick }"/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td colspan=3><c:out value="${mVO.email }"/></td>
						</tr>
						<tr>
							<th>가입일</th>
							<td colspan=3><fmt:formatDate value="${mVO.joinDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
						<tr>
							<th>정지</th>
							<td style="width: 100px;"><c:out value="${mVO.suspendFlag == false ? '' : '정지됨' }"/></td>
							<th style="width: 60px;">정지일</th>
							<td style="width: 240px;"><fmt:formatDate value="${mVO.suspendDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
						<tr>
							<th>탈퇴</th>
							<td><c:out value="${mVO.withdrawFlag == false ? '' : '탈퇴'}"/></td>
							<th>탈퇴일</th>
							<td><fmt:formatDate value="${mVO.withdrawDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						</tr>
					</table>
				</div>
				<!-- <div style="margin-top:10px;">
					<div>
					최근 활동
					</div>
					<input type="button" value="리뷰" class="btn btn-sm btn-dark" id="review"/>
					<input type="button" value="문의내역" class="btn btn-sm btn-dark" id="inquiry"/>
					<input type="button" value="매장신고" class="btn btn-sm btn-dark" id="storeReport"/>
					<input type="button" value="리뷰신고" class="btn btn-sm btn-dark" id="reviewReport"/>
					<input type="button" value="별점 내역" class="btn btn-sm btn-dark" id="starRate"/>
				</div> -->
				<div style="margin-top:10px;">
				별점내역
				</div>
				<div id="tab" style="width:460px;">
				</div>
				<div style="margin-top:10px; float:right;">
					<c:choose>
						<c:when test="${!mVO.suspendFlag }">
							<input type="button" value="회원 정지" class="btn btn-danger btn-sm" id="btnSuspend"/>					
						</c:when>
						<c:otherwise>
							<input type="button" value="회원 정지 해제" class="btn btn-primary btn-sm" id="btnUnSuspend"/>					
						</c:otherwise>
					</c:choose>
				</div>
				<div style="margin-top:20px; text-align:center; clear:both;">
					<input type="button" value="목록으로" class="btn btn-secondary btn-lg" id="btnCancel" />
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
	</div>
	<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>