package global.sesoc.www.controller;

import java.util.ArrayList;
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
		
		//임시로 email, 날짜 지정
		String email = "weer13@naver.com";
		String startdate = "2019/04/05";
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
	
	//스케줄 불러오기
	@ResponseBody
	@RequestMapping(value="output", method=RequestMethod.GET, produces="application/json;charset=UTF-8")
	public ArrayList<ScheduleVO> output(HttpSession session, String st, String ed){
		String id =(String) session.getAttribute("loginId");
		
		ScheduleVO vo = new ScheduleVO(id,st,ed);
		
		ArrayList<ScheduleVO> list = dao.getSchedule(vo);

		return list;
	}
	
}
