package global.sesoc.www.dao;


import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.vo.MemberVO;



@Repository
public class MemberDAO {
	
	public static final Logger logger = LoggerFactory.getLogger(MemberDAO.class);
	
	@Autowired
	SqlSession sqlSession;
	
	//회원가입처리
	public int insertMember(MemberVO member){
		
		int result = 0;
		
		try {
			MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
			result = mapper.insertMember(member);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		return result;
	}
	
	//ID로 회원검색
	public MemberVO getMember(String email) {
		MemberVO member = null;
		MemberMapper mapper;
		try {
			mapper = sqlSession.getMapper(MemberMapper.class);
			
			member = mapper.getMember(email);
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return member;
	}

	//회원정보 업데이트
	public int update(MemberVO member) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int result = 0;
		result = mapper.update(member);
		return result;
	}
	
	//회원정보 사진 넣기
	public int insertImage(HashMap<String, Object> hmap){
		
		int result = 0;
		
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		
		try {
			result = mapper.insertImage(hmap);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	//회원정보 사진 가져오기
	public HashMap<String, Object> selectImage(String email) {	
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);		
		HashMap<String, Object> hmap = mapper.selectImage(email);
		
		return hmap;
	}

}
