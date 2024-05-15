package prj2.mgt.dashboard.vo;

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
public class RaReviewRankVO {
	private int ranking;
	private String restAreaName;
	private int reviews;
}
