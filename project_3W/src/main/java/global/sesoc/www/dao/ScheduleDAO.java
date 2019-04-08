package global.sesoc.www.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import global.sesoc.www.vo.ScheduleVO;

@Repository
public class ScheduleDAO {

	@Autowired SqlSession sqlsession;
	
	//하루 일정 목록 가져오기
	public ArrayList<ScheduleVO> getScheduleList(HashMap<String, String> hmap) {
		
		ArrayList<ScheduleVO> sList = null;
		
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);
		try {
			sList = mapper.getScheduleList(hmap);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return sList;
	}

}
