package global.sesoc.www.vo;

public class ScheduleVO {
	private String email;					//이메일
	private int snum;						//스케쥴 번호
	private String scontent;				//스케쥴 내용
	private String startdate;				//스케쥴 시작 날짜(년/월/일/시간)
	private String enddate;					//스케쥴 끝 날짜	(년/월/일/시간)
	private String slocation;				//스케쥴 위치
	private String slatitude;				//스케쥴 위치에 따른 위도
	private String slongitude;				//스케쥴 위치에 따른 경도
	
	public ScheduleVO() {
		super();
	}

	public ScheduleVO(String email, String startdate, String enddate) {
		super();
		this.email = email;
		this.startdate = startdate;
		this.enddate = enddate;
	}

	public ScheduleVO(String email, int snum, String scontent, String startdate, String enddate, String slocation) {
		super();
		this.email = email;
		this.snum = snum;
		this.scontent = scontent;
		this.startdate = startdate;
		this.enddate = enddate;
		this.slocation = slocation;
	}

	
	public ScheduleVO(String email, int snum, String scontent, String startdate, String enddate, String slocation,
			String slatitude, String slongitude) {
		super();
		this.email = email;
		this.snum = snum;
		this.scontent = scontent;
		this.startdate = startdate;
		this.enddate = enddate;
		this.slocation = slocation;
		this.slatitude = slatitude;
		this.slongitude = slongitude;
	}
	

	public String getSlatitude() {
		return slatitude;
	}

	public void setSlatitude(String slatitude) {
		this.slatitude = slatitude;
	}

	public String getSlongitude() {
		return slongitude;
	}

	public void setSlongitude(String slongitude) {
		this.slongitude = slongitude;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getSnum() {
		return snum;
	}

	public void setSnum(int snum) {
		this.snum = snum;
	}

	public String getScontent() {
		return scontent;
	}

	public void setScontent(String scontent) {
		this.scontent = scontent;
	}

	public String getStartdate() {
		return startdate;
	}

	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public String getSlocation() {
		return slocation;
	}

	public void setSlocation(String slocation) {
		this.slocation = slocation;
	}

	@Override
	public String toString() {
		return "ScheduleVO [email=" + email + ", snum=" + snum + ", scontent=" + scontent + ", startdate=" + startdate
				+ ", enddate=" + enddate + ", slocation=" + slocation + ", slatitude=" + slatitude + ", slongitude="
				+ slongitude + "]";
	}

	

	
}