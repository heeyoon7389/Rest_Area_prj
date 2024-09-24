package restAreaInquiry;

import java.sql.Clob;
import java.sql.Date;


public class InquiryVO {
	
	private String inquirynum;
	private String memid;
	private String title;
	private Clob content;
	private Date input_date;
	
	
	public InquiryVO(String inquirynum, String memid, String title, Clob content, Date input_date) {
		super();
		this.inquirynum = inquirynum;
		this.memid = memid;
		this.title = title;
		this.content = content;
		this.input_date = input_date;
	}

	public String getInquirynum() {
		return inquirynum;
	}

	public void setInquirynum(String inquirynum) {
		this.inquirynum = inquirynum;
	}

	public String getMemid() {
		return memid;
	}

	public void setMemid(String memid) {
		this.memid = memid;
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

	@Override
	public String toString() {
		return "InquiryVO [inquirynum=" + inquirynum + ", memid=" + memid + ", title=" + title + ", content=" + content
				+ ", input_date=" + input_date + "]";
	}

	
	
	
	
}
