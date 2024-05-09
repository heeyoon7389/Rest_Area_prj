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
public class RouteVO {
	private String raNum;
	private String raName;
	private String routeNum;
	private String routeName;
	private double restAreaLatitude;
	private double restAreaLongitude;
	private String nodeId;
	private double nodeLatitude;
	private double nodeLongitude;
	private String nodeName;
	private String linkId;
	private String nodeStart;
	private String nodeEnd;
}
