package global.sesoc.www.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.ScheduleDAO;
import global.sesoc.www.vo.ScheduleVO;

@Controller
public class ScheduleController {

	@Autowired ScheduleDAO dao;
	private final static Logger logger = LoggerFactory.getLogger(ScheduleController.class);
	
	//schedule.jsp 오픈
	@RequestMapping(value = "getScheduleList", method = RequestMethod.GET)
	public String getScheduleListAccess(){
		
		return "schedule";
	}
	
	//달력에서 날짜 입력 받기
	@ResponseBody
	@RequestMapping(value="getDaily", method = RequestMethod.POST)
	public void getDaily(HttpSession session, Date daily){
		
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd");
		String newdate = format.format(daily);
		session.setAttribute("sysdate", newdate);
		
	}
	//하루 스케쥴 목록 가져오기
	@ResponseBody
	@RequestMapping(value = "getScheduleList", method = RequestMethod.POST)
	public ArrayList<ScheduleVO> getScheduleList(HttpSession ses){
		
		ArrayList<ScheduleVO> sList = null;
		
		//날짜 지정하지 않을 경우 현재날짜, 날짜 지정시 지정한 날짜로 세션값 바뀜
		String sysdate = (String) ses.getAttribute("sysdate");	
		String email = (String) ses.getAttribute("loginId");
		
		//session에 담긴 email값 읽기
		logger.debug("{}",sysdate);
		HashMap<String, String> hmap = new HashMap<String, String>();
		
		hmap.put("email", email);
		hmap.put("startdate", sysdate);

		sList = dao.getScheduleList(hmap);
		
		ses.setAttribute("sListSize", (sList.size()+1));
		logger.debug("sList:{}", sList);
		
		return sList;
	}
	
	//오늘 스케쥴 중 하나 클릭했을 때 정보 가져오기
	@ResponseBody
	@RequestMapping(value = "clickList", method = RequestMethod.POST)
	public ScheduleVO clickList(int i, HttpSession session){
		String sysdate = (String) session.getAttribute("sysdate");
		String email = (String) session.getAttribute("loginId");

		HashMap<String, String> hmap = new HashMap<String, String>();
		
		hmap.put("email", email);
		hmap.put("startdate", sysdate);
		
		ArrayList<ScheduleVO> sList = dao.getScheduleListClick(hmap);
		
		ScheduleVO iList = sList.get(i);

		return iList;
	}
	
	//캘린더 폼
	@RequestMapping(value = "getMcalendar", method = RequestMethod.GET)
	public String getMcalendar(){
		
		return "Mcalendar";
	}
	
	//한달 일정을 캘린더에 출력
	@ResponseBody
	@RequestMapping(value="getMonth", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ArrayList<ScheduleVO> Month(HttpSession session, String st, String ed){
		
		String id =(String) session.getAttribute("loginId");
		
		ScheduleVO vo = new ScheduleVO(id,st,ed);
		ArrayList<ScheduleVO> mlist = dao.getMonth(vo);

		return mlist;
	}
	
	//일정 입력
	@ResponseBody
	@RequestMapping(value="inSchedule", method=RequestMethod.POST)
	public void insertSchedule(ScheduleVO vo){
		logger.debug("입력용:{}", vo);
		
		String[] st = vo.getStartdate().split(",");
		String[] ed = vo.getEnddate().split(",");
		vo.setStartdate(st[0]+" "+st[1]);
		vo.setEnddate(ed[0]+" "+ed[1]);
		
		int result = dao.inSchedule(vo);
		
		if(result == 0){
			logger.debug("일정 입력 실패 원인을 찾으세요.");
		}else{
			logger.debug("일정 입력은 성공입니다.");
		}
	}
	
	//일정 수정
	@ResponseBody
	@RequestMapping(value="setSchedule", method=RequestMethod.POST)
	public void setSchedule(ScheduleVO vo){
		logger.debug("수정용:{}", vo);
		
		String[] st = vo.getStartdate().split(",");
		String[] ed = vo.getEnddate().split(",");
		vo.setStartdate(st[0]+" "+st[1]);
		vo.setEnddate(ed[0]+" "+ed[1]);
		
		int result = dao.setSchedule(vo);
		
		if(result == 0){
			logger.debug("일정 입력 실패 원인을 찾으세요.");
		}else{
			logger.debug("일정 입력은 성공입니다.");
		}
	}
	
	//일정 삭제
	@ResponseBody
	@RequestMapping(value="deSchedule", method=RequestMethod.POST)
	public void deSchedule(String email, int num){
		
		logger.debug("아이디:{}, 번호:{}", email, num);
		HashMap<String, Object> map = new HashMap<>();
		map.put("email", email);
		map.put("num", num);
		 
		int result =dao.deSchedule(map);
		
		if(result == 0 ){
			logger.debug("삭제에 실패했습니다.");
		}else{
			logger.debug("일정을 삭제했습니다.");
		}
	}
	
	
}
