<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="마이페이지"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(function(){
		
	});//ready
</script>

<!-- 즐겨찾기 시작 -->
<div class="table-padding">
<strong>즐겨찾기</strong>
<table class="table table-hover table-bordered">
  <thead>
    <tr>
      <th scope="col">휴게소</th>
      <th scope="col">위치</th>
    </tr>
  </thead>
  <tbody class="table-group-divider">
    <tr>
      <th><input type="checkbox" name="favorites" value="raNum"/> 강남휴게소</th>
      <td colspan="2">강남에 있겠지</td>
    </tr>
    <tr>
      <th><input type="checkbox" name="favorites" value="raNum"/> 강릉휴게소</th>
      <td colspan="2">강릉에 있겠지</td>
    </tr>
    <tr>
      <th><input type="checkbox" name="favorites" value="raNum"/> 수연휴게소</th>
      <td colspan="2">우리집이겠지</td>
    </tr>
  </tbody>
</table>
<div class="right">
<input type="button" class="btn btn-danger" value="삭제" id="delFavorite"/>
</div>
</div>
<!-- 즐겨찾기 끝 -->
