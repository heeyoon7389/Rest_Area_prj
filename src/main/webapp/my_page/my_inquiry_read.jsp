<%@page import="prj2VO.MyInquiryVO"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.MyInquiryDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->
<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://localhost/Rest_Area_prj/main_page/main_page.jsp"/>
</c:if>

<style type="text/css">
	table{ margin: 0 auto; }
	th{ padding: 20px 5px; /* 	안쪽공백 */}
	input[type=button]{ margin: 0px 5px 0px 5px;}
	
 	textarea[readonly] { 
 		background-color: #f2f2f2; 
/*  		cursor: not-allowed; *//*엑스표 커서*/
 	}
 	input[readonly] { 
 		background-color: #f2f2f2; 
 	}

</style>

<script type="text/javascript">
	$(function(){
		$("#btnList").click(function(){
			location.href="../main_page/main_page.jsp?link=myPage&my=myInquiry&currentPage=${ param.currentPage }"
		});//click
		
		$("#btnUpdate").click(function(){
			if(confirm("문의를 수정하시겠습니까?")){
				chkNull();
			}
		});//click
		$("#btnDelete").click(function(){
			if(confirm("정말 문의를 삭제하시겠습니까?")){
				$("#frmDetail")[0].action = "../my_page/my_inquiry_delete_process.jsp";
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
		
		//첫번째 액션에 설정주기
		$("#frmDetail")[0].action = "../my_page/my_inquiry_update_process.jsp";
		$("#frmDetail").submit();
	}//chkNull
</script>

<script>
$(function(){
    $('#content').summernote({
      tabsize: 2,
      width: 800,
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

<div id="wrap">
<!-- 문의 내용 시작 -->
<div id="boardContent">
<%
	MyInquiryDAO miDAO = MyInquiryDAO.getInstance();
	try{
		String seq = request.getParameter("seq");
		//상세보기
		MyInquiryVO miVO = miDAO.selectDetailBoard(seq);
		pageContext.setAttribute("miVO", miVO);
	}catch(SQLException se){
		se.printStackTrace();
		out.println("죄송합니다. 잠시후 다시 시도해주세요.");
	}//end catch
%>
<form method="post" name="frmDetail" id="frmDetail" >
<input type="hidden" name="inquiryNum" value="${ miVO.inquiryNum }"/>
<input type="hidden" name="currentPage" value="${ param.currentPage }"/>
<table>
<tr>
	<th>제목</th>
	<td>
	<input type="text" name="title" id="title" style="width: 800px" value="${ miVO.title }" ${ miVO.answerFlag eq '1' ? 'readonly="readonly"' : '' }/>
	</td>
</tr>
<tr>
	<th>내용</th>
	<td>
	<textarea name="content" ${ miVO.answerFlag eq '1' ? ' id="content2" readonly="readonly" style="width: 100%; height: 200px;" ' : ' id="content" ' }>${ miVO.content }</textarea>
	</td>
</tr>
<tr>
	<th>작성일</th>
	<td style="text-align: right;"><strong><fmt:formatDate value="${ miVO.inputDate }" pattern="yyyy-MM-dd EEEE HH:mm:ss"/></strong></td>
</tr>
<c:if test="${ miVO.answerFlag eq '1' }">
<tr>
	<th>답변 작성일</th>
	<td style="text-align: right;"><strong><fmt:formatDate value="${ miVO.answerDate }" pattern="yyyy-MM-dd EEEE HH:mm:ss"/></strong></td>
</tr>
<tr>
	<th>답변 내용</th>
	<td>
	<textarea name="answerContents" id="answerContents" readonly="readonly" style="width: 100%; height: 200px;">${ miVO.answerContents }</textarea>
	</td>
</tr>
</c:if>
</table>
<div style="text-align: center; margin-top: 30px;">
<c:if test="${ miVO.answerFlag ne '1' }">
	<input type="button" value="문의수정" class="btn btn-success" id="btnUpdate"/>
	<input type="button" value="문의삭제" class="btn btn-warning" id="btnDelete"/>
</c:if>
	<input type="button" value="문의목록" class="btn btn-info" id="btnList"/>
</div>
</form>
</div>
<!-- 문의 내용 끝 -->
</div>
