<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="회원가입 페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
    <style type="text/css">
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
    </style>

    <script type="text/javascript">
        $(function(){
        	//아이디 유효성검사
            $("#idChk").click(function(){
            	var id=document.frm.id.value;
            	var reg = /^[A-z0-9]{5,12}$/;//영문/숫자 5~12자 이내인지 확인
            	if( id == "" ){
            		alert("아이디를 영문, 숫자 5~12자 이내로 입력해주세요.");
            		return;
            	} else if( !reg.test(id) ){
            		alert("아이디를 영문, 숫자 5~12자 이내로 입력해주세요.");
            		$("#id").val('');
            		$("#id").focus();
            		return;
            	} else {
        			window.open("../join_page/id_dup.jsp?id="+id, "idDup", "width=472, height=350, top="+
        			(window.screenY+203)+", left="+(window.screenX+306));
            	}
            });
            
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
            });
        
            //닉네임 유효성 검사
            $("#nickChk").click(function(){
            	var nick=document.frm.nick.value;
            	var ko_reg = /^[ㄱ-ㅎ가-힣a-zA-Z0-9]{1,12}$/;//한글/영문/숫자 1~12자 이내인지 확인
            	if( nick == "" ){
            		alert("닉네임을 한글, 영문, 숫자 1~12자 이내로 입력해주세요.");
            		$("#nick").focus();
            		return;
            	} else {
        			window.open("../join_page/nick_dup.jsp?nick="+nick, "nickDup", "width=472, height=350, top="+
        			(window.screenY+203)+", left="+(window.screenX+306));
            	}
            });
            
      		//입력 요소 유효성검사
      		$("#btnsubmit").click(function(){
      			var email1 = document.frm.email1.value;
      			var email2 = document.frm.email2.value;
      			var email = email1+"@"+email2;
      			var emailPattern = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-za-z0-9\-]+/;
      			if(!$("#agree1").prop("checked")){
      		        alert("회원가입약관에 체크해 주세요");
      		        return;
      		    }else if(!$("#agree2").prop("checked")){
      		        alert("개인정보취급방침에 체크해 주세요");
      		        return;
      		    }else if($("#id").val() == ""){
      				alert("아이디를 입력해주세요.");
      				$("#id").focus();
      			}else if($("#password").val() == "" || $("#password2").val() == ""){
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
      				var obj = document.frm;
      				obj.submit();
      			}
      		});
      		
        });//ready
    </script>



