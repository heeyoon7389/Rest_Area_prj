<%@page import="prj2.mgt.post.vo.AnnounceVO"%>
<%@page import="prj2.mgt.post.dao.MgtAnnounceDAO"%>
<%@page import="prj2.mgt.post.BoardUtil"%>
<%@ page import="prj2.mgt.login.vo.ManagerVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 > 게시글 관리 > 공지사항 > 공지사항 리스트"%>
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

<!-- 관리자 페이지 사이드바 디자인 (html + css) 시작 -->
<c:import url="http://192.168.10.214/Rest_Area_prj/mgt/sidebar/mgt_sidebar.jsp"/>
<!-- 관리자 페이지 사이드바 디자인 (html + css) 끝 -->

<style type="text/css">

</style>

<script type="text/javascript">
	
	$(function() {
		var field = "0";
		
		$("#btnSearch").click(function () {
			chkNull();
		}); // click
		$("#keyword").keydown(function (evt) {
			if(evt.which == 13) {
				chkNull();
			} // end if
		}); // keydown
		$("#btnAllSearch").click(function () {
			location.href = "mgt_announce.jsp";
		}); // click
		$("#btnWrite").click(function () {
			location.href = "mgt_announce_write_frm.jsp";
		}); // click
	}); // $(document).ready(function() { })
	
	function chkNull() {
		if($("#keyword").val().trim() != "") {
			$("#frmBoard").submit();
		} // end if
	} // chkNull

	document.getElementById('sideDash').setAttribute('class', 'sideText sideDisSelect');
	document.getElementById('sideBoard').setAttribute('class', 'sideText sideSelect');
	document.getElementById('sideAnnounce').setAttribute('class', 'sideText sideSelect');

</script>

</head>
<body>

<div id="wrap">	
	<!-- 중앙 메인프레임 시작 -->
	<div id="mainFrame">
		<!-- 최상단 메뉴이름 타이틀바 시작 -->
		<div id="frmBackground">
			<span id="currentTopMenuName">공지사항</span>
			<span id="currentBottomMenuName"> > 공지사항 리스트</span>
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div id="content" style="text-align:center;">
			<jsp:useBean id="sVO" class="prj2.mgt.paging.vo.SearchVO" scope="page"/>
			<jsp:setProperty property="*" name="sVO"/>
			<%
			try {
				MgtAnnounceDAO maDAO = MgtAnnounceDAO.getInstance();
				
				// 총 레코드의 수 얻기
				int totalCount = maDAO.selectMaxPage(sVO);
				
				// 한 화면에 보여줄 게시물의 수
				int pageScale = 10;
				
				// 총 페이지수
				int totalPage = (int)Math.ceil((double)totalCount / pageScale);
				
				// 게시물의 시작 번호
				String tempPage = sVO.getCurrentPage();
				int currentPage = 1;
				if(tempPage != null) {
					try {
						currentPage = Integer.parseInt(tempPage);	// 악의적 목적의 사용자가 주소창 페이지 번호에 숫자가 아닌 값을 넣는 경우 
					} catch (NumberFormatException nfe) {
					} // end catch
				} // end if
				int startNum = (currentPage - 1) * pageScale + 1;
							
				// 끝번호
				int endNum = startNum + pageScale - 1;
				
				sVO.setStartNum(startNum);
				sVO.setEndNum(endNum);
				
				List<AnnounceVO> list = maDAO.selectPagingAnnounce(sVO);
				pageContext.setAttribute("list", list);
				
				// 페이지 번호 매기기
				pageContext.setAttribute("totalCount", totalCount);
				pageContext.setAttribute("pageScale", pageScale);
				pageContext.setAttribute("currentPage", currentPage);
			%>
			<div style="width:150px; float:left;">
				<input type="button" value="전체글" id="btnAllSearch" class="btn btn-sm btn-info"/>
			</div>
			<div style="width:150px; float:right;">
				<input type="button" value="글쓰기" id="btnWrite" class="btn btn-sm btn-info"/>
			</div>
			<div class="tableFrm" style="height:460px;">
				<table class="restAreaTable">
					<thead>
						<tr>
							<th>번호</th>
							<th style="display:none;">공지번호</th>
							<th>제목</th>
							<th>작성자</th>
							<th>작성일</th>
							<th>조회수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="aVO" items="${list }" varStatus = "i">
							<tr>
								<c:set var="rnum" value="${totalCount - ((currentPage - 1) * pageScale) - i.index }"/>
								<td><c:out value="${rnum }"/></td>
								<td style="display:none;"><input type="hidden" value="${aVO.announceNum }"/></td>
<%-- 								<td><c:out value="${aVO.title }"/></td> --%>
<%-- 								<td><a href="board_read_frm.jsp?seq=${bVO.num }&currentPage=${empty param.currentPage ? 1:param.currentPage}"><c:out value="${bVO.title }"/></a></td> --%>
								<td class="boardTitle"><a style="text-decoration:none; color:black;" href="mgt_announce_detail_frm.jsp?rnum=${rnum }&num=${aVO.announceNum }&currentPage=${empty param.currentPage ? 1:param.currentPage}"><c:out value="${aVO.title }"/></a></td>
								<td><c:out value="${aVO.managerNick }"/></td>
								<td><fmt:formatDate value="${aVO.inputDate }" pattern="yyyy-MM-dd HH:mm:ss"/></td>								
								<td><c:out value="${aVO.views }"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div style="text-align: center">
				<div style="height:50px">
					<form name="frmBoard" id="frmBoard" action="mgt_announce.jsp">
						<select name="field" id="field">
							<option value="0" ${param.field eq 0 ? " selected='selected'" : ""}>제목 + 내용</option>
							<option value="1" ${param.field eq 1 ? " selected='selected'" : ""}>제목</option>
							<option value="2" ${param.field eq 2 ? " selected='selected'" : ""}>내용</option>
							<option value="3" ${param.field eq 3 ? " selected='selected'" : ""}>작성자</option>
						</select>
						<input type="text" name="keyword" id="keyword" value="${param.keyword }" style="width:230px"/>
						<input type="button" value="검색" id="btnSearch" class="btn btn-sm btn-info"/>
						<input type="text" style="display:none"/>
					</form>
				</div>
				<%
				String param = "";
				%>
				<c:if test="${not empty param.keyword }">
					<%
					param = "&field=" + request.getParameter("field") + "&keyword=" + request.getParameter("keyword");
					%>
				</c:if>
				<%=BoardUtil.getInstance().pageNation("mgt_announce.jsp", param, totalPage, currentPage) %>
			</div>
	        <%
			} catch (SQLException se) {
				se.printStackTrace();
				out.println("잠시후 다시 시도해주시기 바랍니다");
			} // end catch
			%>
		</div>
		<!-- 내용 끝 -->
	</div>
	<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>