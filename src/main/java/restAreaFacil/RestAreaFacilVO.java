package restAreaFacil;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class RestAreaFacilVO {
	private String raFacilNum;
	private String raNum;
	private String facilName;
	private String facilNote;
	private String facilIcon;
	private String img;
}
