package restAreaAnnounce;

import java.sql.Clob;
import java.sql.Date;

public class AnnounceVO {
	private String announce_num;
	private String managerid;
	private String title;
	private Clob content;
	private Date input_date;
	private int announce_view;
	
	public AnnounceVO(String announce_num, String managerid, String title, Clob content, Date input_date,
			int announce_view) {
		super();
		this.announce_num = announce_num;
		this.managerid = managerid;
		this.title = title;
		this.content = content;
		this.input_date = input_date;
		this.announce_view = announce_view;
	}

	public String getAnnounce_num() {
		return announce_num;
	}

	public void setAnnounce_num(String announce_num) {
		this.announce_num = announce_num;
	}

	public String getManagerid() {
		return managerid;
	}

	public void setManagerid(String managerid) {
		this.managerid = managerid;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Clob getContent() {
		return content;
	}

	public void setContent(Clob content) {
		this.content = content;
	}

	public Date getInput_date() {
		return input_date;
	}

	public void setInput_date(Date input_date) {
		this.input_date = input_date;
	}

	public int getAnnounce_view() {
		return announce_view;
	}

	public void setAnnounce_view(int announce_view) {
		this.announce_view = announce_view;
	}

	@Override
	public String toString() {
		return "AnnounceVO [announce_num=" + announce_num + ", managerid=" + managerid + ", title=" + title
				+ ", content=" + content + ", input_date=" + input_date + ", announce_view=" + announce_view + "]";
	}
	
	
	
	
	
}
