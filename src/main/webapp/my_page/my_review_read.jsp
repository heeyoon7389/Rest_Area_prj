<%@page import="prj2DAO.MyReviewDAO"%>
<%@page import="prj2VO.MyReviewVO"%>
<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->
<!-- 별점css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css">
<!-- 별점css -->

<c:if test="${ empty sessionScope.loginData }">
	<c:redirect url="http://localhost/Rest_Area_prj/main_page/main_page.jsp"/>
</c:if>

<style type="text/css">
	table{ margin: 0 auto; }
	th{ padding: 20px 0px; /* 	안쪽공백 */}
	input[type=button]{ margin: 0px 5px 0px 5px;}
	
/* 	휴게소 이름 readonly css */
	input[readonly] { 
 		background-color: #f2f2f2; 
 	}
 	
/*  	별점 css */
.rating__star {
   font-size: 1.3em;
   cursor: pointer;
   color: #dabd18b2;
   transition: filter linear .3s;
}

.rating__star:hover {
   filter: drop-shadow(1px 1px 4px gold);
} 	
</style>

<%
MyReviewDAO mrDAO = MyReviewDAO.getInstance();
try{
	String seq = request.getParameter("seq");
	//상세보기
	MyReviewVO mrVO = mrDAO.selectDetailBoard(seq);
	//휴게소 이름 & 별점 설정 
	String raName = mrDAO.selectRaName(mrVO.getRaNum());
	double star = mrDAO.selectStar(mrVO.getMemId(), mrVO.getRaNum());
	mrVO.setRaName(raName);
	mrVO.setStar(star);
	
	pageContext.setAttribute("mrVO", mrVO);
	
	// JSP에서 기본값 설정
	pageContext.setAttribute("defaultRating", mrVO.getStar());
	
}catch(SQLException se){
	se.printStackTrace();
	out.println("죄송합니다. 잠시후 다시 시도해주세요.");
}//end catch
%>

<script type="text/javascript">
	$(function(){
		$("#btnList").click(function(){
			location.href="../main_page/main_page.jsp?link=myPage&my=myReview&currentPage=${ param.currentPage }"
		});//click
		
		$("#btnUpdate").click(function(){
			if(confirm("리뷰를 수정하시겠습니까?")){
				chkNull();
			}
		});//click
		$("#btnDelete").click(function(){
			if(confirm("정말 리뷰를 삭제하시겠습니까?")){
				$("#frmDetail")[0].action = "../my_page/my_review_delete_process.jsp";
				$("#frmDetail").submit();
			}//end if
		});//click
		
		
		//별점 설정
		const ratingStars = document.querySelectorAll('.rating__star');
   		const resultDiv = document.getElementById('result');

    	let ratingValue =<%= pageContext.getAttribute("defaultRating") %>;//별점 기본값 설정
    	$("#starInput").val(ratingValue); // 초기값 설정

    	for(let i = 0; i < ratingStars.length; i++) {
        	ratingStars[i].addEventListener('click', function() {	
            	const {length} = ratingStars;
            	for(let j = 0; j < length; j++) {
                	if(j <= i) {
                    	ratingStars[j].classList.add('fas');
                    	ratingStars[j].classList.remove('far');
                	} else {
                    	ratingStars[j].classList.add('far');
                    	ratingStars[j].classList.remove('fas');
                	}//end else
            	}//end for
            	ratingValue = i + 1;
            	resultDiv.textContent = ratingValue + '점';
            	$("#starInput").val(ratingValue); // 선택된 별점 값 설정
        	});//click
   	 	}//end for
    
    	for(let i = 0; i < ratingValue; i++) {
        	ratingStars[i].classList.add('fas');
        	ratingStars[i].classList.remove('far');
    	}
	});//ready
	
	function chkNull(){
		if($("#content").val().trim()==""){
			alert("내용은 필수입력");
			$("#content").focus();
			return;
		}//end if
		
		//첫번째 액션에 설정주기
		$("#frmDetail")[0].action = "../my_page/my_review_update_process.jsp";
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
<!-- 리뷰 내용 시작 -->
<div id="boardContent">
<form method="post" name="frmDetail" id="frmDetail" >
<input type="hidden" name="raReviewNum" value="${ mrVO.raReviewNum }"/>
<input type="hidden" name="raNum" value="${ mrVO.raNum }"/>
<input type="hidden" name="star" id="starInput"/>
<input type="hidden" name="currentPage" value="${ param.currentPage }"/>
<table>
<tr>
	<th>휴게소</th>
	<td>
	<input type="text" name="raName" id="raName" style="width: 400px" value="${ mrVO.raName }" readonly="readonly"/>
	</td>
</tr>
<tr>
	<th>별점</th>
	<td>
	<div class="rating">
    <i class="rating__star far fa-star"></i>
    <i class="rating__star far fa-star"></i>
    <i class="rating__star far fa-star"></i>
    <i class="rating__star far fa-star"></i>
    <i class="rating__star far fa-star"></i>
    <span id="result"></span> 
	</div>
	</td>
</tr>
<tr>
	<th>리뷰 내용</th>
	<td>
	<textarea name="content" id="content">${ mrVO.content }</textarea>
	</td>
</tr>
<tr>
	<th>작성일</th>
	<td style="text-align: right;"><strong><fmt:formatDate value="${ mrVO.inputDate }" pattern="yyyy-MM-dd EEEE HH:mm:ss"/></strong></td>
</tr>
</table>
<div style="text-align: center; margin-top: 30px;">
	<input type="button" value="리뷰수정" class="btn btn-success" id="btnUpdate"/>
	<input type="button" value="리뷰삭제" class="btn btn-warning" id="btnDelete"/>
	<input type="button" value="리뷰목록" class="btn btn-info" id="btnList"/>
</div>
</form>
</div>
<!-- 리뷰 내용 끝 -->
</div>
