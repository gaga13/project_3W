package global.sesoc.www.vo;

public class MemberVO {
	private String email;
	private String password;
	private String identification;
	private String username;
	private String userbirthdate;
	private String profile_photo;
	private String originalfile;
	private String Savedfile;
	
	public MemberVO(){
		super();
	}
	
	public MemberVO(String email, String password, String identification){
		this.email = email;
		this.password = password;
		this.identification = identification;
	}
	
	public MemberVO(String email, String password, String identification, String username, String userbirthdate, String profile_photo, String originalfile, String Savedfile){
		this.email = email;
		this.password = password;
		this.identification = identification;
		this.username = username;
		this.userbirthdate = userbirthdate;
		this.profile_photo = profile_photo;
		this.originalfile = originalfile;
		this.Savedfile = Savedfile;
	}

	@Override
	public String toString() {
		return "MemberVO [email=" + email + ", password=" + password + ", identification=" + identification
				+ ", username=" + username + ", userbirthdate=" + userbirthdate + ", profile_photo=" + profile_photo
				+ ", originalFile=" + originalfile + ", Savedfile=" + Savedfile + "]";
	}

	public String getEmail() {
		return email;
	}

	public String getProfile_photo() {
		return profile_photo;
	}

	public void setProfile_photo(String profile_photo) {
		this.profile_photo = profile_photo;
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

	public String getOriginalfile() {
		return originalfile;
	}

	public void setOriginalfile(String originalfile) {
		this.originalfile = originalfile;
	}

	public String getSavedfile() {
		return Savedfile;
	}

	public void setSavedfile(String savedfile) {
		this.Savedfile = savedfile;
	}

	public void setUserbirthdate(String userbirthdate) {
		this.userbirthdate = userbirthdate;
	}

}
