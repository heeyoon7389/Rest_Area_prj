package restAreaInquiry;


import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class InquirydetailVO {
	
	private String inquirynum;
	private String memid;
	private String title;
	private String content;
	private Date input_date;
	private boolean secret_flag;
	private String answer_contents;
	private Date answer_date;
	private boolean answer_flag;
	

}
