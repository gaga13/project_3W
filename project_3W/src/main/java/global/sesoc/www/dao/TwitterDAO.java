package global.sesoc.www.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class TwitterDAO {

	@Autowired SqlSession sqlSession;
	
	//DB에서 accessToken 가져오기
	public HashMap<String, Object> selectAccessToken(String email) {
		
		HashMap<String, Object> hmap = new HashMap<>();
		hmap = null;
		
		TwitterMapper mapper = sqlSession.getMapper(TwitterMapper.class);
		
		try {
			hmap = mapper.getAccessToken(email);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return hmap;
	}
	//DB에 accessToken 저장하기
	
	public int insertAccessToken(HashMap<String, Object> hmap){
		
		int result = 0;
		
		TwitterMapper mapper = sqlSession.getMapper(TwitterMapper.class);
		
		try {
			result = mapper.insertAccessToken(hmap);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}

	//DB의 트위터 인증 여부 값 업데이트
	public int updateTwitterId(String email) {
		
		int result = 0;
				
		TwitterMapper mapper = sqlSession.getMapper(TwitterMapper.class);
		
		try {
			result = mapper.updateTwitterId(email);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
	}

	public int twitterDisconnect(String email) {
		
		int result = 0;
		
		TwitterMapper mapper = sqlSession.getMapper(TwitterMapper.class);
		
		try {
			result = mapper.twitterDisconnect(email);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
		
		
	}

	public int deleteTwitterAT(String email) {
		
		int result = 0;
		
		TwitterMapper mapper = sqlSession.getMapper(TwitterMapper.class);
		
		try {
			result = mapper.deleteTwitterAT(email);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	
	
		
}
