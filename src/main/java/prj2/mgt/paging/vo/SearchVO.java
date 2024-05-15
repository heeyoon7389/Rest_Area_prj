package prj2.mgt.paging.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class SearchVO {
	private String field;
	private String keyword;
	private String currentPage;
	private int startNum;
	private int endNum;
	/**
	 * 적용 페이지: 회원관리
	 */
	private int pageScale;
}
