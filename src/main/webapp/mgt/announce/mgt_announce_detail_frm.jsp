<%@page import="prj2.mgt.post.vo.AnnounceVO"%>
<%@page import="prj2.mgt.post.dao.MgtAnnounceDAO"%>
<%@page import="prj2.mgt.post.BoardUtil"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 > 게시글 관리 > 공지사항 > 공지사항 조회"%>
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
		$("#btnUpdate").click(function() {
			if (confirm("글을 수정하시겠습니까?")) {
				chkNull();
			} // end if
		}) // click
		$("#btnDelete").click(function() { // <form> 태그의 action 변경
			if (confirm("글을 정말 삭제하시겠습니까?")) {
				$("#frmDetail")[0].action = "mgt_announce_delete_process.jsp";

				$("#frmDetail").submit();
			} // end if
		}); // click
		$("#btnCancel").click(function() {
			//history.back();
			
			var href = "http://192.168.10.214/Rest_Area_prj/mgt/announce/mgt_announce.jsp?currentPage=${param.currentPage }";
			if("${param.keyword}" != ''){
				href += "?keyword=${param.keyword}";
			} // end if
			if("${param.field}" != '') {
				href += "?field=${param.field}";
			} // end if
			location.href = href;
		}) // click
		$("#btnWrite").click(function() {
			chkNull();
		}) // click
	}); // $(document).ready(function() { })
	
	function chkNull() {
		if($("#title").val().trim() == "") {
			alert('글 제목은 필수 입력입니다');
			$("#title").focus();
			return;
		} // end if
		if($("#content").val().trim() == "") {
			alert('글 내용은 필수 입력입니다');
			$("#content").focus();
			return;
		} // end if
		if($("#views").val().trim() == "") {
			$("#views").val(0);
		} // end if
		
		// submit - 백엔드로 전송
		$("#frmDetail")[0].action = "mgt_announce_update_process.jsp";
		$("#frmDetail").submit();
	} // chkNull

	document.getElementById('sideDash').setAttribute('class', 'sideText sideDisSelect');
	document.getElementById('sideBoard').setAttribute('class', 'sideText sideSelect');
	document.getElementById('sideAnnounce').setAttribute('class', 'sideText sideSelect');
</script>

<script>
	$(function() {
		$('#content').summernote(
				{
					tabsize : 2,
					width : 700,
					height : 200,
					toolbar : [ [ 'style', [ 'style' ] ],
							[ 'font', [ 'bold', 'underline', 'clear' ] ],
							[ 'color', [ 'color' ] ],
							[ 'para', [ 'ul', 'ol', 'paragraph' ] ],
							[ 'table', [ 'table' ] ],
							[ 'insert', [ 'link', 'picture', 'video' ] ],
							[ 'view', [ 'fullscreen', 'codeview', 'help' ] ] ]
				});
	});
</script>

</head>
<body>
<%
MgtAnnounceDAO maDAO = MgtAnnounceDAO.getInstance();
try {
	int num = Integer.parseInt(request.getParameter("num"));
	AnnounceVO aVO = maDAO.selectOneAnnounce(num);
	maDAO.updateViews(num);
	
	pageContext.setAttribute("aVO", aVO);
	
} catch (NumberFormatException nfe) {
	nfe.printStackTrace();
%>
	<c:redirect url="mgt_announce.jsp"/>
<%
} catch (SQLException se) {
	se.printStackTrace();
%>
	<c:redirect url="mgt_announce.jsp"/>
<%
}
%>
<div id="wrap">	
	<!-- 중앙 메인프레임 시작 -->
	<div id="mainFrame">
		<!-- 최상단 메뉴이름 타이틀바 시작 -->
		<div id="frmBackground">
			<span id="currentTopMenuName">공지사항</span>
			<span id="currentBottomMenuName"> > 공지사항 조회</span>
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div id="contentWrap" style="margin-left:100px; width: 700px; height: 749px;">
			<form method="post" action="mgt_announce_write_process.jsp" name="frmDetail" id="frmDetail">
				<input type="hidden" id="managerId" name="managerId" value="${sessionScope.loginData2.managerId }"/>
				<input type="hidden" id="announceNum" name="announceNum" value="${param.num }"/>
				<div style="margin:0px auto;" >
					<table>
						<tr style="border:none;">
							<td style="border:none;width: 100px">제목</td>
							<td style="border:none;"><input type="text" name="title" id="title"  value="${aVO.title }"  style="width: 600px; height: 40px;" /></td>
						</tr>
						<tr style="border:none;">
							<td style="border:none;">조회수</td>
							<td style="border:none;"><input type="text" name="views" id="views" value="${aVO.views }"
								style="width: 100px; height: 40px;" /></td>
						</tr>
						<tr style="border:none;">
							<td style="border:none;">작성일</td>
							<td style="border:none;"><strong><fmt:formatDate	value="${aVO.inputDate }" pattern="yyyy-MM-dd HH:mm:ss" /></strong></td>
						</tr>
						<tr style="border:none;">
							<td style="border:none;">작성자</td>
							<td style="border:none;"><strong><c:out value="${aVO.managerNick}" /></strong></td>
						</tr>
					</table>
				</div>
				<div style="margin-top:20px;">
					<textarea id="content" name="content">${aVO.content }</textarea>
				</div>
				<div style="margin-top:20px; float:right;">
					<c:if test="${aVO.managerId eq sessionScope.loginData2.managerId}">
					<input type="button" value="글 수정" class="btn btn-sm btn-primary btn-lg" id="btnUpdate" />
					</c:if>
					<input type="button" value="목록으로" class="btn btn-sm btn-secondary btn-lg" id="btnCancel" />
					<c:if test="${aVO.managerId eq sessionScope.loginData2.managerId}">
					<input type="button" value="글 삭제" class="btn btn-sm btn-danger" id="btnDelete" />
					</c:if>
				</div>
			</form>
		</div>
		<!-- 내용 끝 -->
	</div>
	<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>