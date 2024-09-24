<%@page import="restAreaAnnounce.AnnounceVO"%>
<%@page import="restAreaAnnounce.AnnounceDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="공지사항 상세보기"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->
<style type="text/css">
	#wrap{ width: 1000px; height: 749px; margin: 0px auto; }
	
	.programCon {
    max-width: 1000px;
    margin: 60px auto 150px;
    font-family: 'Noto Sans KR', sans-serif;
    letter-spacing: 0;
    overflow: hidden;
	}
	
	
	.announce-details {
	table-layout: fixed;
    width: 100%;
    border-collapse: collapse;
    border-top: 1px solid #ececec;
    font-size: 16px;
    line-height: 20px;
    color: #5e636d;
  
	}
	

	.announce-title {
	border-top: 1px solid #000000;
	border-bottom: 2px solid #E0E0E0; /* 줄의 스타일과 색상을 설정합니다. */
    padding-bottom: 10px; /* 줄 아래에 여백을 설정합니다. */
    padding-left: 20px;
    padding-top: 20px;
    background-color: #F5F5F5;
    color: #000000;
    font-size: 40px;
	}
	
	.announce-content {
	border-top: 3px solid #E0E0E0;
	border-bottom: 2px solid #E0E0E0; /* 줄의 스타일과 색상을 설정합니다. */
    padding-bottom: 200px; /* 줄 아래에 여백을 설정합니다. */
    padding-top: 200px;
    color: #5e636d;
    text-align: center;
    font-size: 20px;
    border-collapse: collapse;
	}

	.button-container {
	 padding-top: 20px;
	 padding-bottom: 20px; 
	 padding-right: 40px;
	 border-top: 1px solid #E0E0E0;
	 border-bottom: 3px solid #E0E0E0;
	}

	.btn-info {
	        background-color: #567FA8; /* 버튼의 배경색을 지정합니다. */
	        color: #FFFFFF; /* 버튼의 글자색을 지정합니다. */
	        border-color: transparent; /* 버튼의 테두리 색상을 투명하게 설정합니다. */
	        width: 100px; /* 원하는 너비로 설정합니다. */
    		height: 50px; /* 원하는 높이로 설정합니다. */
    		font-size: 20px;
	    }
	
	.announce-info {
    text-align: left;
    padding-top: 20px;
    padding-bottom: 20px;
    padding-left: 20px;
    border-top: 2px solid #E0E0E0;
	}

	.announce-info span {
	    margin-right: 20px; /* 각 항목 사이에 오른쪽 여백을 추가합니다. */
	    font-size: 20px;
	}
	
</style>
<script type="text/javascript">
	$(function(){
		$("#btnList").click(function(){
			//history.back();
			location.href="../main_page/main_page.jsp?link=announce&currentPage=${ param.currentPage}";
		});//click
	
	});//ready
	
</script>
    
<div id="wrap">
<div id="programCon">
<div id="boardContent">
<%
	AnnounceDAO aDAO=AnnounceDAO.getInstance();

	try{
		String num=request.getParameter("announce_num");
		
		AnnounceVO aVO=aDAO.selectoneAnnounce(num);
		
		pageContext.setAttribute("aVO", aVO);
	}catch(SQLException se){
		se.printStackTrace();
	%>
	<script type="text/javascript">
	location.href="../common/err_500.html";
	</script>
	<% 
	}//end catch

%>


	
	<div class="announce-details">
	    <div class="announce-title">
	        <h3><c:out value="${aVO.title}" /></h3>
	        </div>
	       <div class="announce-info">
	        <span>작성자: <c:out value="${aVO.managerid}" /></span>
	        <span>작성일: <c:out value="${aVO.input_date}" /></span>
	        <span>조회수: <c:out value="${aVO.announce_view}" /></span>
	    </div>
	    <div class="announce-content">
	        <p><c:out value="${aVO.content}" /></p>
	    </div>
	    <div class="button-container" style="text-align: right;">
	    <input type="button" value="글목록" class="btn btn-info btn-sm" id="btnList"/>
	    </div>
	</div>
	
	
	
	</div>
</div>
</div>
