package restAreaStore;

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
public class RestAreaStoreVO {
	private String menuNum;
	private String raNum;
	private String storeName;
	private String menuName;
	private String menuImg;
	private String menuNote;
	private int price;
	private boolean deleteFlag;
	private String storeNum;
	private String storeKind;
	private String storeNote;
}
