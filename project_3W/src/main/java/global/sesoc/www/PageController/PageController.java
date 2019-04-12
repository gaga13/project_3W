package global.sesoc.www.PageController;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class PageController {
	
	//한달 캘린더 페이지로 이동
	@RequestMapping(value="calendar", method=RequestMethod.GET)
	public String calendar(){
		return "Mcalendar";
	}
	
	//날씨 페이지로 이동
	@RequestMapping(value="weather", method=RequestMethod.GET)
	public String weather(){
		return "weather";
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

	@RequestMapping(value="home", method=RequestMethod.GET)
	public String home(){
		return "home";
	}
	//캐릭터 시범페이지
	@RequestMapping(value="cha", method=RequestMethod.GET)
	public String cha(){
		return "charac";
	}
}