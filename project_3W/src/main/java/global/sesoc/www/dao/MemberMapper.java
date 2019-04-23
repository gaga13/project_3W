package global.sesoc.www.dao;

import java.util.HashMap;

import global.sesoc.www.vo.MemberVO;

public interface MemberMapper {

	public int insertMember(MemberVO member);

	public MemberVO getMember(String email);
	
	public int update(MemberVO member);
	
	public int insertImage(HashMap<String, Object> hmap);
	
	public HashMap<String, Object> selectImage(String email);
}
