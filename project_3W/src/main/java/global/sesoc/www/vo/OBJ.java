package global.sesoc.www.vo;

public class OBJ{
	String startSTN; // 출발터미널
	double SX; // 출발x좌표
	double SY; // 출발y좌표 
	String endSTN; // 도착 터미널
	double EX; // 도착x좌표
	double EY; // 도착y좌표
	int payment; // 가격
	int time; // 시간
	
	public OBJ() {
		super();
	}

	public OBJ(String startSTN, double sX, double sY, String endSTN, double eX, double eY, int payment, int time) {
		super();
		this.startSTN = startSTN;
		SX = sX;
		SY = sY;
		this.endSTN = endSTN;
		EX = eX;
		EY = eY;
		this.payment = payment;
		this.time = time;
	}

	public String getStartSTN() {
		return startSTN;
	}

	public void setStartSTN(String startSTN) {
		this.startSTN = startSTN;
	}

	public double getSX() {
		return SX;
	}

	public void setSX(double sX) {
		SX = sX;
	}

	public double getSY() {
		return SY;
	}

	public void setSY(double sY) {
		SY = sY;
	}

	public String getEndSTN() {
		return endSTN;
	}

	public void setEndSTN(String endSTN) {
		this.endSTN = endSTN;
	}

	public double getEX() {
		return EX;
	}

	public void setEX(double eX) {
		EX = eX;
	}

	public double getEY() {
		return EY;
	}

	public void setEY(double eY) {
		EY = eY;
	}

	public int getPayment() {
		return payment;
	}

	public void setPayment(int payment) {
		this.payment = payment;
	}

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
	}

	@Override
	public String toString() {
		return "OBJ [startSTN=" + startSTN + ", SX=" + SX + ", SY=" + SY + ", endSTN=" + endSTN + ", EX=" + EX
				+ ", EY=" + EY + ", payment=" + payment + ", time=" + time + "]";
	}
	
}