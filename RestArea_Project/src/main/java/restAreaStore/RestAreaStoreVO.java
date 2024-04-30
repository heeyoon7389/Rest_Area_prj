package restAreaStore;

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
	
	public RestAreaStoreVO() {
	}

	public RestAreaStoreVO(String menuNum, String raNum, String storeName, String menuName, String menuImg,
			String menuNote, int price, boolean deleteFlag, String storeNum, String storeKind, String storeNote) {
		this.menuNum = menuNum;
		this.raNum = raNum;
		this.storeName = storeName;
		this.menuName = menuName;
		this.menuImg = menuImg;
		this.menuNote = menuNote;
		this.price = price;
		this.deleteFlag = deleteFlag;
		this.storeNum = storeNum;
		this.storeKind = storeKind;
		this.storeNote = storeNote;
	}
	
	public String getMenuNum() {
		return menuNum;
	}

	public void setMenuNum(String menuNum) {
		this.menuNum = menuNum;
	}

	public String getRaNum() {
		return raNum;
	}

	public void setRaNum(String raNum) {
		this.raNum = raNum;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getMenuName() {
		return menuName;
	}

	public void setMenuName(String menuName) {
		this.menuName = menuName;
	}

	public String getMenuImg() {
		return menuImg;
	}

	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}

	public String getMenuNote() {
		return menuNote;
	}

	public void setMenuNote(String menuNote) {
		this.menuNote = menuNote;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public boolean isDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public String getStoreNum() {
		return storeNum;
	}

	public void setStoreNum(String storeNum) {
		this.storeNum = storeNum;
	}

	public String getStoreKind() {
		return storeKind;
	}

	public void setStoreKind(String storeKind) {
		this.storeKind = storeKind;
	}

	public String getStoreNote() {
		return storeNote;
	}

	public void setStoreNote(String storeNote) {
		this.storeNote = storeNote;
	}

	@Override
	public String toString() {
		return "RestAreaStoreVO [menuNum=" + menuNum + ", raNum=" + raNum + ", storeName=" + storeName + ", menuName="
				+ menuName + ", menuImg=" + menuImg + ", menuNote=" + menuNote + ", price=" + price + ", deleteFlag="
				+ deleteFlag + ", storeNum=" + storeNum + ", storeKind=" + storeKind + ", storeNote=" + storeNote + "]";
	}
	
}
