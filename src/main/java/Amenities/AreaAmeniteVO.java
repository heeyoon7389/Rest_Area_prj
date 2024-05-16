package Amenities;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@NoArgsConstructor
public class AreaAmeniteVO {
	
	private String amenitieCode, amenitieName;

	public AreaAmeniteVO(String amenitieCode, String amenitieName) {
		this.amenitieCode = amenitieCode;
		this.amenitieName = amenitieName;
	}

}
