<%@page import="restAreaReview.RestAreaReviewDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 등록</title>
</head>
<body>
<%
    request.setCharacterEncoding("utf-8");
    String raNum = request.getParameter("raNum");
    String memberId = request.getParameter("memberId");
    String content = request.getParameter("content");
    String ratingStr = request.getParameter("ratingValue");

    int rating = 0;
    double realRating = 0;
    if (ratingStr != null && !ratingStr.isEmpty()) {
        rating = Integer.parseInt(ratingStr);
        realRating = (double)rating;
    }

    boolean success = false;
    RestAreaReviewDAO rarDao = RestAreaReviewDAO.getInstance();
    success = rarDao.insertReview(raNum, memberId, content, realRating);

    if (success = true) {
        out.println("<script>alert('리뷰 작성이 완료되었습니다.'); location.href='write_review_page.jsp';</script>");
    } else {
        out.println("<script>alert('리뷰 작성에 실패했습니다. 다시 시도해주세요.'); history.back();</script>");
    }
%>
</body>
</html>
