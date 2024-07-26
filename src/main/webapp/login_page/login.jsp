<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="로그인 팝업창"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link rel="icon" href="http://192.168.10.218/Rest_Area_prj/common/tamcatIcon.ico"/>
<!--bootstrap 시작-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
<!--bootstrap 끝-->

<link rel="stylesheet" href="http://192.168.10.218/jsp_prj/common/css/main.css" type="text/css" media="all" />
<link rel="stylesheet" href="http://192.168.10.218/jsp_prj/common/css/board.css" type="text/css" media="all" />

<!--jQuery CDN 시작-->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!--jQuery CDN 끝-->

<style type="text/css">
 /* 폰트 패밀리와 기본 폰트 설정 */
body {
  font-family: "Roboto", sans-serif;
  font-size: 14px;
  line-height: 1.6em;
  color: rgba(0, 0, 0, 0.6);
}

/* 폼 설정 */
.form {
  background: #FFFFFF;
  width: 600px;
  height: 515px;
  border-radius: 4px; /* 둥근 모서리 */
  box-shadow: 0 0 30px rgba(0, 0, 0, 0.1); /* 그림자 */
  overflow: hidden;
}

.form-toggle {
  background: #FFFFFF;
  width: 60px;
  height: 60px;
  border-radius: 100%;
  transform-origin: center;
  transform: translate(0, -25%) scale(0);
  opacity: 0;
  cursor: pointer;
}

.form-group {
  margin: 0 0 20px;
}

.form-group label {
  color: rgba(0, 0, 0, 0.6);
  font-size: 12px;
  font-weight: 500;
  line-height: 1;
  text-transform: uppercase; /* 대문자 변환 */
}

.form-group input {
  background: rgba(0, 0, 0, 0.1); 
  width: 100%;
  border: 0;
  border-radius: 4px; /* 둥근 모서리 */
  padding: 12px 20px;
  color: rgba(0, 0, 0, 0.6); /* 약간 투명한 검은색 */
  transition: 0.3s ease; /* 부드러운 전환 효과 */
}

.form-group button {
  background: #4285F4; /* 파란색 배경 */
  color: #FFFFFF; /* 흰색 글자 */
  width: 100%;
  border: 0;
  border-radius: 4px; /* 둥근 모서리 */
  padding: 12px 20px;
  text-transform: uppercase; /* 대문자 변환 */
  cursor: pointer;
}

.form-group label.form-remember {
  font-size: 12px;
  font-weight: 500;
  letter-spacing: 0;
  text-transform: none;
}

.form-group label.form-recovery {
  color: #4285F4; /* 파란색 */
  font-size: 12px;
  text-decoration: none;
}

/* 패널 */
.form-panel {
  padding: 60px calc(5% + 60px) 60px 60px;
}

.form-panel.one:before {
  content: '';
  display: block;
  opacity: 0;
  visibility: hidden;
  transition: 0.3s ease;
}

.form-panel.two {
  z-index: 5;
  position: absolute;
  top: 0;
  left: 95%;
  background: #4285F4; /* 파란색 배경 */
  width: 100%;
  min-height: 100%;
  padding: 60px calc(10% + 60px) 60px 60px;
  transition: 0.3s ease;
  cursor: pointer;
}

/* 헤더 */
.form-header h1 {
  padding: 4px 0px;
  color: #4285F4; /* 파란색 */
  font-size: 24px;
  font-weight: 700;
  text-transform: uppercase; /* 대문자 변환 */
}

/* '아이디/비밀번호 찾기'와 '회원가입' 사이에 공백 추가 */
.form-group .form-recovery:nth-child(2) {
  margin-left: 242px; /* 왼쪽 마진을 50px로 지정합니다. */
}

/* 회원가입 링크 설정 */
#join{cursor: pointer;}

/* 로그인 버튼 설정 */
#login:hover{
color: #F4F4F4;
background-color:#4285F4;
}

/* 아이디/비밀번호 마우스 커서 */
#serachIdPass{cursor: pointer;}
</style>

<script type="text/javascript">
	$(function(){
		$("#login").click(function(){
			let id=$("#id").val();
			let pass=$("#password").val();
            if( (id.trim()=="") || (pass.trim()=="") ){
                alert("아이디와 비밀번호를 입력해주세요.");
                $("#id").val("");
                $("#password").val("");
                $("#id").focus();
            }else{
            	$("#loginFrm").submit();
            }//end else
            
		});
// 		회원가입 클릭 시
		$("#join").click(function(){
			window.opener.location.href="../main_page/main_page.jsp?link=join";//부모창 다른 주소로 이동.
			window.close();//로그인 창 닫기
		});
// 		아이디/비밀번호 찾기 클릭 시
		$("#serachIdPass").click(function(){
			window.opener.location.href="../main_page/main_page.jsp?link=searchIdPass";//부모창 다른 주소로 이동.
			window.close();//로그인 창 닫기
		});
	});//ready
</script>

</head>
<body>
<div class="form">
  <div class="form-toggle"></div>
  <div class="form-panel one">
    <div class="form-header">
      <h1>로그인</h1>
    </div>
    <div class="form-content">
      <form action="../login_page/login_process.jsp" method="post" id="loginFrm">
        <div class="form-group">
          <label for="id">아이디</label>
          <input type="text" id="id" name="id" required>
        </div>
        <div class="form-group">
          <label for="password">비밀번호</label>
          <input type="password" id="password" name="password" required>
        </div>
        <div class="form-group">
          <a class="form-recovery" id="serachIdPass">아이디 / 비밀번호 찾기</a>
          <a class="form-recovery" id="join">회원가입</a>
        </div>
        <div class="form-group">
          <input type="button" id="login" value="로그인"/>
        </div>
      </form>
    </div>
  </div>
</div>
</body>
</html>