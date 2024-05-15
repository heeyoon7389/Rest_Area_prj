package prj2.mgt.manageMember.vo;

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
public class MemberVO {
	private String memId;
	private String pass;
	private String name;
	private String nick;
	private String email;
	private Date joinDate;
	private boolean suspendFlag;
	private Date suspendDate;
	private boolean withdrawFlag;
	private Date withdrawDate;
}
