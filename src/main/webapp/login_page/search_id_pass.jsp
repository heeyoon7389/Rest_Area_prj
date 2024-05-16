<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.SearchIdPassDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="아이디/비번찾기"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<style type="text/css">
    th { vertical-align: middle; }
        
    .writeForm_btn{ padding-bottom: 10px; }
        
    .writeForm_btn .btn{ width: 150px; } 	
    
    #searachId{margin-top: 68px;}
    
    footer{margin-top: 180px;}
    
    #result{
    	margin-top: 50px;
    	font-size: 25px;
    	text-align: center;
    }
</style>

<script type="text/javascript">

	$(function(){
		$("#searachId").click(function(){
			var name1 = document.frm.name1.value;
			var idEmail1 = document.frm.idEmail1.value;
			var idEmail2 = document.frm.idEmail2.value;
			var email = idEmail1+"@"+idEmail2;
  			var emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
  			
  			//유효성검사
  			if( $("#name1").val() == "" ){
  				alert("이름을 입력해주세요.");
  				$("#name1").focus();
  			}else if($("#idEmail1").val() == "" || $("#idEmail2").val() == ""){
  				alert("이메일을 입력해주세요.");
  				$("#idEmail1").val('');
  				$("#idEmail2").val('');
  				$("#idEmail1").focus();
  			}else if( !emailPattern.test(email) ){
  				alert("이메일 형식이 맞지 않습니다.");
  				$("#idEmail1").val('');
  				$("#idEmail2").val('');
  				$("#idEmail1").focus();
  			}else{
  				var searachId = "name1=" + name1 + "&email=" + email;
        		$.ajax({
        			url : "../login_page/search_id_process.jsp",
        			type : "POST",
        			data : searachId,
        			dataType : "JSON",
        			error : function(xhr){
        				alert("죄송합니다. 잠시후 다시 시도해주세요.");
        				console.log(xhr.status);
        			},
        			success : function(jsonObj){
        				var resultMsg = document.getElementById('result');
        				resultMsg.innerHTML = "아이디 찾기에 실패했습니다. 잠시후 다시 시도해주세요.";
        				if(jsonObj.flag){
	        				resultMsg.innerHTML = "[ "+ jsonObj.name + " ] 님의 아이디는 <strong style='color:#0055FF'>" 
	        				+ jsonObj.id + "</strong> 입니다.";
        				}//end if
        			}//success
        		});//ajax
  			}//end else
		});//searachId
		
		$("#searchPass").click(function(){
			var id = document.frm.id.value;
			var name2 = document.frm.name2.value;
			var passEmail1 = document.frm.passEmail1.value;
			var passEmail2 = document.frm.passEmail2.value;
			var email2 = passEmail1+"@"+passEmail2;
  			var emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
  			
  			//유효성검사
  			if( $("#id").val() == "" ){
  				alert("아이디를 입력해주세요.");
  				$("#id").focus();
  			}else if( $("#name2").val() == "" ){
  				alert("이름을 입력해주세요.");
  				$("#name2").focus();
  			}else if($("#passEmail1").val() == "" || $("#passEmail2").val() == ""){
  				alert("이메일을 입력해주세요.");
  				$("#passEmail1").val('');
  				$("#passEmail2").val('');
  				$("#passEmail1").focus();
  			}else if( !emailPattern.test(email2) ){
  				alert("이메일 형식이 맞지 않습니다.");
  				$("#passEmail1").val('');
  				$("#passEmail2").val('');
  				$("#passEmail1").focus();
  			}else{
  				var searachPass = "id=" + id + "&name2=" + name2 + "&email2=" + email2;
        		$.ajax({
        			url : "../login_page/search_id_process.jsp",
        			type : "POST",
        			data : searachPass,
        			dataType : "JSON",
        			error : function(xhr){
        				alert("죄송합니다. 잠시후 다시 시도해주세요.");
        				console.log(xhr.status);
        			},
        			success : function(jsonObj){
        				var resultMsg = document.getElementById('result');
        				resultMsg.innerHTML = "아이디 찾기에 실패했습니다. 잠시후 다시 시도해주세요.";
        				if(jsonObj.flag2){
	        				resultMsg.innerHTML = "[ "+ jsonObj.name2 + " ] 님의 임시비밀번호는 <strong style='color:#0055FF'>" 
	        				+ jsonObj.tempPass + "</strong> 입니다.";
        				}//end if
        			}//success
        		});//ajax
  			}//end else
		});//searchPass
	});//ready
