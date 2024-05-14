

<%@page import="restAreaInquiry.InquirydetailVO"%>
<%@page import="restAreaInquiry.InquiryDAO"%>
<%@page import="prj2VO.MemJoinVO"%>
<%@page import="java.util.List"%>

<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글 읽기"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
 <%
//개발의 편의성을 위해서 로그인 한 것 처럼 코드를 작성한 후 작업진행.
MemJoinVO mVO=new MemJoinVO();
mVO.setId("anyid");

session.setAttribute("loginData", mVO); 
 %>
<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://192.168.10.213/jsp_prj/index.jsp"/>
</c:if>
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
<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->
<style type="text/css">
	#wrap{ width: 1462px; height: 749px; margin: 0px auto; }
	#header{ height: 100px;
	background: #FFFFFF url('http://localhost/jsp_prj/common/images/header.png') no-repeat; }
	
	
</style>
<script type="text/javascript">
	$(function(){
		$("#btnList").click(function(){
			//history.back();
			location.href="http://192.168.10.213/jsp_prj/board/board_list.jsp?currentPage=${ param.currentPage}";
		});//click
		
		$("#btnUpdate").click(function(){
			if(confirm("글을 수정하시겠습니까?")){
			chkNull();
			}
		});//click
		
		$("#btnDelete").click(function(){
			if(confirm("글을 정말 삭제하시겠습니까?")){
			//<form태그의 action 변경
			//document.frmDetail.action="back-end URL"
			$("#frmDetail")[0].action="board_delete_process.jsp";
			$("#frmDetail").submit();
			
			}//end if
			
		});//click
		
	});//ready
	
	function chkNull(){
		if($("#title").val().trim()==""){
			alert("글제목은 필수입력");
			$("#title").focus();
			return;
		}//end if
		
		if($("#content").val().trim()==""){
			alert("내용은 필수입력");
			$("#content").focus();
			return;
		}//end if
		
		if($("#cnt").val().trim()==""){
			$("#cnt").val( 0 );
		}//end if
		
		$("#frmDetail")[0].action="board_update_process.jsp";
		$("#frmDetail").submit();
		
		
	}//chkNull
</script>

<script>
	$(function(){
      $('#content').summernote({
        placeholder: '집 가고싶다',
        tabsize: 2,
        width: 600,
        height: 200,
        toolbar: [
          ['style', ['style']],
          ['font', ['bold', 'underline', 'clear']],
          ['color', ['color']],
          ['para', ['ul', 'ol', 'paragraph']],
          ['table', ['table']],
          ['insert', ['link', 'picture', 'video']],
          ['view', ['fullscreen', 'codeview', 'help']]
        ]
      });//summernote
	});//ready
    </script>
    
    
</head>
<body>
<div id="wrap">
<div id="header"></div>
<div id="boardContent">
<%
InquiryDAO iDAO=InquiryDAO.getInstance();

	try{
		String num=request.getParameter("inquiry_num");
		
		InquirydetailVO idVO=iDAO.selectoneInquiry(num);
	
		pageContext.setAttribute("idVO", idVO);
	}catch(SQLException se){
		se.printStackTrace();
%>

	<script type="text/javascript">
	location.href="http://192.168.10.213/jsp_prj/error/err_500.html";
	</script>
	<% 
	}//end catch

%>


	<form method="post" name="frmDetail" id="frmDetail">
	<input type="hidden" name="num" value="${ idVO.inquirynum }"/>
	
	<table>
	<tr>
		<td colspan="2"><h3>글읽기</h3></td>
	</tr>
	<tr>
		<td>제목</td>
		<td>
		<input type="text" name="title" id="title" style="width: 600px"
			value="${ idVO.title }"/>
		</td>
	</tr>
	<tr>
		<td>작성일</td>
		<td><strong><fmt:formatDate value="${ idVO.input_date }"
			pattern="yyyy-MM-dd EEEE HH:mm:ss"/></strong></td>
	</tr>
	<tr>
		<td>작성자</td>
		<td><strong><c:out value="${ idVO.memid}"/></strong></td>
	</tr>
	<tr>
		<td>내용</td>
		<td>
		<textarea id="content" name="content">${ idVO.content }</textarea>
		</td>
	</tr>
	<tr>
		<td colspan="2" style="text-align: center;">
		<input type="button" value="글수정" class="btn btn-success btn-sm" id="btnUpdate"/>
		<c:if test="${ idVO.memid eq sessionScope.loginData.id }">
		<input type="button" value="글삭제" class="btn btn-warning btn-sm" id="btnDelete"/>
		</c:if>
		<input type="button" value="글목록" class="btn btn-info btn-sm" id="btnList"/>
		</td>
	</tr>
	</table>
	
	
	</form>

</div>

</div>
</body>
</html>