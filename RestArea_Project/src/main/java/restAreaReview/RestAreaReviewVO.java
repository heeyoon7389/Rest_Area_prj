package restAreaReview;

import java.util.Date;

public class RestAreaReviewVO {
	private String reviewNum;
	private String raNum;
	private String raName;
	private String note;
	private String blindFlag;
	private String memberId;
	private boolean deleteFlag;
	private Date inputDate;
	private double star;
	
	public RestAreaReviewVO() {
	}

	public RestAreaReviewVO(String reviewNum, String raNum, String raName, String note, String blindFlag,
			String memberId, boolean deleteFlag, Date inputDate, double star) {
		this.reviewNum = reviewNum;
		this.raNum = raNum;
		this.raName = raName;
		this.note = note;
		this.blindFlag = blindFlag;
		this.memberId = memberId;
		this.deleteFlag = deleteFlag;
		this.inputDate = inputDate;
		this.star = star;
	}

	public String getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(String reviewNum) {
		this.reviewNum = reviewNum;
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

	public String getNote() {
		return note;
	}

	public void setNote(String note) {
		this.note = note;
	}

	public String getBlindFlag() {
		return blindFlag;
	}

	public void setBlindFlag(String blindFlag) {
		this.blindFlag = blindFlag;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public boolean isDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(boolean deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Date getInputDate() {
		return inputDate;
	}

	public void setInputDate(Date inputDate) {
		this.inputDate = inputDate;
	}

	public double getStar() {
		return star;
	}

	public void setStar(double star) {
		this.star = star;
	}

	@Override
	public String toString() {
		return "RestAreaReviewVO [reviewNum=" + reviewNum + ", raNum=" + raNum + ", raName=" + raName + ", note=" + note
				+ ", blindFlag=" + blindFlag + ", memberId=" + memberId + ", deleteFlag=" + deleteFlag + ", inputDate="
				+ inputDate + ", star=" + star + "]";
	}
	
	
}
