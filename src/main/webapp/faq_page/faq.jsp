<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="게시판 글 읽기"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!-- summernote 시작 -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
<!-- summernote 끝 -->
<style type="text/css">
	#wrap{ width: 1462px; height: 749px; margin: 0px auto; }
	
	.faq_wrap {
	max-width: 1100px;
    margin: 60px auto 150px;
    font-family: 'Noto Sans KR', sans-serif;
    letter-spacing: 0;
    overflow: hidden;
	}
	
	.f_quest {
	    background-color: #7395B7; /* 네모 상자의 배경색 */
	    padding: 20px; /* 내부 여백 설정 */
	    border-top-left-radius: 12px; /* 좌상단 모서리를 둥글게 만듭니다. */
	    border-top-right-radius: 12px; /* 우상단 모서리를 둥글게 만듭니다. */
	    color: #FFFFFF;
	}

	.f_ans {
	    background-color: #f9f9f9; /* 네모 상자의 배경색 */
	    padding: 20px; /* 내부 여백 설정 */
	    margin-bottom: 30px; /* 문의와 답변 사이의 간격 설정 */
	    border-bottom-left-radius: 12px; /* 좌상단 모서리를 둥글게 만듭니다. */
    	border-bottom-right-radius: 12px; /* 우상단 모서리를 둥글게 만듭니다. */
	}
	
	.faq_wrap ul li {
	    list-style: none; /* 리스트 아이템의 기본 마커를 없앱니다. */
	    padding-left: 40px; /* 점을 중앙 정렬하기 위한 왼쪽 여백 설정 */
	    position: relative; /* 포지션을 상대적으로 설정합니다. */
	}
	
	.faq_wrap ul li::before {
	    content: "\2022"; /* 원을 나타내는 유니코드 */
	    position: absolute; /* 점의 포지션을 설정합니다. */
	    left: 0; /* 왼쪽에 배치합니다. */
	    top: 50%; /* 위쪽으로 중앙에 위치시킵니다. */
	    transform: translateY(-50%); /* 수직으로 정렬합니다. */
	    color: #000; /* 점의 색상을 설정합니다. */
	    font-size: 18px; /* 점의 크기를 설정합니다. */
	    line-height: 1; /* 점의 높이를 설정합니다. */
	}
		
	
	
</style>
<script type="text/javascript">
	$(function(){
		
			
			$("#frmDetail").submit();
			
		
	});//ready
	

</script>

    
<div id="wrap">
<div id="header"></div>
<div id="boardContent">


	
	
	  <div class="faq_wrap">
            <ul>
                
                  
                    <li class="active">
                  
             
                        <div class="f_quest">
                          
                                <span>[사이트 이용]</span>
                                
                                

                                
                                

                                
                                

                                
                                고속도로 휴게소 포털의 데이터오류 발견시 어떻게 신고할 수 있나요? 

                                
                                
                           
                        </div>
                     
                        <div class="f_ans">
                            <p>데이터품질 오류를 신고하는 방법은 크게 2가지가 있습니다. 1. 시스템 접수 : 문의게시판에 접수 2. 이메일 접수 :  이메일을 통해 접수 (이메일 : rest_area@com) </p>
                        </div>
                    </li>
                
                  
                  
                    <li>
                  
                        <div class="f_quest">
                          
                                <span>[사이트 이용]</span>
                                
                                

                                
                                

                                
                                

                                
                                고속도로휴게소포털의 최적화면 해상도는 무엇인가요?

                                
                                
                       
                        </div>
                        <div class="f_ans">
                            <p>고속도로휴게소 포털의 최적 화면해상도는 1920 X 1080 입니다.</p>
                        </div>
                    </li>
                
                  
                  
                    <li>
                  
                        <div class="f_quest">
                           
                                <span>[휴게소 정보]</span>
                                
                                

                                
                                

                                
                                

                                
                                고속도로휴게소포털 데이터 출처가 궁금합니다.

                                
                                
                           
                        </div>
                        <div class="f_ans">
                            <p>일반적으로 자료의 출처는 화면 맨 아래쪽에 표시되어 있습니다. 출처가 표시되지 않은 자료는 확인 후에 출처를 표시하겠습니다. 감사합니다.</p>
                        </div>
                    </li>
                
                  
                  
                    <li>
                  
                        <div class="f_quest">
                           
                                <span>[기타]</span>
                                
                                

                                
                                

                                
                                

                                
                                고속도로 휴게소에 대한 추가정보는 어디서 확인하나요?

                                
                                
                           
                        </div>
                        <div class="f_ans">
                            <p>고속도로 휴게소에 대한 추가 정보는 한국휴게소정보포털 사이트에서 확인하실 수 있습니다. [한국휴게소정보포털 사이트 : https://korearestarea.or.kr]</p>
                        </div>
                    </li>
                
                  
                  
                    <li>
                  
                        <div class="f_quest">
                           
                                <span>[휴게소 정보]</span>
                                
                                

                                
                                

                                
                                

                                
                                고속도로휴게소포털의 정보를 다른 사이트로 복사 및 링크가 가능한가요 ?

                                
                                
                          
                        </div>
                        <div class="f_ans">
                            <p>다른사이트로 복사 및 링크는 가능하지만 반드시 출처를 명시해주시기를 부탁드립니다. 감사합니다.</p>
                        </div>
                    </li>
                
                  
                  
                    <li>
                  
                        <div class="f_quest">
                          
                                <span>[사이트 이용]</span>
                                
                                

                                
                                

                                
                                

                                
                               사이트 화면에 그림이 깨지거나 나오지 않습니다.

                                
                                
                           
                        </div>
                        <div class="f_ans">
                            <p>개인 PC 내에 임시파일,쿠키 등 검색기록이 남아있어 깨지는 현상이 일어날 수 있습니다. 인터넷옵션 > 검색기록 > 삭제 > 검색기록삭제 모두 체크 > 삭제버튼 클릭 이 방법을 실행하시면 해결하실 수 있습니다.</p>
                        </div>
                    </li>
                

                
                
            </ul>
        </div>
	
	


</div>

</div>
