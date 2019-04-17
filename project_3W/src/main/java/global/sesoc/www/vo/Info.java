package global.sesoc.www.vo;

public	class Info{
	int payment;
	int busTransitCount;
	int subwayTransitCount;
	int totalStationCount;
	int totalTime;
	int totalWalk;
	String firstStartStation;
	String lastEndStation;
	double trafficDistance;
	double totalDistance;
	
	public Info() {
		super();
	}

	public Info(int payment, int busTransitCount, int subwayTransitCount, int totalStationCount, int totalTime,
			int totalWalk, String firstStartStation, String lastEndStation, double trafficDistance,
			double totalDistance) {
		super();
		this.payment = payment;
		this.busTransitCount = busTransitCount;
		this.subwayTransitCount = subwayTransitCount;
		this.totalStationCount = totalStationCount;
		this.totalTime = totalTime;
		this.totalWalk = totalWalk;
		this.firstStartStation = firstStartStation;
		this.lastEndStation = lastEndStation;
		this.trafficDistance = trafficDistance;
		this.totalDistance = totalDistance;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public int getBusTransitCount() {
		return busTransitCount;
	}

	public void setBusTransitCount(int busTransitCount) {
		this.busTransitCount = busTransitCount;
	}

	public int getSubwayTransitCount() {
		return subwayTransitCount;
	}

	public void setSubwayTransitCount(int subwayTransitCount) {
		this.subwayTransitCount = subwayTransitCount;
	}

	public int getTotalStationCount() {
		return totalStationCount;
	}

	public void setTotalStationCount(int totalStationCount) {
		this.totalStationCount = totalStationCount;
	}

	public int getTotalTime() {
		return totalTime;
	}

	public void setTotalTime(int totalTime) {
		this.totalTime = totalTime;
	}

	public int getTotalWalk() {
		return totalWalk;
	}

	public void setTotalWalk(int totalWalk) {
		this.totalWalk = totalWalk;
	}

	public String getFirstStartStation() {
		return firstStartStation;
	}

	public void setFirstStartStation(String firstStartStation) {
		this.firstStartStation = firstStartStation;
	}

	public String getLastEndStation() {
		return lastEndStation;
	}

	public void setLastEndStation(String lastEndStation) {
		this.lastEndStation = lastEndStation;
	}

	public double getTrafficDistance() {
		return trafficDistance;
	}

	public void setTrafficDistance(double trafficDistance) {
		this.trafficDistance = trafficDistance;
	}

	public double getTotalDistance() {
		return totalDistance;
	}

	public void setTotalDistance(double totalDistance) {
		this.totalDistance = totalDistance;
	}

	@Override
	public String toString() {
		return "Info [payment=" + payment + ", busTransitCount=" + busTransitCount + ", subwayTransitCount="
				+ subwayTransitCount + ", totalStationCount=" + totalStationCount + ", totalTime=" + totalTime
				+ ", totalWalk=" + totalWalk + ", firstStartStation=" + firstStartStation + ", lastEndStation="
				+ lastEndStation + ", trafficDistance=" + trafficDistance + ", totalDistance=" + totalDistance
				+ "]";
	}
	
}