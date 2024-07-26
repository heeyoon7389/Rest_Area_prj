package prj2.mgt.login.vo;

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
public class ManagerVO {
	private String managerId;
	private String pass;
	private String name;
	private String nick;
	private Date inputDate;
}
