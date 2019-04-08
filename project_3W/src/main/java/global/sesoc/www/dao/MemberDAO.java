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
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		int result = 0;
		result = mapper.insertMember(member);
		return result;
	}
	//ID로 회원검색
	
	public MemberVO getMember(String email) {
		MemberMapper mapper = sqlSession.getMapper(MemberMapper.class);
		MemberVO member = null;
		member = mapper.getMember(email);
		return member;
	}

	//이메일
	

}
