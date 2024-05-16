<%@page import="restAreaFacil.RestAreaFacilDAO"%>
<%@page import="restAreaFacil.RestAreaFacilVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info=""%>
<%@ taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--  /////////////////////편의시설 정보 출력/////////////////////////// -->
<div class="facil">
					<div id="facil_info" style="overflow: auto;">
						<div id="facil_">
							<h1>편의시설</h1>
						</div>
						<br />
						<table>
							<tbody>
								<tr>
									<th>시설</th>
									<th>이미지</th>
									<th>설명</th>
								</tr>
								<%
								String raNum = request.getParameter("raNum");
								List<RestAreaFacilVO> facilList = null;
								RestAreaFacilDAO rfDAO = RestAreaFacilDAO.getInstance();
								facilList = rfDAO.selectFacil(raNum);
								RestAreaFacilVO rafVO = null; // rafVO 정의 추가
								%>
								<%
								for (int i = 0; i < facilList.size(); i++) {
								%>
								<%
								rafVO = facilList.get(i);
								%>
								<tr style=" background-color: #FFFFFF;">
									<td><%=rafVO.getFacilName()%></td>
									<td><img src="images/<%=rafVO.getImg()%>"
										style="width: 100px; height: 100px;"></td>
									<td><%=rafVO.getFacilNote()%></td>
								</tr>
								<%
								}
								%>
							</tbody>
						</table>
					</div>
				</div>
<!--///////////////////////////////// 편의 시설 정보 출력 끝 //////////////////////////////////-->