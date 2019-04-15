package global.sesoc.www.dao;

import java.util.HashMap;

public interface TwitterMapper {

	//DB에 AccessToken저장하기
	public int insertAccessToken(HashMap<String, Object> hmap);
	
	//DB에서 AccessToken 가져오기
	public HashMap<String, Object> getAccessToken(String email);

	//DB에서 user_info 테이블의 twitterId 칼럼 값 Y로 변경
	public int updateTwitterId(String email);
	
	//DB에서 user_info 테이블의 twitterId 칼럼 값 N로 변경
	public int twitterDisconnect(String email);

	//DB에서 AccessToken 지우기
	public int deleteTwitterAT(String email);
}