</script>
<div class="container">
<!-- 	검색 결과 보여주기 -->
	<div id="result"></div> 
<!-- 	검색 결과 보여주기 -->
    <!-- 아이디/비밀번호 찾기 시작 -->
    <form action="../login_page/search_id_process.jsp" method="post" name="frm" id="frm">
    <div class="row">
        <!-- 아이디 찾기 시작 -->
        <div class="col-md-6">
        <!-- 회원 정보입력 시작 -->
        <div class="writeForm">
            <table class="table">
                <colgroup>
                    <col class="writeForm_col01" />
                    <col width="*" />
                </colgroup>
                <strong style="font-size: 25px; font-weight: bold;"> 아이디 찾기</strong>
                <tr>
                    <th><label for="name1">이름</label></th>
                    <td>
                        <input data-value="이름을 입력해주세요." id="name1" name="name1" class="inputTxt inputName" type="text"  />
                    </td>
                </tr>
                <tr>
                    <th><label for="idEmail1">이메일</label></th>
                    <td class="mail_type">
                        <input data-value="이메일을 입력해주세요." name="idEmail1" id="idEmail1" class="inputEmail" type="text" maxlength="100" style="width:200px;"/>
                        <span class="email_txt">@</span>
                        <input type="text" list="selecEmail1" name="idEmail2" id="idEmail2">
                        <datalist class="selecEmail" name="selecEmail1" id="selecEmail1" data-value="이메일을 선택해주세요.">
                            <option value="">선택해주세요.</option>
                            <option value='직접 입력'>직접 입력</option>
                            <option value='naver.com'>naver.com</option>
                            <option value='daum.net'>daum.net</option>
                            <option value='gmail.com'>gmail.com</option>
                            <option value='hotmail.com'>hotmail.com</option>
                            <option value='nate.com'>nate.com</option>
                            <option value='korea.com'>korea.com</option>
                        </datalist>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 회원 정보입력 끝 -->
        <!-- 확인 버튼 시작 -->
        <div class="writeForm_btn">
            <input type="button" value="확인" class="btn btn-secondary btn-lg" id="searachId"/>
        </div>
        <!-- 확인 버튼 끝 -->
        </div>
        <!-- 아이디 찾기 끝 -->
        <!-- 비밀번호 찾기 시작 -->
        <div class="col-md-6">
        <!-- 회원 정보입력 시작 -->
        <div class="writeForm">
            <table class="table">
                <colgroup>
                    <col class="writeForm_col01" />
                    <col width="*" />
                </colgroup>
                <strong style="font-size: 25px; font-weight: bold;">비밀번호 찾기</strong>
                <tr>
                    <th><label for="id">아이디</label></th>
                    <td>
                        <input data-value="아이디를 입력해주세요." name="id" id="id" class="inputTxt inputIdtype" type="text" maxlength="20"  />
                    </td>
                </tr>
                <tr>
                    <th><label for="name2">이름</label></th>
                    <td>
                        <input data-value="이름을 입력해주세요." id="name2" name="name2" class="inputTxt inputName" type="text"  />
                    </td>
                </tr>
                <tr>
                    <th><label for="passEmail1">이메일</label></th>
                    <td class="mail_type">
                        <input data-value="이메일을 입력해주세요." name="passEmail1" id="passEmail1" class="inputEmail" type="text" maxlength="100" style="width:200px;" />
                        <span class="email_txt">@</span>
                        <input type="text" list="selecEmail2" name="passEmail2" id="passEmail2">
                        <datalist class="selecEmail" name="selecEmail2" id="selecEmail2" data-value="이메일을 선택해주세요.">
                            <option value="">선택해주세요.</option>
                            <option value='직접 입력'>직접 입력</option>
                            <option value='naver.com'>naver.com</option>
                            <option value='daum.net'>daum.net</option>
                            <option value='gmail.com'>gmail.com</option>
                            <option value='hotmail.com'>hotmail.com</option>
                            <option value='nate.com'>nate.com</option>
                            <option value='korea.com'>korea.com</option>
                        </datalist>
                    </td>
                </tr>
            </table>
        </div>
        <!-- 회원 정보입력 끝 -->
        <!-- 확인 버튼 시작 -->
        <div class="writeForm_btn">
            <input type="button" value="확인" class="btn btn-secondary btn-lg" id="searchPass"/>
        </div>
        <!-- 확인 버튼 끝 -->
        </div>
        <!-- 비밀번호 찾기 끝 -->
    </div>
    </form>
    <!-- 아이디/비밀번호 찾기 끝 -->
</div>
