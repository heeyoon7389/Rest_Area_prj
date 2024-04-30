package storeRep;

public class StoreRepVO {
	private String storeRepNum;
	private String memberId;
	private String contents;
	private String storeNum;
	
	public StoreRepVO() {
	}
	
	public StoreRepVO(String storeRepNum, String memberId, String contents, String storeNum) {
		this.storeRepNum = storeRepNum;
		this.memberId = memberId;
		this.contents = contents;
		this.storeNum = storeNum;
	}



	public String getStoreRepNum() {
		return storeRepNum;
	}

	public void setStoreRepNum(String storeRepNum) {
		this.storeRepNum = storeRepNum;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public String getStoreNum() {
		return storeNum;
	}

	public void setStoreNum(String storeNum) {
		this.storeNum = storeNum;
	}

	@Override
	public String toString() {
		return "StoreRepVO [storeRepNum=" + storeRepNum + ", memberId=" + memberId + ", contents=" + contents
				+ ", storeNum=" + storeNum + "]";
	}
	
	
}
