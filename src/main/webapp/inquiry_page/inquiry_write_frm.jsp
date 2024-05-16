<%@page import="prj2VO.MemJoinVO"%>
<%@page import="java.util.List"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글작성"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	background: #FFFFFF url('http://192.168.10.218/common/images/header.png') no-repeat; }
	
	
	
	 #frmWrite {
        width: 1000px; /* 너비 설정 */
        height: 600px; /* 높이 설정 */
      }
      
      #inquiryContent {
   	 	max-width: 1000px; /* 최대 가로 넓이 설정 */
    	margin: 0 auto; /* 가운데 정렬을 위한 마진 설정 */
      }
      
       #title {
        height: 34px; /* 너비 설정 */
      }


	.tb_writeForm {
	  width: 100%;
	  border-top: 2px solid #C0C0C0;
	}
	
	.title {
    padding-top: 20px; /* 위쪽 패딩 */
  
	}
	
	.writer {
    padding-top: 20px; /* 위쪽 패딩 */
  
	}
	
	.space {
    padding-top: 10px; /* 위쪽 패딩 */
  
	}
	

	.btn-success {
	        background-color: #567FA8; /* 버튼의 배경색을 지정합니다. */
	        color: #FFFFFF; /* 버튼의 글자색을 지정합니다. */
	        border-color: transparent; /* 버튼의 테두리 색상을 투명하게 설정합니다. */
	    }
	    

	.button-container {
	  text-align: center;
	  padding-right: 166px;
	  padding-top: 10px;
	}
	
</style>
<script type="text/javascript">
	$(function(){
		$("#btnList").click(function(){
			history.back();
		});//click
		
		$("#btnWrite").click(function(){
			chkNull();
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
		/*
		if($("#cnt").val().trim()==""){
			$("#cnt").val( 0 );
		}//end if
		*/
		alert("aaaaa");
		
		$("#frmWrite").submit();//
		
		
	}//chkNull
</script>

<script>
	$(function(){
      $('#content').summernote({
        placeholder: '집 가고싶다',
        tabsize: 2,
        width: 700,
        height: 240,
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
<div id="inquiryContent">
	<form method="post" action="Inquiry_write_frm_process.jsp" name="frmWrite"
	id="frmWrite">
	<table class="tb_writeForm">
	<tr>
		<td class="title" colspan="2"><h3>문의글 쓰기</h3></td>
	</tr>
	<tr>
		<td class="writer">작성자</td>
		<td class="writer"><strong><c:out value="${ sessionScope.loginData.id }"/></strong></td>
	</tr>
	<tr>
		<td class="space">제목</td>
		<td class="space">
		<input type="text" name="title" id="title" style="width: 700px"/>
		</td>
	</tr>
	<tr>
		<td class="space">내용</td>
		<td class="space">
		<textarea id="content" name="content"></textarea>
		</td>
	</tr>
	<tr>
    <td class="space">비밀글</td>
    <td class="space">
        <input type="checkbox" id="secret" name="secret" value="true">
    </td>
	</tr>
	<tr>
		<td class="button-container" colspan="2" style="width: 80%;" >
		<input type="button" value="글작성" class="btn btn-success btn-sm" id="btnWrite"/>
		<input type="button" value="글목록" class="btn btn-success btn-sm" id="btnList"/>
		</td>
	</tr>
	</table>
	
	
	</form>

</div>

</div>
</body>
</html>