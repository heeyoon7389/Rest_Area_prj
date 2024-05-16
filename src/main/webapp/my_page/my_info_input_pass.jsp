<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style type="text/css">
	form{
		padding-top: 90px;
		padding-bottom: 250px;
		width: 60%;
		margin: 0 auto;
	}
	tr{
	border: 1px solid #333;
	}
</style>

<script type="text/javascript">
	$(function(){
		//비밀번호 유효성 검사
        $('#btnsubmit').click(function(){
    		var pass=document.frm.password.value;
    		var reg = /^[A-z0-9]{5,12}$/;
        	if( pass == "" ) {
    			alert('비밀번호를 입력해주세요.');
    			$("#password").focus();
    		}else if( !reg.test(pass) ){
    			alert("비밀번호를 영문, 숫자 5~12자 이내로 입력해주세요.");
    			$("#password").val('');
    			$("#password").focus();
    		}else{
    			var pass = "password="+pass;
        		$.ajax({
        			url : "../my_page/my_info_chkPass.jsp",
        			type : "POST",
        			data : pass,
        			dataType : "JSON",
        			error : function(xhr){
        				alert("죄송합니다. 잠시후 다시 시도해주세요.");
        				console.log(xhr.status);
        			},
        			success : function(jsonObj){
        				let msg = "비밀번호 확인에 실패했습니다. 다시 시도해주세요."
        				if(jsonObj.flag){
        					msg = "비밀번호를 확인했습니다.";
        					location.href="../main_page/main_page.jsp?link=myPage&my=myInfo";
        					
        				}
        				alert(msg);
        				$("#password").val('');
            			$("#password").focus();
        			}
        		});
    		}//end else
        });//click
    });//ready
</script>


<div>
<form action="../my_page/my_info_chkPass.jsp" method="post" name="frm" id="frm">
<table class="table" id="inputPass">
	<tr>
       <th><label for="password">비밀번호</label></th>
       <td>
       <input data-value="비밀번호를 입력해주세요." name="password" id="password" class="inputPass size02" type="password" maxlength="12"/>
       <span>*비밀번호를 영어, 숫자 5~12자 이내로 입력해주세요.</span>
       </td>
     </tr>	
</table>
<div class="writeForm_btn">
    <input type="button" value="확인"class="btn btn-secondary btn-lg" id="btnsubmit"/>
	<div class="space2"></div>
	<input type="reset" value="취소"class="btn btn-secondary btn-lg" id="cancel"/>
</div>
</form>
</div>
