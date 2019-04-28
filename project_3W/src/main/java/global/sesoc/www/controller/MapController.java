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
		session.setAttribute("lon", lon);
		session.setAttribute("lat", lat);
		return;
	}
	
	@ResponseBody
	@RequestMapping(value="/reverseGeoCording", method=RequestMethod.POST)
	public void reverseGeoCording(String loca, HttpSession session){
		session.setAttribute("location", loca);
		logger.debug("loca:{}", loca);
		return;
	}
	
	//홈화면에서 편의시설 등 보여줄 맵(카카오맵)
	@RequestMapping(value="/map_Basic", method=RequestMethod.GET)
	public String mapBasic(){
		return "map/map_basic";
	}
	
	//맵에서 한 장소 검색하기
	@RequestMapping(value="/map_Search", method=RequestMethod.GET)
	public String mapSearch(){
		return "map/map_Search";
	}
	
	//검색해서 자동차 길찾기
	@RequestMapping(value="/map_SearchRoute", method=RequestMethod.GET)
	public String mapSearchRoute(){
		return "map/map_SearchRoute";
	}
	
	//main맵 jsp호출
	@RequestMapping(value="/map_Main", method=RequestMethod.GET)
	public String mapMain(){
		return "map/map_Main";
	}
	
	//map_Total 호출
	@RequestMapping(value="/mapTest3", method=RequestMethod.GET)
	public String mapTest3(){
		return "map/mapTest3";
	}
	
	@ResponseBody
	@RequestMapping(value="/setSession", method=RequestMethod.POST)
	public void setSession(String searchLocation, String searchLocationLat
			, String searchLocationLon, HttpSession ses){
		
		ses.setAttribute("searchLocation", searchLocation);
		ses.setAttribute("searchLocationLat", searchLocationLat);
		ses.setAttribute("searchLocationLon", searchLocationLon);
		
	}
}
