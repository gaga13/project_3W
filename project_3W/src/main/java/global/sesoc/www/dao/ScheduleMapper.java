package global.sesoc.www.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.www.vo.ScheduleVO;

public interface ScheduleMapper {

	//하루 일정 목록 가져오기
	public ArrayList<ScheduleVO> getScheduleList(HashMap<String, String> hmap);
	
	//하루 일정 목록 가져오기
	public ArrayList<ScheduleVO> getScheduleListClick(HashMap<String, String> hmap);
	
	//달력에 일정
	public ArrayList<ScheduleVO> getMonth(ScheduleVO vo);

	//일정 입력
	public int inSchedule(ScheduleVO vo);

	//일정 수정
	public int setSchedule(ScheduleVO vo);
	
	//일정 삭제
	public int deSchedule(HashMap<String, Object>map);

}
