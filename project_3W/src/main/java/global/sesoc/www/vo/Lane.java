package global.sesoc.www.vo;

public class Lane{
	String busNo;
	String name;
	
	public Lane() {
		super();
	}

	public Lane(String busNo, String name) {
		super();
		this.busNo = busNo;
		this.name = name;
	}

	public String getBusNo() {
		return busNo;
	}

	public void setBusNo(String busNo) {
		this.busNo = busNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "Lane [busNo=" + busNo + ", name=" + name + "]";
	}
}