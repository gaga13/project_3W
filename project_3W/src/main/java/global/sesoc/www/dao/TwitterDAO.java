package global.sesoc.www.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;



@Repository
public class TwitterDAO {

	@Autowired SqlSession sqlsession;
	
	//DB에서 accessToken 가져오기
		public HashMap<String, Object> selectAccessToken(String email) {
			
			HashMap<String, Object> hmap = new HashMap<>();
			hmap = null;
			
			TwitterMapper mapper = sqlsession.getMapper(TwitterMapper.class);
			
			try {
				hmap = mapper.getAccessToken(email);
			} 
			catch (Exception e) {
				e.printStackTrace();
			}
			
			
			return hmap;
		}
}
