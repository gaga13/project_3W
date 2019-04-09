package global.sesoc.www.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;

import javax.servlet.http.HttpSession;
import javax.xml.ws.Response;

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
	
	//하루 스케쥴 목록 가져오기

	@ResponseBody
	@RequestMapping(value = "getScheduleList", method = RequestMethod.POST)
	public ArrayList<ScheduleVO> getScheduleList(HttpSession ses){
		
		ArrayList<ScheduleVO> sList = null;
		
		//날짜 지정하지 않을 경우 현재날짜, 날짜 지정시 지정한 날짜로 세션값 바뀜
		String sysdate = (String) ses.getAttribute("sysdate");
		
		String startdate = sysdate.substring(0,4)+'/' + sysdate.substring(6,7)+'/' + sysdate.substring(9,10);
		String email = "weer13@naver.com";
		logger.debug("startdate:{}", startdate);
		//session에 담긴 email값 읽기
		
		
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("email", email);
		hmap.put("startdate", startdate);
		
		sList = dao.getScheduleList(hmap);
		
		ses.setAttribute("sListSize", (sList.size()+1));
		logger.debug("sList:{}", sList);
		
		
		return sList;
	}
	
	//캘린더 폼
	@RequestMapping(value = "getMcalendar", method = RequestMethod.GET)
	public String getMcalendar(){
		
		return "Mcalendar";
	}
	
	//일정 입력
	@ResponseBody
	@RequestMapping(value="setSchedule", method=RequestMethod.POST)
	public void insertSchedule(ScheduleVO vo){
		logger.debug("입력용:{}", vo);
		int result = dao.setSchedule(vo);
		
	}
	
}
