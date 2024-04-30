package searchRestArea;

public class LocationVO {
	private String raNum;
	private String raName;
	private String locNum;
	private String locName;
	private double latitude;
	private double longitude;
	
	public LocationVO() {
	}

	public LocationVO(String raNum, String raName, String locNum, String locName, double latitude, double longitude) {
		this.raNum = raNum;
		this.raName = raName;
		this.locNum = locNum;
		this.locName = locName;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String getRaNum() {
		return raNum;
	}

	public void setRaNum(String raNum) {
		this.raNum = raNum;
	}

	public String getRaName() {
		return raName;
	}

	public void setRaName(String raName) {
		this.raName = raName;
	}

	public String getLocNum() {
		return locNum;
	}

	public void setLocNum(String locNum) {
		this.locNum = locNum;
	}

	public String getLocName() {
		return locName;
	}

	public void setLocName(String locName) {
		this.locName = locName;
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

	@Override
	public String toString() {
		return "LocationVO [raNum=" + raNum + ", raName=" + raName + ", locNum=" + locNum + ", locName=" + locName
				+ ", latitude=" + latitude + ", longitude=" + longitude + "]";
	}
	
}
