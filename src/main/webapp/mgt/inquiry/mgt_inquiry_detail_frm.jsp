<%@page import="prj2.mgt.post.vo.InquiryVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.post.dao.MgtInquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
	info="관리자 > 게시글 관리 > 문의 > 문의 리스트 > 문의 상세 조회"%>
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
		$("#btnClose").click(function(){
			
// 			var href = "http://192.168.10.214/Rest_Area_prj/mgt/inquiry/mgt_inquiry.jsp?currentPage=${param.currentPage }";
// 			if("${param.keyword}" != ''){
// 				href += "?keyword=${param.keyword}";
// 			} // end if
// 			if("${param.field}" != '') {
// 				href += "?field=${param.field}";
// 			} // end if
// 			location.href = href;
			window.opener.location.reload();
			window.close();
		}) // click
		
		$("#btnDelete").click(function(){
			if (confirm ("문의를 정말 삭제하시겠습니까?")) {
				$("#frmDetail")[0].action = "mgt_inquiry_delete_process.jsp";
				$("#frmDetail").submit();
			} // end if
		});
	}); // $(document).ready(function() { })

	function updateInquiry() {
		chkNull();
	} // updateInquiry
	
	function chkNull() {
		if($("#answerContents").val().trim() == ""){
			alert("답변 내용은 필수 입력입니다");
			$("#answerContents").focus();
			return;
		} // end if
		$("#frmDetail")[0].action = "mgt_inquiry_update_process.jsp?rnum=${param.rnum}&num=${param.num}&currentPage=${param.currentPage}&answerFlag=" + $('#answerFlag').val();
		$("#frmDetail").submit();
		reload();
	} // chkNull
</script>

<script>
	$(function() {
		$('#inqueryContent').summernote(
				{
					tabsize : 2,
					width : 720,
					height : 150,
					toolbar : [ ]
				});
		$('#inqueryContent').summernote('disable');
	});
</script>

</head>
<body style="background-color: #F5F6FA;">
<%-- <jsp:useBean id="iVO" class="prj2.mgt.post.vo.InquiryVO" scope="page"/> --%>
<%-- <jsp:setProperty property="*" name="iVO"/> --%>
<%
try {
	MgtInquiryDAO miDAO = MgtInquiryDAO.getInstance();
	InquiryVO iVO = miDAO.selectOneInquiry(Integer.parseInt(request.getParameter("num")));
	pageContext.setAttribute("iVO", iVO);
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
			<span id="currentTopMenuName">문의</span>
			<span id="currentBottomMenuName"> > 문의 리스트 > 문의 상세</span>
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div style="margin:0px auto;">
			<form method="post" name="frmDetail" id="frmDetail" >
				<input type="hidden" name="inquiryNum" id="inquiryNum" value="${iVO.inquiryNum }"/>
				<input type="hidden" name="answerFlag" id="answerFlag" value="${iVO.answerFlag }"/>
				<div class="mgtContent bgGrey">
					<div class="textTitle padL" style="width:78%; float:left;">
						<span><c:out value="${iVO.title }${iVO.secretFlag eq true ? ' 🔒':'' }"/></span>
					</div>
					<div class="textContent padR" style="width:18%; float:right; text-align:right;">
						<span>글번호: ${param.rnum }</span>
					</div>
					<div class="textSubtitle padL" style="clear:both;">
						<span>작성자: <c:out value="${iVO.memId }"/></span>				
					</div>
					<div class="textContent padL" >
						<span><fmt:formatDate value="${iVO.inputDate }" pattern="yyyy-MM-dd HH:mm:ss"/></span>				
					</div>
				</div>
				<div class="mgtContent" style="margin-top:20px;">
				내용
				</div>
				<div class="mgtContent bgGrey">
					<div class="textContent" >
						<textarea id="inqueryContent">${iVO.contents }</textarea>
					</div>	
				</div>
				<div class="mgtContent" style="margin-top:20px;">
				답변
				</div>
				<div class="mgtContent">
					<textarea name="answerContents" id="answerContents" class="textContent" cols="73" rows="4" maxlength="1000">${iVO.answerContents }</textarea>
				</div>
				<div style="padding-top:20px; text-align:center;">
					<input type="button" style="margin-right:10px;" id="btnOk" name="btnOk" class="btn btn-primary btn-lg" value="${iVO.answerFlag ? '수정' : '등록' }"
						onClick="var msg = ${iVO.answerFlag} ?'문의의 답변을 수정하시겠습니까?' : '문의의 답변을 등록하시겠습니까?';
							if(confirm(msg)){
								updateInquiry();
							} // end if"
					/>
					<input type="button" id="btnClose" name="btnClose" class="btn btn-secondary btn-lg" value="닫기"/>
					<input type="button" style="margin-left:10px;" id="btnDelete" name="btnDelete" class="btn btn-danger btn-lg" value="삭제"/>
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