package searchRestArea;

public class RestAreaNameVO {
	private String raNum;
	private String routeId;
	private String locNum;
	private String raName;
	private String raAddr;
	private String raTel;
	private double latitude;
	private double longitude;
	private String menuImg;
	
	public RestAreaNameVO() {
	}

	public RestAreaNameVO(String raNum, String routeId, String locNum, String raName, String raAddr, String raTel,
			double latitude, double longitude, String menuImg) {
		this.raNum = raNum;
		this.routeId = routeId;
		this.locNum = locNum;
		this.raName = raName;
		this.raAddr = raAddr;
		this.raTel = raTel;
		this.latitude = latitude;
		this.longitude = longitude;
		this.menuImg = menuImg;
	}

	public String getRaNum() {
		return raNum;
	}

	public void setRaNum(String raNum) {
		this.raNum = raNum;
	}

	public String getRouteId() {
		return routeId;
	}

	public void setRouteId(String routeId) {
		this.routeId = routeId;
	}

	public String getLocNum() {
		return locNum;
	}

	public void setLocNum(String locNum) {
		this.locNum = locNum;
	}

	public String getRaName() {
		return raName;
	}

	public void setRaName(String raName) {
		this.raName = raName;
	}

	public String getRaAddr() {
		return raAddr;
	}

	public void setRaAddr(String raAddr) {
		this.raAddr = raAddr;
	}

	public String getRaTel() {
		return raTel;
	}

	public void setRaTel(String raTel) {
		this.raTel = raTel;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getMenuImg() {
		return menuImg;
	}

	public void setMenuImg(String menuImg) {
		this.menuImg = menuImg;
	}

	@Override
	public String toString() {
		return "RestAreaNameVO [raNum=" + raNum + ", routeId=" + routeId + ", locNum=" + locNum + ", raName=" + raName
				+ ", raAddr=" + raAddr + ", raTel=" + raTel + ", latitude=" + latitude + ", longitude=" + longitude
				+ ", menuImg=" + menuImg + "]";
	}
}
