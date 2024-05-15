<%@page import="prj2.mgt.dashboard.vo.MemberVariTableVO"%>
<%@page import="prj2.mgt.dashboard.vo.DashReviewReportVO"%>
<%@page import="prj2.mgt.dashboard.vo.DashInquiryVO"%>
<%@page import="prj2.mgt.post.vo.InquiryVO"%>
<%@page import="prj2.mgt.dashboard.vo.RaReviewRankVO"%>
<%@page import="prj2.mgt.dashboard.dao.SelecDate"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2.mgt.dashboard.vo.RaViewRankVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2.mgt.dashboard.dao.MgtDashBoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="관리자 대시보드"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<!-- 로그인 세션 없으면 리다이렉트 -->
<c:if test="${empty sessionScope.loginData2 }"><c:redirect url="http://192.168.10.214/Rest_Area_prj/mgt/login/mgt_login_frm.jsp" /></c:if>
<!-- 로그인 세션 없으면 리다이렉트 -->
<%
try {
	MgtDashBoardDAO mdbDAO = MgtDashBoardDAO.getInstance();
	
	// 휴게소 조회수
	List<RaViewRankVO> listRvrVO = mdbDAO.selectRAViewRank(SelecDate.MONTH.getValue());
	// 휴게소 리뷰수
	List<RaReviewRankVO> listRrrVO = mdbDAO.selectRAReviewRank(SelecDate.MONTH.getValue());
	// 문의내역
	List<DashInquiryVO> listDiVO = mdbDAO.selectDashInquiry();
	// 신고내역
	List<DashReviewReportVO> listDrrVO = mdbDAO.selectDashReport();
	
	pageContext.setAttribute("listRvrVO", listRvrVO);
	pageContext.setAttribute("listRrrVO", listRrrVO);
	pageContext.setAttribute("listDiVO", listDiVO);
	pageContext.setAttribute("listDrrVO", listDrrVO);
} catch (SQLException se) {
	se.printStackTrace();
} // end catch

%>
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

<!-- datepicker 시작-->
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script>
	$( function() {
		// 기본 사용
		//$( "#datepicker" ).datepicker();
		
		// 옵션 부여
		$( ".datepicker" ).datepicker({
			dayNamesMin: [ "일", "월", "화", "수", "목", "금", "토" ], 
			dateFormat: "yy-mm-dd",
			monthNames: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
			showMonthAfterYear: true
		});
	} );
</script>
<!-- datepicker 끝-->

<!-- jQuery chart 시작 -->
<!-- <script src="https://canvasjs.com/assets/script/jquery-1.11.1.min.js"></script> -->
<script src="https://cdn.canvasjs.com/jquery.canvasjs.min.js"></script>
<!-- jQuery chart 끝 -->

<style type="text/css">


</style>

