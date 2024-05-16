package prj2DAO;

public class BoardUtil {

	private static BoardUtil bu;
	
	private BoardUtil() {
		
	}//BoardUtil
	
	public static BoardUtil getInstance() {
		if(bu == null) {
			bu = new BoardUtil();
		}//end if
		return bu;
	}//getInstance
	
	public String pageNation(String url, String param, int totalPage, int currentPage) {
		
		StringBuilder pageNation = new StringBuilder();
		//1. 한 화면에서 보여줄 페이지 인덱스 수
	 	int pageNumber=3;
		//2. 화면에 보여줄 시작페이지 번호 
		int startPage = ((currentPage - 1) / pageNumber) * pageNumber + 1;
		//3. 화면에 보여줄 마지막페이지 번호
		int endPage = ((( startPage - 1) + pageNumber) / pageNumber) * pageNumber;
		//4. 총 페이지 수가 연산된 마지막 페이지 수 보다 작다면 총 페이지 수가 마지막 페이지수로 설정.
		if(totalPage <= endPage){
			endPage = totalPage;
		}//end if
		
		//5. 첫페이지가 인덱스화면이 아닌 경우
		String prevMark="[<<]";
		int movePage = 0;//이동할 페이지번호
		if(currentPage > pageNumber){//시작페이지보다 1적은 페이지로 이동
			movePage=startPage-1;
			prevMark="[ <a style='text-decoration:none; ' href='" + url + "&currentPage="+ movePage + param +"'> &lt;&lt; </a> ]";
		}//end if
		
		pageNation.append(prevMark).append("...");
		
		//6. 시작페이지 번호부터 끝 페이지 번호까지 화면에 출력
		movePage = startPage;
		while(movePage <= endPage){
			if(movePage == currentPage){//현재 페이지의 링크는 활성화 할 필요가 없다.
				pageNation.append( "[ <span style='font-size:20px'>" )
				.append(currentPage)
				.append("</span> ]");
			}else{
				pageNation.append("[ <a style='text-decoration:none; ' href='").append(url).append("&currentPage=")
				.append(movePage).append(param).append("'> ").append(movePage).append("</a> ]");
			}//end else
			movePage++;
		}//end while
			
		//7. 뒤에 페이지가 더 있는 경우
		String endMark="[>>]";
// 		String nextMark="[&gt;&gt;]"; 이렇게도 쓸 수 있음. 결과 같음.
		if(totalPage > endPage){
			movePage=endPage+1;
			endMark="[ <a style='text-decoration:none; ' href='" + url + "8currentPage=" + movePage + param + "'> &gt;&gt; </a> ]";
		}//end if
		
		pageNation.append("...").append(endMark);
		
		return pageNation.toString();
	}//pageNation
}//class
