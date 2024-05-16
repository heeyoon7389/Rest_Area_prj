<%@page import="org.json.simple.JSONObject"%>
<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.SQLException"%>
<%@page import="prj2DAO.SearchIdPassDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
request.setCharacterEncoding("UTF-8");
//아이디 찾기
String name1 = request.getParameter("name1");
String email = request.getParameter("email");
//비밀번호 찾기
String id = request.getParameter("id");
String name2 = request.getParameter("name2");
String email2 = request.getParameter("email2");

JSONObject jsonObj = new JSONObject();

if (id == null || "".equals(id)) {
    //아이디 찾기
	jsonObj.put("flag", false);
    SearchIdPassDAO sipDAO = SearchIdPassDAO.getInstance();
    try {
        //암호화
        String key = "yIzLRfreATg/6wxHGia/4w==";
        DataEncrypt de = new DataEncrypt(key);

        //아이디찾기 암호화(이름, 이메일)
        String deName = de.encryption(name1);
        String deEmail = de.encryption(email);

        //아이디 있는지 확인
        String userId = sipDAO.selectId(deName, deEmail);

        if (userId != null && !"".equals(userId)) {
            //아이디 찾기 성공
            jsonObj.put("flag", true);
            jsonObj.put("name", name1);
            jsonObj.put("id", userId);
        }//end if
    } catch (SQLException e) {
        e.printStackTrace();
    }//end catch
} else {
    //비밀번호 찾기
    jsonObj.put("flag2", false);
    SearchIdPassDAO sipDAO = SearchIdPassDAO.getInstance();
    try {
        //암호화
        String key = "yIzLRfreATg/6wxHGia/4w==";
        DataEncrypt de = new DataEncrypt(key);

        //비밀번호 찾기 암호화(이름, 이메일)
        String deName2 = de.encryption(name2);
        String deEmail2 = de.encryption(email2);

        //비밀번호 있는지 확인
        Boolean check =  sipDAO.selectUserPass(id, deName2, deEmail2);
        if (check == true) {
            //비밀번호 있을 경우
                
            //임시비밀번호 발급
            String tempPass = "";
            String characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            Random random = new Random();
            for (int i = 0; i < 5; i++) {
                int index = random.nextInt(characters.length());
                tempPass += characters.charAt(index);
            }//end for

            //임시비밀번호 일방향 Hash 암호화
            String deTempPass = DataEncrypt.messageDigest("MD5", tempPass);
        
            //임시 비밀번호 update
            sipDAO.updateTempPass(deTempPass, id, deName2, deEmail2);
                
            jsonObj.put("flag2", true);
            jsonObj.put("name2", name2);
            jsonObj.put("tempPass", tempPass);
        }//end if
    } catch (SQLException e) {
        e.printStackTrace();
    }//end catch
}//end else

%>
<%= jsonObj.toJSONString() %>
