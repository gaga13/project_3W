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
	
	@ResponseBody
	@RequestMapping(value="/loginLocation", method=RequestMethod.POST)
	public void loginLocation(double lat, double lon, HttpSession session){
		session.setAttribute("loginLon", lon);
		session.setAttribute("loginLat", lat);
		return;
	}
}
