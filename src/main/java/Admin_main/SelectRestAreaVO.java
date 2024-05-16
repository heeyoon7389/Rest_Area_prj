package Admin_main;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class SelectRestAreaVO {
	private String areaName, areaCode, addr, callNumber, amenites;

	public SelectRestAreaVO(String areaName, String areaCode, String addr, String callNumber, String amenites) {
		this.areaName = areaName;
		this.areaCode = areaCode;
		this.addr = addr;
		this.callNumber = callNumber;
		this.amenites = amenites;
	}

}