<!-- 회원가입 시작 -->
    <form action="../join_page/mem_join_process.jsp" method="post" name="frm" id="frm">
        <!-- 이용약관 시작 -->
        <div class="agree">
            <div>
                <h5>제1장 총칙</h5>
                <p>제1조 목적</p>
                <p>이 약관은 고속휴게소에서 제공하는 서비스 이용조건 및 절차에 관한 사항과 기타 필요한 사항을 고속휴게소과(와) 이용자의 권리, 의미 및 책임사항 등을 규정함을 목적으로 합니다.</p>
            </div>
            <div>
                <h5>제2조 약관의 효력과 변경</h5>
                <p>(1) 이 약관은 이용자에게 공시함으로서 효력이 발생합니다.</p>
                <p>(2) 고속휴게소는 사정 변경의 경우와 영업상 중요사유가 있을 때 약관을 변경할 수 있으며, 변경된 약관은 전항과 같은 방법으로 효력이 발생합니다.</p>
            </div>
            <div>
                <h5>제3조 약관 외 준칙</h5>
                <p>이 약관에 명시되지 않은 사항이 관계법령에 규정되어 있을 경우에는 그 규정에 따릅니다.</p>
            </div>
            <div>
                <h5>제2장 회원 가입과 서비스 이용</h5>
                <p>제1조 회원의 정의</p>
                <p>회원이란 고속휴게소에서 회원으로 적합하다고 인정하는 일반 개인으로 본 약관에 동의하고 서비스의 회원가입 양식을 작성하고 'ID'와 '비밀번호'를 발급받은 사람을 말합니다.</p>
                <p>제2조 서비스 가입의 성립</p>
                <p>(1) 서비스 가입은 이용자의 이용신청에 대한 고속휴게소의 이용승낙과 이용자의 약관내용에 대한 동의로 성립됩니다.</p>
                <p>(2) 회원으로 가입하여 서비스를 이용하고자 하는 희망자는 고속휴게소에서 요청하는 개인 신상정보를 제공해야 합니다.</p>
                <p>(3) 이용자의 가입신청에 대하여 고속휴게소에서 승낙한 경우, 고속휴게소는 회원 ID와 기타 고속휴게소에서 필요하다고 인정하는 내용을 이용자에게 통지합니다.</p>
                <p>(4) 가입할 때 입력한 ID는 변경할 수 없으며, 한 사람에게 오직 한 개의 ID가 발급됩니다.</p>
            </div>
            <p>이 약관은 2024년 04월 22일 시행합니다.</p>
        </div>
        <div class="chkAgree">
            <p><input type="checkbox" id="agree1" checked="checked" required> 회원가입약관에 동의합니다.</p>
        </div>
        <div class="space"></div>
        <div class="agree">
            <h5>[개인정보 수집에 대한 동의]</h5>
            <p>고속휴게소는 귀하께 회원가입시 개인정보보호방침 또는 이용약관의 내용을 공지하며 회원가입버튼을 클릭하면 개인정보 수집에 대해 동의하신 것으로 봅니다.</p>

            <h5>[개인정보의 수집목적 및 이용목적]</h5>
            <p>고속휴게소는 다음과 같은 목적을 위하여 개인정보를 수집하고 있습니다.</p>
            <ul>
                <li>서비스 제공에 관한 계약 이행 및 서비스 제공에 따른 요금정산 목적</li>
                <li>회원 관리</li>
                <li>마케팅 및 광고에 활용</li>
                <li>고용보험 과정의 고용노동부 신고</li>
            </ul>

            <h5>[수집하는 개인정보 항목]</h5>
            <p>고속휴게소는 회원가입, 상담, 서비스 신청 등을 위해 아래와 같은 개인정보를 수집하고 있습니다.</p>
            <p>- 수집항목: 이름, 생년월일, 성별, 로그인 ID, 비밀번호, 자택 전화번호, 자택 주소, 휴대전화번호, 이메일</p>

            <h5>[개인정보의 보유기간 및 이용기간]</h5>
            <p>귀하의 개인정보는 다음과 같이 개인정보의 수집목적 또는 제공받은 목적이 달성되면 파기됩니다.</p>
            <p>- 회원 가입정보의 경우, 회원 가입을 탈퇴하거나 회원에서 제명된 때</p>
            <p>단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존합니다.</p>
            <p>보존 근거 : 고용보험 환급 적정성 심의</p>
            <p>보존 기간 : 3년</p>
        </div>
        <div class="chkAgree">
            <p><input type="checkbox" id="agree2" checked="checked" required> 개인정보취급방침에 동의합니다.</p>
        </div>

        <!-- 이용약관 끝 -->
        <!-- 회원 정보입력 시작 -->
        <div class="writeForm">
            <table class="table">
                <colgroup>
                    <col class="writeForm_col01" />
                    <col width="*" />
                </colgroup>
                <tr>
                    <th><label for="id">아이디</label></th>
                    <td>
                        <input data-value="아이디를 입력해주세요." name="id" id="id" class="inputTxt inputIdtype" type="text" maxlength="20"  />
                        <div class="space"></div>
                        <input type="button" value="ID 중복확인"class="btn btn-outline-dark" id="idChk"/>
                        <span>*아이디를 영문, 숫자 5~12자 이내로 입력해주세요.</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="password">비밀번호</label></th>
                    <td>
                        <input data-value="비밀번호를 입력해주세요." name="password" id="password" class="inputPass size02" type="password" maxlength="12" />
                        <span class="password_ch"><label for="password2">비밀번호 확인</label></span>
                        <input data-value="비밀번호를 입력해주세요." name="password2" id="password2" class="inputPass size02 mmarT10" type="password" maxlength="12" />
                        <span>*비밀번호를 영어, 숫자 5~12자 이내로 입력해주세요.</span>
                    </td>
                </tr>
                <tr>
                    <th><label for="name">이름</label></th>
                    <td>
                        <input data-value="이름을 입력해주세요." id="name" name="name" class="inputTxt inputName" type="text" maxlength="10"  />
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
                        <input type="text" list="selecEmail" name="email2" id="email2">
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
<!-- 회원가입 끝 -->

