package global.sesoc.www.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.vo.MemberVO;



@Repository
public class MemberDAO {
	
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
	
	//이메일
	

}
