package global.sesoc.project1.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class MapController {
	
	@RequestMapping(value="/locationTest", method=RequestMethod.GET)
	public String location(){
		return "locationTest";
	}
	
	@RequestMapping(value="/mapTest3", method=RequestMethod.GET)
	public String map3(){
		return "mapTest3";
	}
	
	@RequestMapping(value="/mapTest4", method=RequestMethod.GET)
	public String map4(){
		return "mapTest4";
	}
	
	@RequestMapping(value="/mapTest5", method=RequestMethod.GET)
	public String map5(){
		return "mapTest5";
	}
	
	@RequestMapping(value="/mapTest7", method=RequestMethod.GET)
	public String map7(){
		return "mapTest7";
	}
	
	@RequestMapping(value="/mapTest8", method=RequestMethod.GET)
	public String map8(){
		return "mapTest8";
	}
}
