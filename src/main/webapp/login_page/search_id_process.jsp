<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.SearchIdPassDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
<%
request.setCharacterEncoding("UTF-8");

//아이디 찾기
String name1 = request.getParameter("name1");
String idEmail1 = request.getParameter("idEmail1");
String idEmail2 = request.getParameter("idEmail2");
String idEmail = idEmail1+"@"+idEmail2;//이메일 합치기

//비밀번호 찾기
String paramId = request.getParameter("id");
String name2 = request.getParameter("name2");
String passEmail1 = request.getParameter("passEmail1");
String passEmail2 = request.getParameter("passEmail2");
String passEmail = passEmail1+"@"+passEmail2;//이메일 합치기

if( name1 != null && !"".equals(name1) ){
	//아이디 찾기
	SearchIdPassDAO sipDAO = SearchIdPassDAO.getInstance();
	try{
		//암호화
		String key="yIzLRfreATg/6wxHGia/4w==";
		DataEncrypt de = new DataEncrypt(key);

		//아이디찾기 암호화(이름, 이메일)
		name1 = de.encryption(name1);
		idEmail = de.encryption(idEmail);
		//아이디 있는지 확인
		String userId = sipDAO.selectId(name1, idEmail);
		
		if( userId != null && userId != "" ){
			//아이디 찾기 성공
			//복호화(이름)
			key = "yIzLRfreATg/6wxHGia/4w==";
			DataDecrypt dd = new DataDecrypt(key);
			name1 = dd.decryption(name1);
			
			//세션에 값 설정
			session.setAttribute("search_userId", userId);
			session.setAttribute("search_username", name1);
			//임시비밀번호 삭제
			session.removeAttribute("search_pass_tempPass");
		}else{
			//아이디를 찾을 수 없을 때.
			session.removeAttribute("search_userId");
			%>alert("아이디 찾기에 실패했습니다. 잠시후 다시 시도해주세요.");<%
		}//else
		%>location.href="../main_page/main_page.jsp?link=searchIdPass";<%
	}catch(SQLException e){
		e.printStackTrace();
	}//end catch
} else if( paramId != null && !"".equals(paramId) ){
	//비밀번호 찾기
	SearchIdPassDAO sipDAO = SearchIdPassDAO.getInstance();
	try{
		//암호화
		String key="yIzLRfreATg/6wxHGia/4w==";
		DataEncrypt de = new DataEncrypt(key);
		
		//비밀번호 찾기 암호화(이름, 이메일)
		name2 = de.encryption(name2);
		passEmail = de.encryption(passEmail);
		
		//비밀번호 있는지 확인
		Boolean check =  sipDAO.selectUserPass(paramId, name2, passEmail);
		if( check == true ){
			//비밀번호 있을 경우
			
			//임시비밀번호 발급
			String tempPass = "";
    		String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    		Random random = new Random();
    		for (int i = 0; i < 5; i++) {
       			int index = random.nextInt(characters.length());
        		tempPass += characters.charAt(index);
    		}//end for
    		
    		//임시비밀번호 암호화
    		tempPass = de.encryption(tempPass);
    
			//임시 비밀번호 update
			sipDAO.updateTempPass(tempPass, paramId, name2, passEmail);
    				
    		//복호화(비밀번호, 이름)
    		key = "yIzLRfreATg/6wxHGia/4w==";
			DataDecrypt dd = new DataDecrypt(key);
    		tempPass = dd.decryption(tempPass);
    		name2 = dd.decryption(name2);
    		
    		//세션에 값 설정
			session.setAttribute("search_pass_tempPass", tempPass);
			session.setAttribute("search_pass_name", name2);
			session.removeAttribute("search_userId");
		}else{
			//비밀번호를 찾을 수 없을 때
			session.removeAttribute("search_pass_tempPass");
			%>alert("비밀번호 찾기에 실패했습니다. 잠시후 다시 시도해주세요.");<%
		}//end else
		%>location.href="../main_page/main_page.jsp?link=searchIdPass";<%
	}catch(SQLException e){
		e.printStackTrace();
	}//end catch
}//end if
%>
</script>
