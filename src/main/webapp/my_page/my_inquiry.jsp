<%@page import="prj2VO.MyInquiryVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="prj2DAO.MyInquiryDAO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(function(){
		
	});//ready
</script>

<!-- /////////////////////////////여기에 include////////////////////////////////////// -->
<!-- 내가 쓴 문의 시작 -->
<div id="wrap">
<div id="content">
<!-- table 시작 -->
<jsp:useBean id="sVO" class="prj2VO.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<%
try{
	MyInquiryDAO miDAO = MyInquiryDAO.getInstance();
	String memId = ((LoginVO) session.getAttribute("loginData")).getMemId();
	//1.총 레코드의 수 얻기
	int totalCount = miDAO.selectTotalCount(memId, sVO);
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
	
	List<MyInquiryVO> list = miDAO.selectBoard(memId, sVO);
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageScale", pageScale);
	pageContext.setAttribute("currentPage", currentPage);
%>	
<table class="table table-hover table-bordered">
  <thead>
    <tr>
      <th>#</th><!-- <th scope="col"> -->
      <th>문의 제목</th>
      <th>작성일</th>
      <th>답변</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
  <c:forEach var="miVO" items="${ list }" varStatus="i">
    <tr>
    	<!-- 번호를 마지막 숫자부터 출력 -->
      <td><c:out value="${ totalCount - (currentPage-1) * pageScale - i.index }"/></td>
      <td colspan="2">
      	<a href="../main_page/main_page.jsp?link=myPage&my=myInquiry&seq=${ miVO.inquiryNum }&currentPage=${empty param.currentPage ? 1 : param.currentPage}">
     		<c:out value="${ miVO.title }"/>
      	</a>
      </td>
      <td><c:out value="${ miVO.inputDate }"/></td>
      <td>
      	<c:if test="${ miVO.answerFlag eq 1 }">
      		<c:out value="답변보기"/>
      	</c:if>
      </td>
    </tr>
  </c:forEach>
  </tbody>
</table>
</div>
<!-- table 끝 -->

<!-- 검색 창 시작 -->
<div style="text-align: center;">
<form action="../main_page/main_page.jsp?link=myPage&my=myInquiry" name="searchFrm" id="searchFrm">
	<
</form>
</div>
<!-- 검색 창 끝 -->

<%}catch(SQLException se){
	se.printStackTrace();
	%>alert("죄송합니다. 잠시후 다시 시도해주세요.");<%
}//end catch
%>
</div><!-- wrap -->
<!-- 내가 쓴 문의 끝 -->
