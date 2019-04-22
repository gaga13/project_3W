package global.sesoc.www.controller;

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
public class PracticeController {

	private static final Logger logger = LoggerFactory.getLogger(PracticeController.class);
		
	@Autowired
	ScheduleDAO sdao;
	
	// 맵 연습용
	@RequestMapping(value="/mapTest", method=RequestMethod.GET)
	public String mapTest(){
		return "map/mapTest";
	}
	//맵 연습용2
	@RequestMapping(value="/mapTest2", method=RequestMethod.GET)
	public String mapTest2(){
		return "map/mapTest2";
	}
	//맵 연습용3
	@RequestMapping(value="/mapTest3", method=RequestMethod.GET)
	public String mapTest3(){
		return "map/mapTest3";
	}
	
	
	//ScheduleController에 추가
		@ResponseBody
		@RequestMapping(value="/getSchedule", method = RequestMethod.GET)
		public ScheduleVO getSchedule(int snum){
			ScheduleVO vo = sdao.getSchedule(snum);
			logger.debug("vo:{}", vo);
			return vo;
		}
}
