package prj2VO;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor //기본 생성자 만들기
@AllArgsConstructor //모든 인스턴스변수로 생성자 만들기
@Setter//모든 인스턴스 변수로 setter method만들기
@Getter//모든 인스턴스 변수로 getter method만들기
@ToString
@Builder
public class LoginVO {
	private String memId;
	private String pass;
	private String name;
	private String nick;
	private String email;
	
	public LoginVO(String name, String email) {
		super();
		this.name = name;
		this.email = email;
	}

}
