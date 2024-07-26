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
public class MemberVariTableVO {
	private int signInTotal;
	private int memberNowTotal;
	private int memberQuitTotal;
}
