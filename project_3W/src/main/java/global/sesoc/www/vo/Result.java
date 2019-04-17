package global.sesoc.www.vo;

import java.util.ArrayList;


public class Result{
	int searchType;
	
	//시내 대중교통 이용 시 사용할 변수
	ArrayList<path> path;
	int subwayCount;
	int busCount;
	int outTrafficCheck;

	//도시간 대중교통 이용 시 사용할 변수
	String startCityName; // 출발지 도시 이름
	String endCityName; // 도착지 도시 이름
	int totalCount; // 총 결과 개수
	trainRequest trainRequest; // 기차 관련
	exBusRequest exBusRequest; // 고속버스 관련
	outBusRequest outBusRequest; // 시외버스 관련
	airRequest airRequest; // 항공 관련

	public Result() {
		super();
	}

	public Result(int searchType, ArrayList<path> path, int subwayCount, int busCount,
			int outTrafficCheck, String startCityName, String endCityName, int totalCount,
			trainRequest trainRequest, exBusRequest exBusRequest,
			outBusRequest outBusRequest, airRequest airRequest) {
		super();
		this.searchType = searchType;
		this.path = path;
		this.subwayCount = subwayCount;
		this.busCount = busCount;
		this.outTrafficCheck = outTrafficCheck;
		this.startCityName = startCityName;
		this.endCityName = endCityName;
		this.totalCount = totalCount;
		this.trainRequest = trainRequest;
		this.exBusRequest = exBusRequest;
		this.outBusRequest = outBusRequest;
		this.airRequest = airRequest;
	}

	public int getSearchType() {
		return searchType;
	}

	public void setSearchType(int searchType) {
		this.searchType = searchType;
	}

	public ArrayList<path> getPath() {
		return path;
	}

	public void setPath(ArrayList<path> path) {
		this.path = path;
	}

	public int getSubwayCount() {
		return subwayCount;
	}

	public void setSubwayCount(int subwayCount) {
		this.subwayCount = subwayCount;
	}

	public int getBusCount() {
		return busCount;
	}

	public void setBusCount(int busCount) {
		this.busCount = busCount;
	}

	public int getOutTrafficCheck() {
		return outTrafficCheck;
	}

	public void setOutTrafficCheck(int outTrafficCheck) {
		this.outTrafficCheck = outTrafficCheck;
	}

	public String getStartCityName() {
		return startCityName;
	}

	public void setStartCityName(String startCityName) {
		this.startCityName = startCityName;
	}

	public String getEndCityName() {
		return endCityName;
	}

	public void setEndCityName(String endCityName) {
		this.endCityName = endCityName;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public trainRequest getTrainRequest() {
		return trainRequest;
	}

	public void setTrainRequest(trainRequest trainRequest) {
		this.trainRequest = trainRequest;
	}

	public exBusRequest getExBusRequest() {
		return exBusRequest;
	}

	public void setExBusRequest(exBusRequest exBusRequest) {
		this.exBusRequest = exBusRequest;
	}

	public outBusRequest getOutBusRequest() {
		return outBusRequest;
	}

	public void setOutBusRequest(outBusRequest outBusRequest) {
		this.outBusRequest = outBusRequest;
	}

	public airRequest getAirRequest() {
		return airRequest;
	}

	public void setAirRequest(airRequest airRequest) {
		this.airRequest = airRequest;
	}

	@Override
	public String toString() {
		return "Result [searchType=" + searchType + ", path=" + path + ", subwayCount=" + subwayCount
				+ ", busCount=" + busCount + ", outTrafficCheck=" + outTrafficCheck + ", startCityName="
				+ startCityName + ", endCityName=" + endCityName + ", totalCount=" + totalCount + ", trainRequest="
				+ trainRequest + ", exBusRequest=" + exBusRequest + ", outBusRequest=" + outBusRequest
				+ ", airRequest=" + airRequest + "]";
	}	
	
	//도시간 이동시 사용하는 클래스
	public class trainRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		public trainRequest() {
			super();
		}

		public trainRequest(int count, ArrayList<OBJ> oBJ) {
			super();
			this.count = count;
			OBJ = oBJ;
		}

		public int getCount() {
			return count;
		}

		public void setCount(int count) {
			this.count = count;
		}

		public ArrayList<OBJ> getOBJ() {
			return OBJ;
		}

		public void setOBJ(ArrayList<OBJ> oBJ) {
			OBJ = oBJ;
		}

		@Override	
		public String toString() {
			return "trainRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	public class exBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		public exBusRequest() {
			super();
		}

		public exBusRequest(int count, ArrayList<OBJ> oBJ) {
			super();
			this.count = count;
			OBJ = oBJ;
		}

		public int getCount() {
			return count;
		}

		public void setCount(int count) {
			this.count = count;
		}

		public ArrayList<OBJ> getOBJ() {
			return OBJ;
		}

		public void setOBJ(ArrayList<OBJ> oBJ) {
			OBJ = oBJ;
		}

		@Override	
		public String toString() {
			return "exBusRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	public class outBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		public outBusRequest() {
			super();
		}

		public outBusRequest(int count, ArrayList<OBJ> oBJ) {
			super();
			this.count = count;
			OBJ = oBJ;
		}

		public int getCount() {
			return count;
		}

		public void setCount(int count) {
			this.count = count;
		}

		public ArrayList<OBJ> getOBJ() {
			return OBJ;
		}

		public void setOBJ(ArrayList<OBJ> oBJ) {
			OBJ = oBJ;
		}

		@Override
		public String toString() {
			return "outBusRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	public class airRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		public airRequest() {
			super();
		}

		public airRequest(int count, ArrayList<OBJ> oBJ) {
			super();
			this.count = count;
			OBJ = oBJ;
		}

		public int getCount() {
			return count;
		}

		public void setCount(int count) {
			this.count = count;
		}

		public ArrayList<OBJ> getOBJ() {
			return OBJ;
		}

		public void setOBJ(ArrayList<OBJ> oBJ) {
			OBJ = oBJ;
		}

		@Override
		public String toString() {
			return "airRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
	}
	
}