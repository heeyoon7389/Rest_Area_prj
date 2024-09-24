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
public class RestAreaReviewRepVO {
	private int reviewNum;
	private String reviewMemId;
	private String reviewContent;
	private Date reviewInputDate;
	private String reportMemId;
	private String reportContent;
	private Date reportInputDate;
	private boolean blindFlag;
	private int processFlag;
	private String processContents;
	private Date processDate;
	private boolean deleteFlag;
}
