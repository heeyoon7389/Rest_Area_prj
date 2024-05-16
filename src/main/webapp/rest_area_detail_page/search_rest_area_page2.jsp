<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴게소 검색</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function() {
    // 검색 버튼 클릭 이벤트
    $('button[type="submit"]').click(function(e) {
        e.preventDefault();
        var searchType = $('select[name="search-type"]').val();
        var searchValue = $('input[name="search-query"]').val();
        
        // AJAX 요청
        $.ajax({
            url: 'search_handler.jsp',
            type: 'GET',
            data: {
                'search-type': searchType,
                'search-query': searchValue
            },
            success: function(data) {
                $('.main').html(data);
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
            }
        });
    });

    // 고속도로 버튼 클릭 이벤트
/*      $(document).on('click', '.route_content', function() {
        var routeId = $(this).data('value');
 */
        // AJAX 요청
/*         $.ajax({
            url: 'highway_handler.jsp',
            type: 'GET',
            data: {
                'routeId': routeId
            },
            success: function(data) {
                $('.main').html(data);
            },
            error: function(xhr, status, error) {
                console.error('AJAX 요청 실패:', status, error);
                alert('휴게소 정보를 불러오는 데 실패했습니다. 다시 시도해 주세요.');
            }
        }); */
   /*  }); */   
});
</script>
</head>
<body>
<div class="container">
    <div class="search-container">
        <form class="d-flex" role="search">
            <select class="form-select" aria-label="고속도로 검색 유형" name="search-type">
                <option value="1">지역별</option>
                <option value="2">휴게소별</option>
                <option value="3">고속도로별</option>
            </select>
            <input class="form-control me-2" type="search" name="search-query" placeholder="찾으시는 휴게소를 검색해주세요" aria-label="Search">
            <button class="btn btn-primary" type="submit">검색</button>
        </form>
    </div>
    <div class="main">
        <!-- AJAX로 검색 결과를 로드할 영역 -->
    </div>
</div>
</body>
</html>
