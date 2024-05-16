package prj2VO;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class MyReviewVO {
	private String raReviewNum, memId, raNum, content, deleteFlag, raName;
	private Date inputDate, deleteDate;
	private double star;
}