<script type="text/javascript">

	$(function() {
		
		// 사이트 방문자수 그래프
		callAjaxLineChart();
		// 회원 수 변동 그래프
		callAjaxBarChart();
		
		
		// 사이트 방문자수 datepicker 시작일
		$("#datepickerViewStart").change(function() {
			chkOverToday($("#datepickerViewStart"), $("#datepickerViewEnd"));
			chkStartLessThenEnd($("#datepickerViewStart"), $("#datepickerViewEnd"));
		});
		// 사이트 방문자수 datepicker 종료일
		$("#datepickerViewEnd").change(function() {
			chkOverToday($("#datepickerViewStart"), $("#datepickerViewEnd"));
			chkEndGreaterThenStart($("#datepickerViewStart"), $("#datepickerViewEnd"));
		});
		// 회원 수 변동 datepicker 시작일
		$("#datepickerMemberStart").change(function() {
			chkOverToday($("#datepickerMemberStart"), $("#datepickerMemberEnd"));
			chkStartLessThenEnd($("#datepickerMemberStart"), $("#datepickerMemberEnd"));
		});
		// 회원 수 변동 datepicker 종료일
		$("#datepickerMemberEnd").change(function() {
			chkOverToday($("#datepickerMemberStart"), $("#datepickerMemberEnd"));
			chkEndGreaterThenStart($("#datepickerMemberStart"), $("#datepickerMemberEnd"));
		});
		// 사이트 방문자수 조회 버튼
		$("#btnSiteView").click(function() {
			callAjaxLineChart();
		});
		// 회원수 변동 조회 버튼
		$("#btnMemberVari").click(function() {
			callAjaxBarChart();
		});
		// 휴게소 조회수 조회 기준일
		$("#selRaView").change(function() {
			callAjaxRaViews();
		});
		// 휴게소 리뷰수 조회 기준일
		$("#selRaReview").change(function() {
			callAjaxReviews();
		});
	}); // $(document).ready(function() { })
	
	function chkStartLessThenEnd(dateStart, dateEnd) {
		let flag = true;
		if($(dateStart).val() > $(dateEnd).val()){
			$(dateStart).val( $(dateEnd).val());
			alert('시작일은 종료일보다 작아야합니다');
			flag = false;
		} // end if
		return flag;
	} // chkStartLessThenEnd
	
	function chkEndGreaterThenStart(dateStart, dateEnd) {
		let flag = true;
		if($(dateEnd).val() < $(dateStart).val()){
			$(dateEnd).val( $(dateStart).val());
			alert('종료일은 시작일보다 커야합니다');
			flag = false;
		} // end if
		return flag;
	} // chkEndGreaterThenStart
	
	function chkOverToday(dateStart, dateEnd) {
		let flag = true;
		var now = new Date();
		var strNow = now.getFullYear() + '-' + lpad0(now.getMonth()+1) + '-' + lpad0(now.getDate());
		if($(dateStart).val() > strNow) {
			$(dateStart).val($(dateEnd).val());
			alert('오늘 날짜를 포함한 이전으로 선택해주세요');
			flag = false;
		} // end if
		if($(dateEnd).val() > strNow) {
			$(dateEnd).val(strNow);
			alert('오늘 날짜를 포함한 이전으로 선택해주세요');
			flag = false;
		} // end if
		return flag;
	} // chkOverToday
	
	function lpad0(number) {
		var temp = '';
		if(number < 10) {
			temp = '0' + number;
		} else { 
			temp = number;
		} // end else
		return temp;
	} // lpad0
	
	function drawLineChart(jsonObj) {
		var retvalData = getLineData(jsonObj);
		var options = {
				animationEnabled: true,
				theme: "light2",
				title:{
					text: "사이트 방문자수"
				},
				axisX:{
					valueFormatString: "MMM DD"
				},
				axisY: {
					title: "방문자수",
					suffix: "",
					minimum: -20
				},
				toolTip:{
					shared:true
				},  
				legend:{
					cursor:"pointer",
					verticalAlign: "bottom",
					horizontalAlign: "left",
					dockInsidePlotArea: true,
					itemclick: toogleDataSeries
				},
				data: [{
					type: "line",
					showInLegend: true,
					name: "비회원",
					markerType: "square",
					xValueFormatString: "YYYY-MM-DD",
					color: "#F08080",
					yValueFormatString: "#,###",
					dataPoints: retvalData[0]
				},
				{
					type: "line",
					showInLegend: true,
					name: "회원",
					lineDashType: "dash",
					yValueFormatString: "#,###",
					dataPoints: retvalData[1]
				}]
			};

		$("#contentSiteView").CanvasJSChart(options);
	} // drawLineChart 
	
	function getLineData(jsonObj) {
		var arrVisitor = new Array();
		var arrMember = new Array();
		var dateCol = null;
		var d = '';
		for(var i = 0; i < jsonObj.data.length; i++){
			d = jsonObj.data[i].col;
			dateCol = new Date(
					d.substring(0, d.indexOf('-')),
					d.substring(d.indexOf('-') + 1, d.lastIndexOf('-')) - 1,
					d.substr(d.lastIndexOf('-') + 1)
			);
			arrVisitor[i] = {x: dateCol, y: jsonObj.data[i].visitor};
			arrMember[i] = {x: dateCol, y: jsonObj.data[i].member};
		} // end for
		return [arrVisitor, arrMember];
	} // getLineData
	
	function callAjaxLineChart(){
		var param = {
				start: $("#datepickerViewStart").val(),
				end: $("#datepickerViewEnd").val(),
				interval: $("#selSiteView").val()
		}
		$.ajax({
			url: "mgt_dashboard_views_response.jsp",
			type: "POST",
			data: param,
			dataType: "JSON",
			error: function(xhr){
				alert(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					drawLineChart(jsonObj);
				} // end if
			} // success
		}); // ajax 
	} // callAjaxLineChart
	
	function getBarData(jsonObj) {
		var arrMemberNew = new Array();
		var arrMemberQuit = new Array();
		var dateCol = null;
		for(var i = 0; i < jsonObj.data.length; i++){
			dateCol = jsonObj.data[i].col;
			arrMemberNew[i] = {label: dateCol, y: jsonObj.data[i].memberNew};
			arrMemberQuit[i] = {label: dateCol, y: jsonObj.data[i].memberQuit};
		} // end for
		return [arrMemberNew, arrMemberQuit];
	} // getBarData
	
	function drawBarChart(jsonObj) {
		var retvalData = getBarData(jsonObj);
		var options = {
				animationEnabled: true,
				title:{
					text: "회원수 현황"   
				},
				axisY:{
					title:"명"
				},
				toolTip: {
					shared: true,
					reversed: true
				},
				data: [{
					type: "stackedColumn",
					name: "신규 회원수",
					showInLegend: "true",
					yValueFormatString: "#,##0명",
					dataPoints: retvalData[0]
				},
				{
					type: "stackedColumn",
					name: "탈퇴 회원수",
					showInLegend: "true",
					yValueFormatString: "#,##0명",
					dataPoints: retvalData[1]
				}]
			};
		$("#memberVariGraph").CanvasJSChart(options);
	} // drawBarChart
	
	function callAjaxBarChart() {
		var param = {
				start: $("#datepickerMemberStart").val(),
				end: $("#datepickerMemberEnd").val(),
				interval: $("#selMemberVari").val()
		}
		$.ajax({
			url: "mgt_dashboard_mem_vari_response.jsp",
			type: "POST",
			data: param,
			dataType: "JSON",
			error: function(xhr){
				alert(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					drawBarChart(jsonObj);
				} // end if
			} // success
		}); // ajax 
	} // callAjaxBarChart
	
	function toogleDataSeries(e){
		if (typeof(e.dataSeries.visible) === "undefined" || e.dataSeries.visible) {
			e.dataSeries.visible = false;
		} else{
			e.dataSeries.visible = true;
		}
		e.chart.render();
	} // toogleDataSeries
	
	function callAjaxRaViews() {
		let param = {selDate: $("#selRaView").val()};
		$.ajax({
			url: "mgt_dashboard_ra_view_response.jsp",
			type: "POST",
			data: param,
			dataType: "JSON",
			error: function(xhr){
				alert(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					let table = '';
					for(var i = 0; i < jsonObj.data.length; i++){
						table += '<tr>';
						table += '<td>' + jsonObj.data[i].ranking + '</td>';
						table += '<td>' + jsonObj.data[i].restAreaName + '</td>';
						table += '<td>' + jsonObj.data[i].views + '</td>';
						table += '</tr>'
					} // end for
					$("#raViewTbody").html(table);
				} // end if
			} // success
		}); // ajax 
	} // callAjaxRaViews
	
	function callAjaxReviews() {
		let param = {selDate: $("#selRaReview").val()};
		$.ajax({
			url: "mgt_dashboard_review_response.jsp",
			type: "POST",
			data: param,
			dataType: "JSON",
			error: function(xhr){
				alert(xhr.status + "/" + xhr.statusText);
			},
			success: function(jsonObj) {
				if(jsonObj.result) {
					let table = '';
					for(var i = 0; i < jsonObj.data.length; i++){
						table += '<tr>';
						table += '<td>' + jsonObj.data[i].ranking + '</td>';
						table += '<td>' + jsonObj.data[i].restAreaName + '</td>';
						table += '<td>' + jsonObj.data[i].reviews + '</td>';
						table += '</tr>'
					} // end for
					$("#reviewTbody").html(table);
				} // end if
			} // success
		}); // ajax 
	} // callAjaxReviews

