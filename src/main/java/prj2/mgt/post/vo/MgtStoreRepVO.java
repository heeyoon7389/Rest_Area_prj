package prj2.mgt.post.vo;

import java.sql.Date;

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
public class MgtStoreRepVO {
	private int storeRepNum;
	private String memId;
	private String title;
	private String content;
	private String storeName;
	private String raName;
	private Date inputDate;
	/**
	 * 0: 처리 전, 1: 처리중, 2: 처리 완료
	 */
	private int processFlag;
	private String processContents;
	private Date processDate;
}
