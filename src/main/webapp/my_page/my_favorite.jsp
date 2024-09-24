<%@page import="java.sql.SQLException"%>
<%@page import="prj2VO.MyFavoriteVO"%>
<%@page import="java.util.List"%>
<%@page import="prj2VO.LoginVO"%>
<%@page import="prj2DAO.BoardUtil"%>
<%@page import="prj2DAO.MyFavoriteDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(function(){
		$("#btnSearch").click(function(){
			chkNull();
		});//click
		
		$("#btnAllSearch").click(function(){
			location.href="../main_page/main_page.jsp?link=myPage&my=myFavorite";
		});//click
		
		$("#keyword").keydown(function( evt ){
			if(evt.which == 13){
				chkNull();
			}
		});//keydown
		
		$("#del").click(function(){
			var chk = [];
			$("input[name='chk']:checked").each(function(i){
				chk.push($(this).val());
			});
			if(chk.length == 0) {
				alert("삭제할 즐겨찾기를 선택해주세요.");
			    return;
			}else{
			$.ajax({
				url: "../my_page/my_favorite_delete_process.jsp",
				type: "GET",
				data: {"chkArr":chk},
				dataType : "JSON",
				error: function(xhr){
					alert("죄송합니다. 잠시후 다시 시도해주세요.");
					console.log(xhr.status);
				},
				success : function(jsonObj){
					console.log(jsonObj);
					if(jsonObj.flag){
						location.reload();
						alert("즐겨찾기가 " + jsonObj.cnt + "건 삭제되었습니다.");
					}//end if
				}//success
			});//ajax
			}//end else
		});//click
	});//ready
	
	function chkNull(){
		if($("#keyword").val().trim() != ""){
			var field = $("#field").val();
			var keyword = $("#keyword").val();
// 			$("#searchFrm").submit(); 검색 안됨
		}
	}//chkNull
</script>

<!-- 즐겨찾기 시작 -->
<div id="wrap">
<div id="content">
<!-- table 시작 -->
<jsp:useBean id="sVO" class="prj2VO.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<%
try{
	MyFavoriteDAO mfDAO = MyFavoriteDAO.getInstance();
	String memId = ((LoginVO) session.getAttribute("loginData")).getMemId();
	//1.총 레코드의 수 얻기
	int totalCount = mfDAO.selectTotalCount(memId, sVO);
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
	
	List<MyFavoriteVO> list = mfDAO.selectBoard(memId, sVO);
	pageContext.setAttribute("list", list);
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageScale", pageScale);
	pageContext.setAttribute("currentPage", currentPage);
	
	//휴게소 이름&주소 설정
	for (MyFavoriteVO mfVO : list) {
		MyFavoriteVO raVO = mfDAO.selectRaName(mfVO.getRaNum());
	    mfVO.setRaName(raVO.getRaName());
	    mfVO.setAddr(raVO.getAddr());
	}

%>	
<table class="table table-hover table-bordered">
  <thead>
    <tr>
      <th>#</th>
      <th>휴게소</th>
      <th colspan="2">주소</th>
      <th>등록일</th>
      <th>선택</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
  <c:forEach var="mfVO" items="${ list }" varStatus="i">
    <tr>
    	<!-- 번호를 마지막 숫자부터 출력 -->
      <td><c:out value="${ totalCount - (currentPage-1) * pageScale - i.index }"/></td>
      <td>
		<!-- 휴게소 이름 -->
		<c:out value="${ mfVO.raName }"/>
      </td>
      <td colspan="2">
     		<c:out value="${ mfVO.addr }"/>
      </td>
      <td><c:out value="${ mfVO.inputDate }"/></td>
      <td><input type="checkbox" name="chk" value="${ mfVO.raNum }"></td>
    </tr>
  </c:forEach>
  </tbody>
</table>
<input type="button" name="del" id="del" value="삭제" class="btn btn-danger btn-sm" style="float: right;"/>
<!-- </form> -->
</div>
<!-- table 끝 -->

<!-- 검색 창 시작 -->
<div style="text-align: center;">
<form name="searchFrm" id="searchFrm" action="main_page.jsp">
	<input type="hidden" name="link" value="myPage"/>
	<input type="hidden" name="my" value="myFavorite"/><!-- 파라메터 다시 주기 -->
	<select name="field" id="field">
	<option value="0"${ param.field eq 0 ? " selected='selected' " : "" }>휴게소</option>
	<option value="1"${ param.field eq 1 ? " selected='selected' " : "" }>주소</option>
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
	
	<%= BoardUtil.getInstance().pageNation("../main_page/main_page.jsp?link=myPage&my=myFavorite", param, totalPage, currentPage) %>
	<br>
</div>
<!-- pageNation 끝 -->

<%}catch(SQLException se){
	se.printStackTrace();
	System.out.println("죄송합니다. 잠시후 다시 시도해주세요.");
}//end catch
%>
</div><!-- wrap -->
<!-- 즐겨찾기 끝 -->
