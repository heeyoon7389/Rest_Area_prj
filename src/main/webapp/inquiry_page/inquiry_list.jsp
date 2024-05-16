<%@page import="restAreaInquiry.BoardUtil"%>
<%@page import="restAreaInquiry.InquiryVO"%>
<%@page import="restAreaInquiry.InquiryDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="문의 리스트"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!--<link rel="icon" href="http://192.168.10.210/jsp_prj/common/favicon.ico"/>-->
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->
<link rel="stylesheet" href="http://192.168.10.213/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.213/jsp_prj/common/css/board.css" type="text/css" media="all" />
<!--jquery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jquery CDN 끝-->

<style type="text/css">
	#wrap{ width: 1462px; height: 749px; margin: 0px auto; }
	#header{ height: 100px;
	background: #FFFFFF url('http://localhost/jsp_prj/common/images/header.png') no-repeat; }
	.num{ width: 80px}
	.title{ width :350px}
	.id{ width: 120px}
	.date{ width: 150px}
	
	
	.program_table table tr th {
    height: 47px;
    padding: 0 10px;
    font-size: 14px;
    color: #001e26;
    font-weight: bold;
    line-height: 1.4;
    background: #f9f8f8;
    text-align: center; /* 텍스트를 가운데 정렬합니다. */
    vertical-align: middle; 
	}

  .program_table tbody td {
        vertical-align: middle; /* 텍스트를 수직으로 중앙 정렬합니다. */
    }

  .paging {
        margin-top: 70px; /* 상단 여백을 20px로 설정하여 아래로 내립니다. */
    }
   
 
 .program_table {
        max-width: 85%; /* 최대 너비를 80%로 설정합니다. */
        margin: 0 auto; /* 가운데 정렬을 위해 좌우 마진을 자동으로 설정합니다. */
    }
	
	 .btn-info {
        background-color: #567FA8; /* 버튼의 배경색을 지정합니다. */
        color: #FFFFFF; /* 버튼의 글자색을 지정합니다. */
        border-color: transparent; /* 버튼의 테두리 색상을 투명하게 설정합니다. */
    }
	
</style>
<script type="text/javascript">
	$(function(){
		
		$("#btnSearch").click(function(){
			chkNull();
		});//click
		
		$("#btnAllSearch").click(function(){
			location.href="inquiry_list.jsp";
		});//click	
		
		$("#btnWrite").click(function(){
			location.href="inquiry_write_frm.jsp";
		});//click
		
		$("#keyword").keydown(function( evt ){
			if( evt.which == 13 ){
				chkNull();
			}//end if
		});//keydown
		
	});//ready
	
	function chkNull(){
		if($("#keyword").val().trim() != ""){
			//alert("검색키워드를 입력해주세요")
			$("#frmBoard").submit();
		}//end if
	}//chkNull
</script>
</head>
<body>
<div id="wrap">
<div id="header"></div>
<div id="content">
<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="sVO" class="prj2VO.SearchVO" scope="page"/>
<jsp:setProperty property="*" name="sVO"/>
<%
try{
	InquiryDAO iDAO=InquiryDAO.getInstance();
	//1.총 레코드의 수 얻기
	int totalCount=iDAO.selectTotalCount( sVO );
	//2.한 화면에 보여줄 게시물의 수 
	int pageScale=10;
	//3.총 페이지수
	int totalPage=(int)Math.ceil( (double)totalCount / pageScale);
	
	//4.시작페이지 번호
	String tempPage=sVO.getCurrentPage();
	int currentPage=1;
	if( tempPage != null ){
		try{
		currentPage=Integer.parseInt(tempPage);
		}catch(NumberFormatException nfe){
		}
	}//end if
	int startNum=currentPage * pageScale-pageScale +1;
	//5.끝 번호
	int endNum=startNum+pageScale-1;
	
	sVO.setStartNum(startNum);
	sVO.setEndNum(endNum);
	
	List<InquiryVO> list=iDAO.selectallInquiry(sVO);//시작번호와 끝 번호 사이의 글 조회
	pageContext.setAttribute("list", list);
	
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageScale", pageScale);
	pageContext.setAttribute("currentPage", currentPage);
%>
	총 레코드의 수 : <%= totalCount  %>건<br/>
	한 화면에 보여줄 게시물 수 : <%= pageScale  %>건<br/>
	총 페이지 수 : <%= totalPage  %>장<br/>
	클릭한페이지 : <%= tempPage  %>/<%= currentPage  %>번<br/>
	시작번호 :<%= startNum %>번<br/>
	끝번호 :<%= endNum %>번<br/>
	
	<div style="height: 500px"> 
	<input type="button" value="글작성" id="btnWrite" class="btn btn-info btn-sm"/>
	<div class="program_table">
	<table class="table">
		<thead>
		<tr>
		<th class="num">번호</th>
		<th class="title">제목</th>
		<th class="id">작성자</th>
		<th class="date">작성일</th>
		</tr>
		</thead>
		<tbody>
		<c:forEach var="iVO" items="${ list }" varStatus="i">
		<tr>
		<td><c:out value="${totalCount-(currentPage-1)*pageScale- i.index }"/></td>
		<td><a href="inquiry_read_frm.jsp?inquiry_num=${ iVO.inquirynum }&currentPage=${empty param.currentPage ?1:param.currentPage}"><c:out value="${ iVO.title }"/></a></td>
		<td><c:out value="${ iVO.memid }"/></td>
		<td><c:out value="${ iVO.input_date }"/></td>
		</tr>
		</c:forEach>
		</tbody>
	</table>
	</div>
	
	</div>
	
	<div class="paging">
	<div style="text-align:  center;">
	<form action="inquiry_list.jsp" name="frmBoard" id="frmBoard">
		<select name="field" id="field">
		<option value="0"${ param.field eq 0?" selected='selected'":"" }>제목</option>
		<option value="1"${ param.field eq 1?" selected='selected'":"" }>내용</option>
		<option value="2"${ param.field eq 2?" selected='selected'":"" }>작성자</option>
		</select>
		<input type="text" name="keyword" id="keyword" value="${ param.keyword }" style="width: 230px"/>
		<input type="button" value="검색" id="btnSearch" class="btn btn-info btn-sm"/>
		<input type="button" value="전체글" id="btnAllSearch" class="btn btn-info btn-sm"/>
		<input type="text" style="display: none;"/>
	</form>
	</div>
	</div>
	<div style="text-align:  center;">
	<%
	String param="";
	%>
	<c:if test="${ not empty param.keyword }">
	<%
		param="&field="+ request.getParameter("field")+"&keyword="
			+ request.getParameter("keyword");
	%>
	<c:set var="link2" value="&field=${param.field }&keyword=${param.keyword }"/>
	</c:if>
<%-- 
	<% for(int i=1 ; i <= totalPage ; i++){ %>
	[ <a href="board_list.jsp?currentPage=<%= i %>${ link2}"><%= i %></a> ]
	<% }//end for %>
	--%>
	
	
	<%= BoardUtil.getInstance().pageNation("inquiry_list.jsp",param,
			totalPage, currentPage)
	
		 
	%>
	<%-- <br/>
	시작 번호 <%= startPage %><br/>
	마지막 번호 <%= endPage %><br>
	--%>
	
	
	</div>
	
	 
	<% 
	
}catch(SQLException se){
	se.printStackTrace();
	out.println("ㅈㅅ 잠시후 다시시도! ㄴㅂㅂㅂㄸㅇ");
}
%>
</div>

</div>
</body>
</html>