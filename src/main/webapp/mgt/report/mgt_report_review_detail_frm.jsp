<%@page import="prj2.mgt.post.vo.RestAreaReviewRepVO"%>
<%@page import="prj2.mgt.post.dao.MgtReviewReportDAO"%>
<%@page import="prj2.mgt.post.vo.InquiryVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.post.dao.MgtInquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 > 게시글 관리 > 신고 > 리뷰 신고 리스트 > 리뷰 신고 상세 조회"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%request.setCharacterEncoding("UTF-8");%>

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

<!-- 관리자 페이지 사이드바 디자인 (css) 시작 -->
<c:import url="http://192.168.10.214/Rest_Area_prj/mgt/sidebar/mgt_sidebar_css.jsp"/>
<!-- 관리자 페이지 사이드바 디자인 (css) 끝 -->

<style type="text/css">
	.mgtContent {	/* 내용이 들어가는 자리 */
		margin-left: 5%;
		width: 90%;
		font-size: 18px;
	}
	.bgGrey {background-color: #e0e0e0;}
	.bgWhite{background-color: white;}
	
	.textTitle{font-size: 30px; font-weight: bold;}
	.textSubtitle{font-size:26px;}
	.textContent{font-size:20px;}
	
	.padL{padding-left:2%;}
	.padR{padding-right:2%;}
	
</style>

<script type="text/javascript">
	$(function() {
		if("${param.update} == '1'") {
			window.opener.location.reload();
		} // end if
		
		$("#btnOk").click(function(){
			if(confirm('신고 처리 내역을 업데이트하시겠습니까?')){
				updateReview();
			} // end if"
		}); // click
		$("#btnClose").click(function(){
			if("${param.update}" == "1"){
				window.opener.location.reload();
				window.close();
			} else {
				self.close();				
			} // end if
		}) // click
		
		$("#btnDelete").click(function(){
			if (confirm ("리뷰를 정말 삭제하시겠습니까?")) {
				$("#frmDetail")[0].action = "mgt_report_review_delete_process.jsp";
				$("#frmDetail").submit();
			} // end if
		});
	}); // $(document).ready(function() { })

	function updateReview() {
		$("#frmDetail")[0].action = "mgt_report_review_update_process.jsp?<%=request.getQueryString()%>";
		$("#frmDetail").submit();
		window.opener.location.reload();
	} // updateInquiry
</script>

</head>
<body style="background-color: #F5F6FA;">
<%-- <jsp:useBean id="iVO" class="prj2.mgt.post.vo.InquiryVO" scope="page"/> --%>
<%-- <jsp:setProperty property="*" name="iVO"/> --%>
<%
try {
	MgtReviewReportDAO mrrDAO = MgtReviewReportDAO.getInstance();
	RestAreaReviewRepVO rarrVO = mrrDAO.selectOneRevRep(Integer.parseInt(request.getParameter("num")), request.getParameter("reportMemId"));
	pageContext.setAttribute("rarrVO", rarrVO);
} catch (SQLException se) {
	se.printStackTrace();
	out.println("잠시후 다시 시도해주세요");
} catch (NumberFormatException nfe) {
	nfe.printStackTrace();
	out.println("잠시후 다시 시도해주세요");
} // end catch 

%>

<div id="wrap">	
	<!-- 중앙 메인프레임 시작 -->
	<div style="margin:0px auto;">
		<!-- 최상단 메뉴이름 타이틀바 시작 -->
		<div id="frmBackground" style="background-color: #ffffff">
			<span id="currentTopMenuName">신고</span>
			<span id="currentBottomMenuName"> > 리뷰 신고 리스트 > 리뷰 신고 상세</span>
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div style="margin:0px auto;">
			<form method="post" name="frmDetail" id="frmDetail">
				<input type="hidden" name="reviewNum" id="reviewNum" value="${rarrVO.reviewNum }"/>
				<div class="mgtContent" style="margin-top:20px;">
				리뷰
				</div>
				<div class="mgtContent bgGrey">
					<div class="textTitle padL" style="width:78%; float:left;">
						<span>리뷰 작성자: <c:out value="${rarrVO.reviewMemId }"/></span>
					</div>
					<div class="textContent padR" style="width:18%; float:right; text-align:right;">
						<span>리뷰 번호: ${rarrVO.reviewNum }</span>
					</div>
					<div class="textContent padL" style="clear:both;">
						<span><fmt:formatDate value="${rarrVO.reviewInputDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>				
					</div>
				</div>
				<div class="mgtContent bgGrey" style="margin-top:10px;">
					<div class="textContent" >
						<textarea id="reviewContent" readonly="readonly" style="background:#e0e0e0; width:100%; height:100%;">${rarrVO.reviewContent }</textarea>
					</div>	
				</div>
				
				<div class="mgtContent" style="margin-top:30px;">
				신고
				</div>
				<div class="mgtContent bgGrey">
					<div class="textTitle padL" style="width:78%; float:left;">
						<span>신고자: <c:out value="${rarrVO.reviewMemId }"/></span>
					</div>
					<div class="textContent padL" style="clear:both;">
						<span><fmt:formatDate value="${rarrVO.reportInputDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>				
					</div>
				</div>
				<div class="mgtContent bgGrey" style="margin-top:10px;">
					<div class="textContent" >
						<textarea id="reportContent" readonly="readonly" style="background:#e0e0e0; width:100%; height:100%;">${rarrVO.reportContent }</textarea>
					</div>	
				</div>
				<div class="mgtContent" style="margin-top:30px;">
				답변
				</div>
				<div class="mgtContent">
					<textarea name="processContents" id="processContents" class="textContent" maxlength="1000" style=" width:100%; height:100%;">${rarrVO.processContents }</textarea>
				</div>
				<div class="mgtContent" style="margin-top:20px; width:40%; float:left;">
					<label>블라인드 처리</label>
					<c:choose>
					<c:when test="${rarrVO.blindFlag }">
					<input type="checkbox" id="blindFlag" name="blindFlag" value="true" checked="checked"/>
					</c:when>
					<c:when test="${not rarrVO.blindFlag }">
					<input type="checkbox" id="blindFlag" name="blindFlag" value="true"/>
					</c:when>
					</c:choose>
				</div>
				<div class="mgtContent padR" style="margin-top:20px; width:40%; float:right; text-align:right;">
					<select id="processFlag" name="processFlag">
						<option value="0"${rarrVO.processFlag eq 0 ? " selected='selected'" : ""}>처리 전</option>
						<option value="1"${rarrVO.processFlag eq 1 ? " selected='selected'" : ""}>처리 중</option>
						<option value="2"${rarrVO.processFlag eq 2 ? " selected='selected'" : ""}>처리 완료</option>
					</select>
				</div>
				<div style="padding-top:20px; text-align:center; clear:both;">
					<input type="button" style="margin-right:10px;" id="btnOk" name="btnOk" class="btn btn-primary btn-lg" value="확인"/>
					<input type="button" id="btnClose" name="btnClose" class="btn btn-secondary btn-lg" value="닫기"/>
					<c:if test="${!rarrVO.deleteFlag }">
					<input type="button" style="margin-left:10px;" id="btnDelete" name="btnDelete" class="btn btn-danger btn-lg" value="삭제"/>
					</c:if>
				</div>
<%-- 				${param.num } --%>
<%-- 				${param.rnum } --%>
<%-- 				${param.currentPage } --%>
		
			</form>
		</div>
	</div>
</div>

</body>
</html>