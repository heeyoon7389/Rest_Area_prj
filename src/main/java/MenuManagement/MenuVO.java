package MenuManagement;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class MenuVO {
	private String menuNum, menuName, storeName, price, note;
	
	public MenuVO(String menuNum, String menuName, String storeName, String price, String note) {
		this.menuNum = menuNum;
		this.menuName = menuName;
		this.storeName = storeName;
		this.price = price;
		this.note = note;
	}
	
	
}
