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
public class LocationVO {
	private String raNum;
	private String raName;
	private String locNum;
	private String locName;
	private double latitude;
	private double longitude;
}
