package Store_management;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
@NoArgsConstructor
public class StoreManagementVO {
	private String storeNum, storeName, storeType, storeMemo;

	public StoreManagementVO(String storeName, String storeType, String storeNum, String storeMemo) {
		this.storeNum = storeNum;
		this.storeName = storeName;
		this.storeType = storeType;
		this.storeMemo = storeMemo;
	}
	
}
