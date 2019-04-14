package global.sesoc.www.dao;

import global.sesoc.www.vo.MemberVO;

public interface MemberMapper {

	public int insertMember(MemberVO member);

	public MemberVO getMember(String email);
	
	public int update(MemberVO member);
}
