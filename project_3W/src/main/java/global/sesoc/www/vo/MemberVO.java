package global.sesoc.www.vo;

public class MemberVO {
	private String email;
	private String password;
	private String identification;
	private String username;
	private String userbirthdate;
	private String twitterId; 	//트위터 계정 인증여부(Y/N)
	private String savedImage;
	
	public MemberVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public MemberVO(String email, String password, String identification, String username, String userbirthdate,
			String savedImage, String twitterId) {
		super();
		this.email = email;
		this.password = password;
		this.identification = identification;
		this.username = username;
		this.userbirthdate = userbirthdate;
		this.savedImage = savedImage;
		this.twitterId = twitterId;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getIdentification() {
		return identification;
	}
	public void setIdentification(String identification) {
		this.identification = identification;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getUserbirthdate() {
		return userbirthdate;
	}
	public void setUserbirthdate(String userbirthdate) {
		this.userbirthdate = userbirthdate;
	}
	public String getsavedImage() {
		return savedImage;
	}
	public void setsavedImage(String savedImage) {
		this.savedImage = savedImage;
	}
	public String getTwitterId() {
		return twitterId;
	}
	public void setTwitterId(String twitterId) {
		this.twitterId = twitterId;
	}
	@Override
	public String toString() {
		return "MemberVO [email=" + email + ", password=" + password + ", identification=" + identification
				+ ", username=" + username + ", userbirthdate=" + userbirthdate
				+ ", savedImage=" + savedImage + ", twitterId=" + twitterId + "]";
	}
}	
	
