package searchRestArea;

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
public class RestAreaNameVO {
	private String raNum;
	private String routeId;
	private String locNum;
	private String raName;
	private String raAddr;
	private String raTel;
	private double latitude;
	private double longitude;
	private String menuImg;
	
	public RestAreaNameVO(String raName, String raAddr, String raTel, double latitude, double longitude) {
		this.raName = raName;
		this.raAddr = raAddr;
		this.raTel = raTel;
		this.latitude = latitude;
		this.longitude = longitude;
	}
}
