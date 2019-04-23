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
	
	//하루 일정 목록 하나 클릭했을 때 가져오기
	public ArrayList<ScheduleVO> getScheduleListClick(HashMap<String, String> hmap) {
		
		ArrayList<ScheduleVO> sList = null;
		
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);
		try {
			sList = mapper.getScheduleListClick(hmap);
		} 
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return sList;
	}	
	
	//일정을 달력에 호출
	public ArrayList<ScheduleVO> getMonth(ScheduleVO vo) {
		
		ArrayList<ScheduleVO> list = null;
		
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);

		try{
		
			list = mapper.getMonth(vo);
		
		}catch(Exception e){
			e.printStackTrace();
		}

		return list;
	}

	//일정 입력
	public int inSchedule(ScheduleVO vo){
		int result = 0;
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);
		try{
			result = mapper.inSchedule(vo);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result; 
	}

	//일정 수정
	public int setSchedule(ScheduleVO vo){
		int result = 0;
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);
		try{
			result = mapper.setSchedule(vo);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result; 
	}
	
	//일정 삭제
	public int deSchedule(HashMap<String, Object> map){
		int result = 0;
		ScheduleMapper mapper = sqlsession.getMapper(ScheduleMapper.class);
		try{
			result = mapper.deSchedule(map);
		
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return result; 
	}

}
