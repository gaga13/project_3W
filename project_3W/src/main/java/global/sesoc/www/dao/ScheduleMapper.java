package global.sesoc.www.dao;

import java.util.ArrayList;
import java.util.HashMap;

import global.sesoc.www.vo.ScheduleVO;

public interface ScheduleMapper {

	//하루 일정 목록 가져오기
	public ArrayList<ScheduleVO> getScheduleList(HashMap<String, String> hmap);

	//일정 입력
	public int setSchedule(ScheduleVO vo);

	//달력에 일정 넣기
	public ArrayList<ScheduleVO> getSchedule(ScheduleVO vo);
}
