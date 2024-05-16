package prj2.mgt.dashboard.vo;

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
public class DashReviewReportVO {
	private String title;
	private Date inputDate;
	private boolean flagAnswer;
}
