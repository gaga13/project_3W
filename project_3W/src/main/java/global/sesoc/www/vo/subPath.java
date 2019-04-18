package global.sesoc.www.vo;

import java.util.ArrayList;

public class subPath{
	int trafficType;
	double distance;
	int sectionTime;
	ArrayList<Lane> lane;
	String startName;
	double startX;
	double startY;
	String endName;
	double endX;
	double endY;
	
	public subPath() {
		super();
	}

	public subPath(int trafficType, double distance, int sectionTime, ArrayList<Lane> lane, String startName,
			double startX, double startY, String endName, double endX, double endY) {
		super();
		this.trafficType = trafficType;
		this.distance = distance;
		this.sectionTime = sectionTime;
		this.lane = lane;
		this.startName = startName;
		this.startX = startX;
		this.startY = startY;
		this.endName = endName;
		this.endX = endX;
		this.endY = endY;
	}

	public int getTrafficType() {
		return trafficType;
	}

	public void setTrafficType(int trafficType) {
		this.trafficType = trafficType;
	}

	public double getDistance() {
		return distance;
	}

	public void setDistance(double distance) {
		this.distance = distance;
	}

	public int getSectionTime() {
		return sectionTime;
	}

	public void setSectionTime(int sectionTime) {
		this.sectionTime = sectionTime;
	}

	public ArrayList<Lane> getLane() {
		return lane;
	}

	public void setLane(ArrayList<Lane> lane) {
		this.lane = lane;
	}

	public String getStartName() {
		return startName;
	}

	public void setStartName(String startName) {
		this.startName = startName;
	}

	public double getStartX() {
		return startX;
	}

	public void setStartX(double startX) {
		this.startX = startX;
	}

	public double getStartY() {
		return startY;
	}

	public void setStartY(double startY) {
		this.startY = startY;
	}

	public String getEndName() {
		return endName;
	}

	public void setEndName(String endName) {
		this.endName = endName;
	}

	public double getEndX() {
		return endX;
	}

	public void setEndX(double endX) {
		this.endX = endX;
	}

	public double getEndY() {
		return endY;
	}

	public void setEndY(double endY) {
		this.endY = endY;
	}

	@Override
	public String toString() {
		return "subPath [trafficType=" + trafficType + ", distance=" + distance + ", sectionTime=" + sectionTime
				+ ", lane=" + lane + ", startName=" + startName + ", startX=" + startX + ", startY=" + startY
				+ ", endName=" + endName + ", endX=" + endX + ", endY=" + endY + "]";
	}
	
}