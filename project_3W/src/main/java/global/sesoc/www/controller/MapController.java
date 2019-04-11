package global.sesoc.www.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class MapController {
	public static final Logger logger = LoggerFactory.getLogger(MapController.class);
	
	//로그인 창 들어갔을 때, 자동으로 현재 위치의 좌표 저장
	@ResponseBody
	@RequestMapping(value="/loginLocation", method=RequestMethod.POST)
	public void loginLocation(double lat, double lon, HttpSession session){
		session.setAttribute("loginLon", lon);
		session.setAttribute("loginLat", lat);
		return;
	}
	
	//홈화면에서 편의시설 등 보여줄 맵(카카오맵)
	@RequestMapping(value="/mapBasic", method=RequestMethod.GET)
	public String mapBasic(){
		return "map/map_basic";
	}
}
