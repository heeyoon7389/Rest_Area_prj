<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="prj2VO.LoginVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
$(function(){	
	
});//ready
</script>
	
<script type="text/javascript">		
$(function(){
		//사용자 정보 설정
		$("#id").val('<%= ((LoginVO)session.getAttribute("loginData")).getMemId() %>');
		$("#name").val('<%= ((LoginVO)session.getAttribute("loginData")).getName() %>');
		$("#nick").val('<%= ((LoginVO)session.getAttribute("loginData")).getNick() %>');
		
		var email = '<%= ((LoginVO)session.getAttribute("loginData")).getEmail() %>';
		var emails = email.split('@');
		$("#email1").val(emails[0]);
		$("#email2").val(emails[1]);
		
		//비밀번호 유효성 검사
        $('#password2').focusout(function(){
    		var pass=document.frm.password.value;
    		var pass2=document.frm.password2.value;
    		var reg = /^[A-z0-9]{5,12}$/;
        	if( pass != pass2 ) {
    			alert('비밀번호가 다릅니다');
    			$("#password").val('');
    			$("#password2").val('');
    			$("#password").focus();
    		}else if( !reg.test(pass) ){
    			alert("비밀번호를 영문, 숫자 5~12자 이내로 입력해주세요.");
    			$("#password").val('');
    			$("#password2").val('');
    			$("#password").focus();
    		}
        });//password2
    
        //닉네임 유효성 검사
        $("#nickChk").click(function(){
        	var nick=document.frm.nick.value;
        	var ko_reg = /^[ㄱ-ㅎ가-힣a-zA-Z0-9]{1,12}$/;//한글/영문/숫자 1~12자 이내인지 확인
        	if( nick == "" ){
        		alert("닉네임을 한글, 영문, 숫자 1~12자 이내로 입력해주세요.");
        		$("#nick").focus();
        		return;
        	} else {
    			window.open("../join_page/nick_dup.jsp?nick="+nick, "nickDup", "width=472, height=390, top="+
    			(window.screenY+100)+", left="+(window.screenX+100));
        	}
        });//nickChk
        
  		//입력 요소 유효성검사
  		$("#btnsubmit").click(function(){
  			var email1 = document.frm.email1.value;
  			var email2 = document.frm.email2.value;
  			var email = email1+"@"+email2;
  			var emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
  			
  			if($("#password").val() == "" || $("#password2").val() == ""){
  				$("#password").val('');
  				$("#password2").val('');
  				alert("비밀번호를 입력해주세요.");
  				$("#password").focus();
  			}else if($("#name").val() == ""){
  				alert("이름을 입력해주세요.");
  				$("#name").focus();
  			}else if($("#nick").val() == ""){
  				alert("닉네임을 입력해주세요.");
  				$("#nick").focus();
  			}else if($("#email1").val() == "" || $("#email2").val() == ""){
  				alert("이메일을 입력해주세요.");
  				$("#email1").val('');
  				$("#email2").val('');
  				$("#email1").focus();
  			}else if( !emailPattern.test(email) ){
  				alert("이메일 형식이 맞지 않습니다.");
  				$("#email1").val('');
  				$("#email2").val('');
  				$("#email1").focus();
  			}else{
  				document.frm.submit();
  			}//end else
  		});//btnsubmit
});//ready
</script>

<!-- 내 정보수정 시작 -->
<form id="chkFrm" name="chkFrm" action="../main_page/main_page.jsp?link=myPage&my=myInfo" method="POST">
  <input type="hidden" name="promptPass" id="promptPass">
</form>
<div>
<form action="../my_page/my_info_process.jsp" method="post" name="frm" id="frm">
<div class="writeForm">
<!-- 회원 정보입력 시작 -->
    <table class="table">
        <colgroup>
            <col class="writeForm_col01" />
            <col width="*" />
        </colgroup>
        <tr>
            <th><label for="id">아이디</label></th>
            <td>
                <input data-value="아이디를 입력해주세요." name="id" id="id" class="inputTxt inputIdtype" type="text" maxlength="20" readonly="readonly"/>
            </td>
        </tr>
        <tr>
            <th><label for="password">비밀번호</label></th>
            <td>
                <input data-value="비밀번호를 입력해주세요." name="password" id="password" class="inputPass size02" type="password" maxlength="12"/>
                <span class="password_ch"><label for="password2">비밀번호 확인</label></span>
                <input data-value="비밀번호를 입력해주세요." name="password2" id="password2" class="inputPass size02 mmarT10" type="password" maxlength="12"/>
                <span>*비밀번호를 영어, 숫자 5~12자 이내로 입력해주세요.</span>
            </td>
        </tr>
        <tr>
            <th><label for="name">이름</label></th>
            <td>
                <input data-value="이름을 입력해주세요." id="name" name="name" class="inputTxt inputName" type="text" maxlength="10" />
            </td>
        </tr>
        <tr>
            <th scope="row"><label for="nick">닉네임</label></th>
            <td>
                <input data-value="닉네임를 입력해주세요." name="nick" id="nick" class="inputTxt inputIdtype" type="text" maxlength="20"  />
                <div class="space"></div>
                <input type="button" value="닉네임 중복확인"class="btn btn-outline-dark" id="nickChk"/>
                <span>*닉네임을 한글, 영문, 숫자 1~12자 이내로 입력해주세요.</span>
            </td>
        </tr>
        <tr>
            <th><label for="email1">이메일</label></th>
            <td class="mail_type">
                <input data-value="이메일을 입력해주세요." name="email1" id="email1" class="inputEmail" type="text" maxlength="100"  />
                <span class="email_txt">@</span>
                <input type="text" list="selecEmail" name="email2" id="email2" >
                <datalist class="selecEmail" name="selecEmail" id="selecEmail" data-value="이메일을 선택해주세요.">
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

<!-- 확인&취소 버튼 시작 -->
<div class="writeForm_btn">
    <input type="button" value="확인"class="btn btn-secondary btn-lg" id="btnsubmit"/>
	<div class="space2"></div>
	<input type="reset" value="취소"class="btn btn-secondary btn-lg" id="cancel"/>
</div>
<!-- 확인&취소 버튼 끝 -->
</form>
<!-- 내 정보수정 끝 -->
</div>