</script>

</head>
<body class="bgColor">

<div id="wrap">

	<!-- 중앙 메인프레임 시작 -->
	<div id="mainFrame">
		<!-- 최상단 메뉴이름 타이틀바 시작 -->
		<div id="frmBackground">
			<span id="currentTopMenuName">대시보드</span>
			<!-- <span id="currentBottomMenuName"> > 문의</span> -->
		</div>
		<!-- 최상단 메뉴이름 타이틀바 끝 -->
		
		<!-- 내용 시작 -->
		<div id="content">
		
			<!-- 날짜 선택 -->
			<c:set var="date" value="<%=new java.util.Date()%>" />
 			<c:set var="dateLastMonth" value="<%=new java.util.Date(new java.util.Date().getTime() - 60*60*24*1000*30L)%>"/>
 			<c:set var="strDate"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd" /></c:set>
 			<c:set var="strDateLastMonth"><fmt:formatDate value="${dateLastMonth}" pattern="yyyy-MM-dd"/></c:set>
			<!-- 사이트 방문자수 -->
			<div id="siteView">
				<div class="subtitle">사이트 방문자수</div>
				<div class="selecDate">
					<form id="frmSiteView">
						시작일: <input type="text" id="datepickerViewStart" name="datepickerViewStart" readonly="readonly" class="datepicker" value="${strDateLastMonth }"/>
						종료일: <input type="text" id="datepickerViewEnd" name="datepickerViewEnd" readonly="readonly" class="datepicker" value="${strDate }"/>
						<select id="selSiteView" name="selSiteView">
							<option value="dd" selected="selected">일 단위</option>
							<option value="ww">주 단위 </option>
							<option value="mm">월 단위</option>
						</select>
						<input type="button" id="btnSiteView" value="조회" class="btn btn-secondary btn-sm"/>
					</form>
				</div>
				<div id="contentSiteView">
					사이트 방문자수 그래프
				</div>
			</div>
			
			<!-- 회원 수 변동 -->
			<div id="memberVari">
				<div class="subtitle">회원 수 변동</div>
				<div class="selecDate">
					<form id="frmMemberVari">
						시작일: <input type="text" id="datepickerMemberStart" name="datepickerMemberStart" readonly="readonly" class="datepicker" value="${strDateLastMonth }"/>
						종료일: <input type="text" id="datepickerMemberEnd" name="datepickerMemberEnd" readonly="readonly" class="datepicker" value="${strDate }"/>
						<select id="selMemberVari">
							<option value="dd" selected="selected">일 단위</option>
							<option value="ww">주 단위</option>
							<option value="mm">월 단위</option>
						</select>
						<input type="button" id="btnMemberVari" value="조회" class="btn btn-secondary btn-sm"/>
					</form>
				</div>
				<div id="contentMemberVari">
					<div id="memberVariGraph" class="graph">
						회원 수 변동 그래프
					</div>
				
					<div>
						<%
						try {
							MgtDashBoardDAO mdbDAO = MgtDashBoardDAO.getInstance();
							MemberVariTableVO mvtVO = mdbDAO.selectMemberCurrentSituation();
							pageContext.setAttribute("mvtVO", mvtVO);
						} catch (SQLException se) {
							se.printStackTrace();
						%>
						alert('문제가 발생했습니다. 잠시 후 다시 시도해주시기 바랍니다');
						<%
						} // end catch
						%>
						<table class="marginCenter" style="margin-bottom:5px;">
							<tr>
								<th>총 가입자수</th>
								<td style="width:120px"><c:out value="${mvtVO.signInTotal }"/></td>
								<th>현재 회원수</th>
								<td style="width:100px"><c:out value="${mvtVO.memberNowTotal }"/></td>
								<th>탈퇴수</th>
								<td style="width:80px"><c:out value="${mvtVO.memberQuitTotal }"/></td>
							</tr>
						</table>
					</div>
				</div>
			</div>
			
			<!-- 휴게소 조회수 -->
			<div id="raView">
				<div class="subtitle">휴게소 조회수</div>
				<div class="selecDate">
					<form id="frmRaView">
						<select id="selRaView">
							<option value="0">오늘</option>
							<option value="1">이번주</option>
							<option value="2" selected="selected">이번달</option>
						</select>
					</form>
				</div>
				<div id="contentRaView">
					<jsp:useBean id="listRvrVO" type = "java.util.List<prj2.mgt.dashboard.vo.RaViewRankVO>" scope="page"/>
					<jsp:setProperty property="*" name="listRvrVO"/>
					
					<table class="marginCenter marginTop">
						<thead>
							<tr>
								<th class="tableC1">순위</th>
								<th class="tableC2">휴게소명</th>
								<th class="tableC3">조회수</th>
							</tr>
						</thead>
						<tbody id="raViewTbody">
							<c:forEach var="rvrVO" items="${listRvrVO}">
								<tr>
									<td><c:out value="${rvrVO.ranking}"/></td>
									<td><c:out value="${rvrVO.restAreaName}"/></td>
									<td><c:out value="${rvrVO.views}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			
			<!-- 휴게소 리뷰수 -->
			<div id="raReview">
				<div class="subtitle">휴게소 리뷰수</div>
				<div class="selecDate">
					<form id="frmRaReview">
						<select id="selRaReview">
							<option value="0">오늘</option>
							<option value="1">이번주</option>
							<option value="2" selected="selected">이번달</option>
						</select>
					</form>
				</div>
				<div id="contentRaReview">
					<jsp:useBean id="listRrrVO" type = "java.util.List<prj2.mgt.dashboard.vo.RaReviewRankVO>" scope="page"/>
					<jsp:setProperty property="*" name="listRrrVO"/>
					<table class="marginCenter marginTop">
						<thead>
							<tr>
								<th class="tableC1">순위</th>
								<th class="tableC2">휴게소명</th>
								<th class="tableC3">리뷰수</th>
							</tr>
						</thead>
						<tbody id="reviewTbody">
							<c:forEach var="rrrVO" items="${listRrrVO}">
								<tr>
									<td><c:out value="${rrrVO.ranking}"/></td>
									<td><c:out value="${rrrVO.restAreaName}"/></td>
									<td><c:out value="${rrrVO.reviews}"/></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>			
			</div>
			
			<!-- 문의 내역 -->
			<div id="inquiryList">
				<div class="subtitle">문의 내역</div>
				<div id="contentInquiryList">
					<jsp:useBean id="listDiVO" type ="java.util.List<prj2.mgt.dashboard.vo.DashInquiryVO>" scope="page"/>
					<jsp:setProperty property="*" name="listDiVO"/>
					<table class="marginCenter marginTop">
						<c:forEach var="rrrVO" items="${listDiVO}">
							<tr class="borderBot">
							<td class="borderBot"><font color="#6079F8">●</font></td>
							<td class="borderBot tableC1"><fmt:formatDate value="${rrrVO.inputDate }" pattern="YYYY-MM-dd HH:mm:ss"/></td>
							<td class="borderBot tableC2_2"><c:out value="${rrrVO.title}"/></td>
							<c:choose>
								<c:when test="${rrrVO.flagAnswer eq false }">
									<td class="borderBot tableC3 fontRed">답변 전</td>
								</c:when>
								<c:otherwise>
									<td class="borderBot tableC3 fontBlue">답변 완료</td>
								</c:otherwise>
							</c:choose>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>

			<!-- 신고 내역 -->
			<div id="reportList">
				<div class="subtitle">신고 내역</div>
				<div id="contentReportList">
					<jsp:useBean id="listDrrVO" type ="java.util.List<prj2.mgt.dashboard.vo.DashReportVO>" scope="page"/>
					<jsp:setProperty property="*" name="listDrrVO"/>
					<table class="marginCenter marginTop">
						<c:forEach var="drrVO" items="${listDrrVO}">
							<tr class="borderBot">
								<td class="borderBot"><font color="#FD63A7">●</font></td>
								<td class="borderBot tableC1"><fmt:formatDate value="${drrVO.inputDate }" pattern="YYYY-MM-dd HH:mm:ss"/></td>
								<td class="borderBot tableC2_2"><c:out value="${drrVO.title}"/></td>
								<c:choose>
									<c:when test="${rrrVO.progressStatus eq 0 }">
										<td class="borderBot tableC3 fontRed">처리 전</td>
									</c:when>
									<c:when test="${rrrVO.progressStatus eq 1 }">
										<td class="borderBot tableC3">처리 중</td>
									</c:when>
									<c:otherwise>
										<td class="borderBot tableC3 fontBlue">처리 완료</td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		<!-- 내용 끝 -->
	</div>
	<!-- 중앙 메인프레임 끝 -->
</div>
</body>
</html>