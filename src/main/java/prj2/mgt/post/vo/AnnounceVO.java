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
public class AnnounceVO {
	private int announceNum;
	private String managerId;
	private String managerNick;
	private String title;
	private String content;
	private Date inputDate;
	private int views;
	private boolean deleteFlag;
	private Date deleteDate;

}
