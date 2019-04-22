package global.sesoc.www.weathericon;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class weathericon {

	final Logger logger = LoggerFactory.getLogger(weathericon.class);
	
	//해 페이지로 이동
		@RequestMapping(value="sunicon", method=RequestMethod.GET)
		public String sunicon(){
			return "weather_icon/sun";
		}
		
	//비 페이지로 이동
			@RequestMapping(value="rainicon", method=RequestMethod.GET)
			public String rainicon(){
				return "weather_icon/rain";
			}
	
	
			//흐림 페이지로 이동
			@RequestMapping(value="cloudyicon", method=RequestMethod.GET)
			public String cloudyicon(){
				return "weather_icon/cloudy";
			}
			
			
			//눈 페이지로 이동
			@RequestMapping(value="snowicon", method=RequestMethod.GET)
			public String snowicon(){
				return "weather_icon/snow";
			}
			
			
			//폭설 페이지로 이동
			@RequestMapping(value="flurriesicon", method=RequestMethod.GET)
			public String flurriesicon(){
				return "weather_icon/flurries";
			}
			
			
			//황사 페이지로 이동
			@RequestMapping(value="sandicon", method=RequestMethod.GET)
			public String sandicon(){
				return "weather_icon/sand";
			}
			
			
			//폭우 페이지로 이동
			@RequestMapping(value="stormicon", method=RequestMethod.GET)
			public String stormicon(){
				return "weather_icon/storm";
			}
			
			//천둥 페이지로 이동
			@RequestMapping(value="thundericon", method=RequestMethod.GET)
			public String thundericon(){
				return "weather_icon/thunder";
			}
			
			
}
