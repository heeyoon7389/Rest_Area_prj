$(function(){
    $.ajax({
        url: "../rest_area_detail_page/gs_station_service.jsp",
        dataType: "json",
        success: function(data) {
            // JSON 데이터 처리 및 DOM 업데이트
            var stations = data;
            if (stations) { // stations가 null이 아닌 경우에만 처리
                for (var i = 0; i < stations.length; i++) { // 배열의 길이는 length를 사용합니다.
                    var station = stations[i];
                    var tempSaName = station.serviceAreaName;
                    if (tempSaName == null) {
                        continue;
                    }
                    var serviceAreaName = tempSaName.replace("주유소", "휴게소");
					const urlParams = new URL(location.href).searchParams;
					const raName = urlParams.get('raName');
                    // raName이 이전에 정의되었다고 가정합니다.
                    if (serviceAreaName.replace(" ", "").includes(raName)) { // 문자열 대체는 replace()를 사용하고, 문자열 포함 여부는 includes()를 사용합니다.
                        var diselPrice = station.diselPrice;
                        var gasolinePrice = station.gasolinePrice;
                        var lpgPrice = station.lpgPrice;
                        var telNo = station.telNo;

                        // HTML 내용 구성
                        var htmlContent = '<strong>' + raName + '<br> 주유소 정보</strong>';
                        htmlContent += '<table>';
                        htmlContent += '<tr><td>휘발유: ' + gasolinePrice + '</td></tr>';
                        htmlContent += '<tr><td>경유: ' + diselPrice + '</td></tr>';
                        if (lpgPrice === "X") {
                            htmlContent += '<tr><td>LPG: 정보없음</td></tr>';
                        } else {
                            htmlContent += '<tr><td>LPG: ' + lpgPrice + '</td></tr>';
                        }
                        htmlContent += '<tr><td>전화번호: ' + telNo + '</td></tr>';
                        htmlContent += '</table>';

                        // DOM 업데이트
                        $("#gs_info").html(htmlContent);
                        break; // 일치하는 첫 번째 주유소 정보만 표시하려면
                    }
                }
            } else {
                console.error("주유소 정보가 없습니다.");
            }
        },
        error: function(xhr, status, error) {
            // 에러 처리
            console.error("JSON 데이터를 가져오는 중 오류 발생:", error);
        }
    });
});
