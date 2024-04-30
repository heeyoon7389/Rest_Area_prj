package searchRestArea;

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
	
	public RouteVO() {
		
	}

	public RouteVO(String raNum, String raName, String routeNum, String routeName, double restAreaLatitude,
			double restAreaLongitude, String nodeId, double nodeLatitude, double nodeLongitude, String nodeName,
			String linkId, String nodeStart, String nodeEnd) {
		this.raNum = raNum;
		this.raName = raName;
		this.routeNum = routeNum;
		this.routeName = routeName;
		this.restAreaLatitude = restAreaLatitude;
		this.restAreaLongitude = restAreaLongitude;
		this.nodeId = nodeId;
		this.nodeLatitude = nodeLatitude;
		this.nodeLongitude = nodeLongitude;
		this.nodeName = nodeName;
		this.linkId = linkId;
		this.nodeStart = nodeStart;
		this.nodeEnd = nodeEnd;
	}

	public String getRaNum() {
		return raNum;
	}

	public void setRaNum(String raNum) {
		this.raNum = raNum;
	}

	public String getRaName() {
		return raName;
	}

	public void setRaName(String raName) {
		this.raName = raName;
	}

	public String getRouteNum() {
		return routeNum;
	}

	public void setRouteNum(String routeNum) {
		this.routeNum = routeNum;
	}

	public String getRouteName() {
		return routeName;
	}

	public void setRouteName(String routeName) {
		this.routeName = routeName;
	}

	public double getRestAreaLatitude() {
		return restAreaLatitude;
	}

	public void setRestAreaLatitude(double restAreaLatitude) {
		this.restAreaLatitude = restAreaLatitude;
	}

	public double getRestAreaLongitude() {
		return restAreaLongitude;
	}

	public void setRestAreaLongitude(double restAreaLongitude) {
		this.restAreaLongitude = restAreaLongitude;
	}

	public String getNodeId() {
		return nodeId;
	}

	public void setNodeId(String nodeId) {
		this.nodeId = nodeId;
	}

	public double getNodeLatitude() {
		return nodeLatitude;
	}

	public void setNodeLatitude(double nodeLatitude) {
		this.nodeLatitude = nodeLatitude;
	}

	public double getNodeLongitude() {
		return nodeLongitude;
	}

	public void setNodeLongitude(double nodeLongitude) {
		this.nodeLongitude = nodeLongitude;
	}

	public String getNodeName() {
		return nodeName;
	}

	public void setNodeName(String nodeName) {
		this.nodeName = nodeName;
	}

	public String getLinkId() {
		return linkId;
	}

	public void setLinkId(String linkId) {
		this.linkId = linkId;
	}

	public String getNodeStart() {
		return nodeStart;
	}

	public void setNodeStart(String nodeStart) {
		this.nodeStart = nodeStart;
	}

	public String getNodeEnd() {
		return nodeEnd;
	}

	public void setNodeEnd(String nodeEnd) {
		this.nodeEnd = nodeEnd;
	}

	@Override
	public String toString() {
		return "RoutdeVO [raNum=" + raNum + ", raName=" + raName + ", routeNum=" + routeNum + ", routeName=" + routeName
				+ ", restAreaLatitude=" + restAreaLatitude + ", restAreaLongitude=" + restAreaLongitude + ", nodeId="
				+ nodeId + ", nodeLatitude=" + nodeLatitude + ", nodeLongitude=" + nodeLongitude + ", nodeName="
				+ nodeName + ", linkId=" + linkId + ", nodeStart=" + nodeStart + ", nodeEnd=" + nodeEnd + "]";
	}
	
}
