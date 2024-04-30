package restAreaInfo;

public class RestAreaInfoVO {
	private String raNum;
	private String routeId;
	private String locNum;
	private String raName;
	private String raAddr;
	private double latitude;
	private double longitude;
	private boolean favoriteRa;
	private String memberId;

	public RestAreaInfoVO() {

	}// 기본 생성자

	public RestAreaInfoVO(String raNum, String routeId, String locNum, String raName, String raAddr, double latitude,
			double longitude, boolean favoriteRa, String memberId) {
		this.raNum = raNum;
		this.routeId = routeId;
		this.locNum = locNum;
		this.raName = raName;
		this.raAddr = raAddr;
		this.latitude = latitude;
		this.longitude = longitude;
		this.favoriteRa = favoriteRa;
		this.memberId = memberId;
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

	public boolean isFavoriteRa() {
		return favoriteRa;
	}

	public void setFavoriteRa(boolean favoriteRa) {
		this.favoriteRa = favoriteRa;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	@Override
	public String toString() {
		return "RestAreaInfoVO [raNum=" + raNum + ", routeId=" + routeId + ", locNum=" + locNum + ", raName=" + raName
				+ ", raAddr=" + raAddr + ", latitude=" + latitude + ", longitude=" + longitude + ", favoriteRa="
				+ favoriteRa + ", memberId=" + memberId + "]";
	}

}
