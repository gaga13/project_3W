package global.sesoc.www.PageController;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageController {
	
	private static final Logger logger = LoggerFactory.getLogger(PageController.class);
	
	
	//한달 캘린더 페이지로 이동
	@RequestMapping(value="calendar", method=RequestMethod.GET)
	public String calendar(){
		return "Mcalendar";
	}
	
	//날씨 페이지로 이동
	@RequestMapping(value="weather", method=RequestMethod.GET)
	public String weather(){
		return "weatherData/weatherTest2";
	}

	
	//뉴스 페이지로 이동
	@RequestMapping(value="news", method=RequestMethod.GET)
	public String news(){
		return "news";
	}
	
	//회원정보 수정 페이지로 이동
	@RequestMapping(value="user", method=RequestMethod.GET)
	public String user(){
		return "Uprofil";
	}
	
	//회원정보 수정 페이지로 이동
		@RequestMapping(value="scheduleplus", method=RequestMethod.GET)
		public String schedule_plus(){
			return "schedule";
		}

	@RequestMapping(value="home", method=RequestMethod.GET)
	public String home(){
		return "home";
	}

	
}
