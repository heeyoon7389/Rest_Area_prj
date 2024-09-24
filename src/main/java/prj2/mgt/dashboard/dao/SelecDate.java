package prj2.mgt.dashboard.dao;

public enum SelecDate {
	TODAY(0), 
	WEEK(1),
	MONTH(2);
	
	private final int value;
	
	private SelecDate(int value) {
		this.value = value;
	}
	public int getValue() {
		return this.value;
	}
}
