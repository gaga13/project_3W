package global.sesoc.www.dao;

import java.util.HashMap;

public interface TwitterMapper {

	//DB에 AccessToken저장하기
	//public int insertAccessToken(HashMap<String, Object> hmap);
	
	//DB에서 AccessToken 가져오기
	public HashMap<String, Object> getAccessToken(String email);
}
