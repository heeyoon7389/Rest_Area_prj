package restAreaInfo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class RestAreaInfoVO {
	private String raNum;
	private String routeId;
	private String locNum;
	private String raName;
	private String raAddr;
	private double latitude;
	private double longitude;
	private String favoriteRa;
	private String memberId;
}
