package global.sesoc.www.PageController;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageController {
	
	private static final Logger logger = LoggerFactory.getLogger(PageController.class);
	
	
	//한달 캘린더 페이지로 이동
	@RequestMapping(value="calendar", method=RequestMethod.GET)
	public String calendar(HttpSession session){
		session.removeAttribute("searchLocation");
		session.removeAttribute("searchLocationLat");
		session.removeAttribute("searchLocationLon");
		return "Mcalendar";
	}
	
	//날씨 페이지로 이동
	@RequestMapping(value="weather", method=RequestMethod.GET)
	public String weather(){
		return "weather_view";
	}

	//뉴스 페이지로 이동
	@RequestMapping(value="news", method=RequestMethod.GET)
	public String news(HttpSession session){
		session.removeAttribute("searchLocation");
		session.removeAttribute("searchLocationLat");
		session.removeAttribute("searchLocationLon");
		return "news";
	}
	

	//하루일정 입력 페이지로 이동
	@RequestMapping(value="scheduleplus", method=RequestMethod.GET)
	public String schedule_plus(HttpSession session){
		session.removeAttribute("searchLocation");
		session.removeAttribute("searchLocationLat");
		session.removeAttribute("searchLocationLon");
		return "schedule";
	}

	//메뉴테스트 페이지로 이동
	@RequestMapping(value="menutest", method=RequestMethod.GET)
	public String menu(){
		return "menutest";
	}

	@RequestMapping(value="home", method=RequestMethod.GET)
	public String home(HttpSession session, Model model){
		String day =(String) session.getAttribute("sysdate");
		logger.debug("home:{}", day);
		String days[] = day.split("/");
		
		model.addAttribute("oneyear", days[0]);
		model.addAttribute("onedays", days[1]+"/"+days[2]);
		return "home";
	}

	
}
