package global.sesoc.www.controller;


import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import global.sesoc.www.vo.OBJ;
import global.sesoc.www.vo.Result;
import global.sesoc.www.vo.path;

@Controller
public class MapTrafficController {
	public static final Logger logger = LoggerFactory.getLogger(MapTrafficController.class);
	
	@RequestMapping(value="/map_Traffic", method=RequestMethod.GET)
	public String Map_Traffic(){
		return "map/map_Traffic";
	}
	
	@RequestMapping(value="/map_SearchTraffic", method=RequestMethod.GET)
	public String map_SearchTraffic(){
		return "map/map_SearchTraffic";
	}
	
	@ResponseBody
	@RequestMapping(value="/traffic", method=RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	public Object trafficTest1(String str, Model model){
		ArrayList<OBJ> obj = new ArrayList<>();
		ArrayList<path> path_list = new ArrayList<>();
		//넘어오는 정보
		logger.debug("{}",str);
		//gson 
		Gson gson = new Gson();
        JsonParser parser = new JsonParser();
    
        //Json
        JsonObject json = (JsonObject)parser.parse(str);
       
        Result result = gson.fromJson(json.get("result"), Result.class);
        
        
        try{
            if(result.getSearchType()==0){
            	path_list.addAll(result.getPath());
            	DescendingPath path_sort = new DescendingPath();
                Collections.sort(path_list, path_sort);
                result.getPath().addAll(path_list);
                return result;
            }
            else{
        	DescendingObj descending = new DescendingObj();
        	if(result.getAirRequest().getCount() != 0){
        		Collections.sort(result.getAirRequest().getOBJ(), descending);
        		obj.add(result.getAirRequest().getOBJ().get(0));
        	}
        	
        	if(result.getTrainRequest().getCount() != 0){
        		Collections.sort(result.getTrainRequest().getOBJ(), descending);
        		obj.add(result.getTrainRequest().getOBJ().get(0));
        	}
        	
        	if(result.getExBusRequest().getCount() != 0){
        		Collections.sort(result.getExBusRequest().getOBJ(), descending);
        		obj.add(result.getExBusRequest().getOBJ().get(0));
        	}
        	
        	if(result.getOutBusRequest().getCount() != 0){
        		Collections.sort(result.getOutBusRequest().getOBJ(), descending);
        		obj.add(result.getOutBusRequest().getOBJ().get(0));
        	}
        	
        	Collections.sort(obj, descending);
        	}
        }catch(Exception e){
        	e.printStackTrace();
        }
        
        return obj;
	 }

}

class DescendingObj implements Comparator<OBJ> {
	 
    @Override
    public int compare(OBJ o1, OBJ o2) {
    	if(o1.getTime() > o2.getTime()){
    		return 1;
    	}else if(o1.getTime() < o2.getTime()){
    		return -1;
    	}else
        return 0;
    }
}


class DescendingPath implements Comparator<path> {
	 
    @Override
    public int compare(path p1, path p2) {
    	if(p1.getInfo().getTotalTime() > p2.getInfo().getTotalTime()){
    		return 1;
    	}else if(p1.getInfo().getTotalTime() < p2.getInfo().getTotalTime()){
    		return -1;
    	}else
        return 0;
    }
}