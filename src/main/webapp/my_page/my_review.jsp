<%@page import="prj2DAO.BoardUtil"%>
<%@page import="prj2VO.MyReviewVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="prj2DAO.MyReviewDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 별점css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<!-- 별점css -->
<style type="text/css">

.rating__star {
   font-size: 1.3em;
   cursor: pointer;
   color: #dabd18b2;
   transition: filter linear .3s;
    cursor: default;
}
</style>

<jsp:useBean id="sVO" class="prj2VO.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<%
try{
	MyReviewDAO mrDAO = MyReviewDAO.getInstance();
	String memId = ((LoginVO) session.getAttribute("loginData")).getMemId();
	//1.총 레코드의 수 얻기
	int totalCount = mrDAO.selectTotalCount(memId, sVO);
	//2. 한 화면에 보여줄 게시물의 수
	int pageScale=10;
	//3. 총 페이지 수
	int totalPage = (int)Math.ceil( (double)totalCount / pageScale);
	
	//4. 시작 페이지 번호 currentPage : 선택된 페이지의 번호
	String tempPage = sVO.getCurrentPage();
	int currentPage = 1;
	if(tempPage != null){
		try{
			currentPage = Integer.parseInt(tempPage);
		}catch(NumberFormatException nfe){
		}//end catch
	}//end if
	//각 페이지 첫번째 레코드 숫자
	int startNum = (currentPage * pageScale) - pageScale + 1;
	//5. 끝번호
	int endNum = startNum + pageScale - 1;
	
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	
	List<MyReviewVO> list = mrDAO.selectBoard(memId, sVO);
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageScale", pageScale);
	pageContext.setAttribute("currentPage", currentPage);
	
	//휴게소 이름 설정
	for (MyReviewVO mrVO : list) {
	    String raName = mrDAO.selectRaName(mrVO.getRaNum());
	    double star = mrDAO.selectStar(mrVO.getMemId(), mrVO.getRaNum());
	    mrVO.setRaName(raName);
	    mrVO.setStar(star);
	}//end for
%>	
<script type="text/javascript">
	$(function(){
		$("#btnSearch").click(function(){
			chkNull();
		});//click
		
		$("#btnAllSearch").click(function(){
			location.href="../main_page/main_page.jsp?link=myPage&my=myReview";
		});//click
		
		$("#keyword").keydown(function( evt ){
			if(evt.which == 13){
				chkNull();
			}
		});//keydown
		
		
 		//별점설정
	    $(".rating").each(function() {
	        const starValue = parseFloat($(this).prev().val()); // 열의 별점 값 가져오기
	        const ratingStars = $(this).find('.rating__star'); // 열의 별 요소 가져오기
	        console.log(starValue);
	        console.log(ratingStars);
	        // 별점 값에 따라 별 채우기
	        for (let i = 0; i < starValue; i++) {
	            $(ratingStars[i]).addClass('fas').removeClass('far');
	        }
	    });
		
	});//ready
	
	function chkNull(){
		if($("#keyword").val().trim() != ""){
			var field = $("#field").val();
			var keyword = $("#keyword").val();
			$("#searchFrm").submit();
		}
	}//chkNull
</script>

<!-- 내가 쓴 리뷰 시작 -->
<div id="wrap">
<div id="content">
<!-- table 시작 -->
<table class="table table-hover table-bordered">
  <thead>
    <tr>
      <th>#</th><!-- <th scope="col"> -->
      <th>휴게소</th>
      <th colspan="2">리뷰</th>
      <th>별점</th>
      <th>작성일</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
  <c:forEach var="mrVO" items="${ list }" varStatus="i">
    <tr>
    	<!-- 번호를 마지막 숫자부터 출력 -->
      <td><c:out value="${ totalCount - (currentPage-1) * pageScale - i.index }"/></td>
      <td>
		<!-- 휴게소 이름 -->
		<c:out value="${ mrVO.raName }"/>
      </td>
      <td colspan="2">
      	<a href="../main_page/main_page.jsp?link=myPage&my=myReview_read&seq=${ mrVO.raReviewNum }&currentPage=${empty param.currentPage ? 1 : param.currentPage}" style="text-decoration:none; color: black;">
     		<c:out value="${ mrVO.content }"/>
      	</a>
      </td>
      <td>
		<!-- 별점 -->
      	<input type="hidden" name="star" value="${ mrVO.star }"/>
      	<div class="rating">
    		<i class="rating__star far fa-star"></i>
    		<i class="rating__star far fa-star"></i>
    		<i class="rating__star far fa-star"></i>
    		<i class="rating__star far fa-star"></i>
    		<i class="rating__star far fa-star"></i>
		</div>
      </td>
      <td><c:out value="${ mrVO.inputDate }"/></td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
<!-- table 끝 -->

<!-- 검색 창 시작 -->
<div style="text-align: center;">
<form name="searchFrm" id="searchFrm" action="main_page.jsp">
	<input type="hidden" name="link" value="myPage"/>
	<input type="hidden" name="my" value="myReview"/><!-- 파라메터 다시 주기 -->
	<select name="field" id="field">
	<option value="0"${ param.field eq 0 ? " selected='selected' " : "" }>휴게소</option>
	<option value="1"${ param.field eq 1 ? " selected='selected' " : "" }>내용</option>
	</select>
	<input type="text" name="keyword" id="keyword" value="${ param.keyword }" style="width: 230px" />
	<input type="button" value="검색" id="btnSearch" class="btn btn-info btn-sm"/>
	<input type="button" value="전체글" id="btnAllSearch" class="btn btn-info btn-sm"/>
	<input type="text" style="display: none;"/>
</form>
</div>
<!-- 검색 창 끝 -->
<!-- pageNation 시작 -->
<div style="text-align: center;">
	<%
	String param="";
	%>
	<c:if test="${ not empty param.keyword }">
	<%
	param = "&field" + request.getParameter("field") + "&keyword=" + request.getParameter("keyword");
	%>
	<c:set var="link2" value="&field=${param.field }&keyword=${param.keyword }"/>
	</c:if>
	
	<%= BoardUtil.getInstance().pageNation("../main_page/main_page.jsp?link=myPage&my=myReview", param, totalPage, currentPage) %>
	<br>
</div>
<!-- pageNation 끝 -->

<%}catch(SQLException se){
	se.printStackTrace();
	out.println("죄송합니다. 잠시후 다시 시도해주세요.");
}//end catch
%>
</div><!-- wrap -->
<!-- 내가 쓴 리뷰 끝 -->
