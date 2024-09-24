package restAreaAnnounce;



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
public class AnnounceVO {
	
	private String announce_num;
	private String managerid;
	private String title;
	private String content;
	private Date input_date;
	private int announce_view;
	

}
