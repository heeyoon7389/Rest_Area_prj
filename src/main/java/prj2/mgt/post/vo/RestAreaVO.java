package prj2.mgt.post.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.NoArgsConstructor;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RestAreaVO {
	private String raNum, routeId, loc_num, raName, addr, tel; 
	private int latitude, longitude;
	private Date inputDate;
}
