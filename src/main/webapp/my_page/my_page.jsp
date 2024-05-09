<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
/*     즐겨찾기 삭제버튼 오른쪽 정렬 */
    .right{text-align: right;}
    
/*     내 정보 수정 설정 */
    	.agree {
            height: 150px;
            border: 1px solid black;
            overflow-y: scroll; /* y축으로 오버플로우 되는 것을 scroll방식으로 바꾸는 것 */    
        }
        .chkAgree {
            text-align: right;
            background-color: #F1F3F5;
            padding-top: 4px;  
        }
        th { vertical-align: middle; }
        .space {
            width: 5px;
            height: auto;
            display: inline-block; 
        }
        .space2 {
            width: 25px;
            height: auto;
            display: inline-block; 
        }
        .writeForm_btn{ padding-bottom: 10px; }
        
        .writeForm_btn .btn{ width: 150px; }
        
       .mp-item {
   		 padding-right: 10px;
   		 padding-left: 10px;
    	 font-size: 20px;
    	 font-weight: bold;
		}
    #myFavorite .nav-link{color: black; }
    #myReview .nav-link{color: black;}
    #myInquiry .nav-link{color: black;}
    #myInfo .nav-link{color: black;}
    
    .table-padding{
    	padding-right: 100px; 
    	padding-left: 100px; 
    }
    
</style>

<script type="text/javascript">
	$(function(){
		
	});//ready
</script>

<!--     마이페이지 네비게이션 시작 -->
    <header class="d-flex justify-content-center py-3">
      <ul class="nav nav-pills">
        <li class="nav-item mp-item" id="myFavorite"><a href="../main_page/main_page.jsp?link=myPage&my=myFavorite" class="nav-link">즐겨찾기</a></li>
        <li class="nav-item mp-item" id="myReview"><a href="../main_page/main_page.jsp?link=myPage&my=myReview" class="nav-link">내가 쓴 리뷰</a></li>
        <li class="nav-item mp-item" id="myInquiry"><a href="../main_page/main_page.jsp?link=myPage&my=myInquiry" class="nav-link">내가 쓴 문의</a></li>
        <li class="nav-item mp-item" id="myInfo"><a href="../main_page/main_page.jsp?link=myPage&my=myInfo" class="nav-link">내 정보 수정</a></li>
      </ul>
    </header>
<!--     마이페이지 네비게이션 끝 -->
<!-- /////////////////////////////여기에 include////////////////////////////////////// -->
<div>
<!-- 기본값 설정 -->
<c:if test="${ empty param.my }">
<c:import url="../my_page/my_favorite.jsp"/>
</c:if>
<!-- include될 jsp 설정 -->
<c:if test="${ not empty param.my }">
	<c:choose>
		<c:when test="${ param.my eq 'myFavorite' }"><!-- 	즐겨찾기 클릭 시 -->
		<c:import url="../my_page/my_favorite.jsp"/>
		</c:when>
		<c:when test="${ param.my eq 'myReview' }"><!-- 	내가 쓴 리뷰 클릭 시 -->
		<c:import url="../my_page/my_review.jsp"/>
		</c:when>
		<c:when test="${ param.my eq 'myInquiry' }"><!-- 	내가 쓴 문의 클릭 시 -->
		<c:import url="../my_page/my_inquiry.jsp"/>
		</c:when>
		<c:when test="${ param.my eq 'myInfo' }"><!-- 	내 정보 수정 클릭 시 -->
		<c:import url="../my_page/my_info.jsp"/>
		</c:when>
	</c:choose>
</c:if>
</div>
<!-- /////////////////////////////여기에 include////////////////////////////////////// -->
