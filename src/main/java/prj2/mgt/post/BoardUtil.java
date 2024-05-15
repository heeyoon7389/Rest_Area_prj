package prj2.mgt.post;

public class BoardUtil {
	private static BoardUtil bu;
	
	private BoardUtil() {
	} // BoardUtil
	
	public static BoardUtil getInstance() {
		if(bu == null) {
			bu = new BoardUtil();
		} // end if
		return bu;
	} // getInstance
	
	public String pageNation(String url, String param, int totalPage, int currentPage) {
		
		StringBuilder pageNation = new StringBuilder();
		
		// 한 화면에서 보여줄 페이지 인덱스 수
		int pageNumber = 3;
		
		// 화면에 보여줄 시작 페이지 번호
		int startPage = ((currentPage - 1) / pageNumber) * pageNumber + 1;
		
		// 화면에 보여줄 마지막 페이지 번호
		int endPage = ((startPage - 1) + pageNumber) / pageNumber * pageNumber;
		//int endPage = startPage - 1 + pageNumber;
		
		// 총 페이지의 수가 연산된 마지막 페이지 수보다 작다면 총 페이지 수가 마지막 페이지 번호로 설정된다
		if(totalPage <= endPage) {
			endPage = totalPage;
		} // end if
		
		// 처음 페이지로
		switch(totalPage) {
		case 0:
			break;
		default:
			pageNation.append("<a href='")
			.append("?currentPage=")
			.append(1)
			.append(param)
			.append("'><input type='button' class='btn btn-sm btn-light marginL'  style='margin:0px auto;' value='처음 페이지'/></a>&nbsp;&nbsp;&nbsp;");			
		} // end switch
		
		// 첫 페이지가 인덱스 화면이 아닌 경우
		//String prevMark = "[ << ]";	// 링크는 비활성화되지만, 마크를 항상 보여주는 경우
		String prevMark = ""; // 링크가 비활성화되면 마크를 보여주지 않는 경우
		int movePage = 0;
		if(currentPage > pageNumber) {	// 시작 페이지보다 1 적은 페이지로 이동 
			movePage = startPage - 1;
			prevMark = "<a href='" + url + "?currentPage=" + movePage + param + "'><input type='button' class='btn btn-sm btn-light marginL' value='&lt;&lt;'/></a>&nbsp;&nbsp;&nbsp;";
		} // end if
		
		pageNation.append(prevMark);
		
		// 시작 페이지 번호부터 끝 페이지 번호까지 화면에 출력
		movePage = startPage;
		while(movePage <= endPage) {
			if(movePage == currentPage) {	// 현재 페이지에 대해서는 링크를 생성하지 않는다
				pageNation.append("<input type='button' class='btn btn-sm btn-secondary marginL' value='")
				.append(currentPage)
				.append("'/>&nbsp");
			} else {
				pageNation.append("<a href='")
				.append("?currentPage=")
				.append(movePage)
				.append(param)
				.append("'>")
				.append("<input type='button' class='btn btn-sm btn-light marginL' value='")
				.append(movePage)
				.append("'/>")
				.append("</a>&nbsp");
			} // end else
			movePage++;
		} // end while
		
		// 뒤에 페이지가 더 있는 경우
		String endMark = "";
		if(totalPage > endPage) {
			movePage = endPage + 1;
			endMark = "&nbsp;&nbsp;&nbsp;<a href='" + url + "?currentPage=" + movePage + param + "'><input type='button' class='btn btn-sm btn-light marginL' value='&gt;&gt;'/></a>";
		} // end if
		
		pageNation.append(endMark);
		//pageNation.append(" ... ").append(endMark);
		
		// 마지막 페이지로
		switch(totalPage) {
		case 0:
			break;
		default:
			pageNation.append("&nbsp;&nbsp;&nbsp;<a href='")
			.append("?currentPage=")
			.append(totalPage)
			.append(param)
			.append("'><input type='button' class='btn btn-sm btn-light marginL'  style='margin:0px auto;' value='마지막 페이지'/></a>");
		} // end switch
		
		return pageNation.toString();
	} // pageNation
	
} // class
