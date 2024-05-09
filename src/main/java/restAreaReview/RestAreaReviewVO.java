package restAreaReview;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class RestAreaReviewVO {
	private String reviewNum;
	private String raNum;
	private String raName;
	private String note;
	private String blindFlag;
	private String memberId;
	private boolean deleteFlag;
	private Date inputDate;
	private double star;
}
