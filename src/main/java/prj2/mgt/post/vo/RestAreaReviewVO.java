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
public class RestAreaReviewVO {
	private int reviewNum;
	private String raNum;
	private String raName;
	private String contents;
	private boolean blindFlag;
	private String memId;
	private boolean deleteFlag;
	private Date inputDate;
	private Date deleteDate;
}
