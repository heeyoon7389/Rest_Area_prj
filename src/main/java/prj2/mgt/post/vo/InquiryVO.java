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
public class InquiryVO {
	private int inquiryNum;
	private String memId;
	private String title;
	private String contents;
	private Date inputDate;
	private boolean secretFlag;
	private boolean answerFlag;
	private String answerContents;
	private Date answerDate;
	private String managerId;
}
