package restAreaFacil;

public class RestAreaFacilVO {
	private String raFacilNum;
	private String raNum;
	private String facilName;
	private String facilNote;
	private String facilIcon;
	
	public RestAreaFacilVO() {
	}

	public RestAreaFacilVO(String raFacilNum, String raNum, String facilName, String facilNote, String facilIcon) {
		this.raFacilNum = raFacilNum;
		this.raNum = raNum;
		this.facilName = facilName;
		this.facilNote = facilNote;
		this.facilIcon = facilIcon;
	}

	public String getRaFacilNum() {
		return raFacilNum;
	}

	public void setRaFacilNum(String raFacilNum) {
		this.raFacilNum = raFacilNum;
	}

	public String getRaNum() {
		return raNum;
	}

	public void setRaNum(String raNum) {
		this.raNum = raNum;
	}

	public String getFacilName() {
		return facilName;
	}

	public void setFacilName(String facilName) {
		this.facilName = facilName;
	}

	public String getFacilNote() {
		return facilNote;
	}

	public void setFacilNote(String facilNote) {
		this.facilNote = facilNote;
	}

	public String getFacilIcon() {
		return facilIcon;
	}

	public void setFacilIcon(String facilIcon) {
		this.facilIcon = facilIcon;
	}

	@Override
	public String toString() {
		return "RestAreaFacilVO [raFacilNum=" + raFacilNum + ", raNum=" + raNum + ", facilName=" + facilName
				+ ", facilNote=" + facilNote + ", facilIcon=" + facilIcon + "]";
	}
	
}
