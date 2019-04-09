package global.sesoc.project1.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class TrafficController {
	public static final Logger logger = LoggerFactory.getLogger(TrafficController.class);
	
	@ResponseBody
	@RequestMapping(value="/trafficTest1", method=RequestMethod.POST,
			produces="application/json;charset=UTF-8")
	public void trafficTest1(String str){
		Gson gson = new Gson();
        JsonParser parser = new JsonParser();
        
        //Json
        JsonObject json = (JsonObject)parser.parse(str);
        
        //맨 처음 {} 벗기기
        Model model = gson.fromJson(json, Model.class);
        
        int count;
        String a1;
        
        Result result = model.result;
        
        //도시 내 이동일 때
        if(result.searchType == 0){    
	        ArrayList<path> path = result.path;
	   
	        for(int i = 0; i < path.size(); i ++){
	        	count = i;
	        	
	        	path p = path.get(i);
	        	
	        	ArrayList<subPath> subpath = p.subPath;
	        	
	        	for(int j = 0; j < subpath.size(); j ++){
	        		subPath s = subpath.get(j);
	        		
	        		JsonObject result1 = (JsonObject)json.get("result");
	        		JsonArray pathh = (JsonArray) result1.get("path");
	        		JsonObject route = (JsonObject) pathh.get(i);
	        		JsonArray subP = (JsonArray) route.get("subPath");
	        		JsonObject route2 = (JsonObject) subP.get(j);
	        		
	        		if(route2.has("lane") == true){
		        		ArrayList<Lane> lane = s.lane;
		        		for(int k = 0; k < lane.size(); k ++){
		        			Lane l = lane.get(k);
			        			a1 = "" +
		        	        		"searchType : " + model.result.searchType + "\n" + 
		        	        		"subwayCount : " + model.result.subwayCount + "\n" + 
		        	        		"busCount : " + model.result.busCount + "\n" + 
		        	        		"outTrafficCheck : " + model.result.outTrafficCheck + "\n" +
		        					"pathType : " + p.pathType + "\n" +
	    			            	"payment : " + p.info.payment + "\n" +
	    			            	"busTransitCount : " + p.info.busTransitCount + "\n" +
	    			            	"subwayTransitCount : " + p.info.subwayTransitCount + "\n" +		
	    			            	"totalStationCount : " + p.info.totalStationCount + "\n" +
	    			            	"totalTime : " + p.info.totalTime + "\n" +
	    			            	"totalWalk : " + p.info.totalWalk + "\n" +
	    			            	"trafficDistance : " + p.info.trafficDistance + "\n" +
	    			            	"totalDistance : " + p.info.totalDistance + "\n" +
		        					"trafficType : " + s.trafficType + "\n" +
		        	        		"distance : " + s.distance + "\n" +
		        	        		"sectionTime : " + s.sectionTime + "\n" +
		        					"startName : " + s.startName + "\n" +
		        	        		"startX : " + s.startX + "\n" +
		        	        		"startY : " + s.startY + "\n" +
		        	        		"endName : " + s.endName + "\n" +
		        	        		"endX : " + s.endX + "\n" +
		        	        		"endY : " + s.endY + "\n" +
		        	        		"busNo : " + l.busNo + "\n" +
		        	        		"name : " + l.name;
		        				logger.debug("count: {}, {}",count, a1);
		        		}
	        		}
	        		
	        		else{
	        			a1 = "" +
	    	        		"searchType : " + model.result.searchType + "\n" + 
	    	        		"subwayCount : " + model.result.subwayCount + "\n" + 
	    	        		"busCount : " + model.result.busCount + "\n" + 
	    	        		"outTrafficCheck : " + model.result.outTrafficCheck + "\n" +
	    					"pathType : " + p.pathType + "\n" +
			            	"payment : " + p.info.payment + "\n" +
			            	"busTransitCount : " + p.info.busTransitCount + "\n" +
			            	"subwayTransitCount : " + p.info.subwayTransitCount + "\n" +		
			            	"totalStationCount : " + p.info.totalStationCount + "\n" +
			            	"totalTime : " + p.info.totalTime + "\n" +
			            	"totalWalk : " + p.info.totalWalk + "\n" +
			            	"trafficDistance : " + p.info.trafficDistance + "\n" +
			            	"totalDistance : " + p.info.totalDistance + "\n" +
	    					"trafficType : " + s.trafficType + "\n" +
	    	        		"distance : " + s.distance + "\n" +
	    	        		"sectionTime : " + s.sectionTime + "\n";
	    				logger.debug("count: {}, {}",count, a1);
	        		}
	        		
	        	}
	        }
        }
        //도시간 이동일 때
        else{            
        	trainRequest trainRequest = result.trainRequest;
        	exBusRequest exBusRequest = result.exBusRequest;
        	outBusRequest outBusRequest = result.outBusRequest;
        	airRequest airRequest = result.airRequest;
    		
        	if(trainRequest.count != 0){
    			ArrayList<OBJ> OBJ = trainRequest.OBJ;
    			for(int i = 0; i < OBJ.size(); i++){
    				a1 = "\n " +
						"startCityName : " + model.result.startCityName + "\n" + 
	            		"endCityName : " + model.result.endCityName + "\n" + 
	            		"totalCount : " + model.result.totalCount + "\n" +
    					"trainStartSTN : " + OBJ.get(i).startSTN + "\n" +
    					"trainSX : " + OBJ.get(i).SX + "\n" +
    					"trainSY : " + OBJ.get(i).SY + "\n" +
    					"trainEndSTN : " + OBJ.get(i).endSTN + "\n" +
    					"trainEX : " + OBJ.get(i).EX + "\n " +
    					"trainEY : " + OBJ.get(i).EY + "\n " +
    					"trainPayment : " + OBJ.get(i).payment + "\n " +
    					"trainTime : " + OBJ.get(i).time;
    				logger.debug(": {}", a1);
    			}
    		}
        	
        	if(exBusRequest.count != 0){
    			ArrayList<OBJ> OBJ = exBusRequest.OBJ;
    			for(int i = 0; i < OBJ.size(); i++){
    				a1 = "\n " +
						"startCityName : " + model.result.startCityName + "\n" + 
	            		"endCityName : " + model.result.endCityName + "\n" + 
	            		"totalCount : " + model.result.totalCount + "\n" +
    					"exBusStartSTN : " + OBJ.get(i).startSTN + "\n" +
    					"exBusSX : " + OBJ.get(i).SX + "\n" +
    					"exBusSY : " + OBJ.get(i).SY + "\n" +
    					"exBusEndSTN : " + OBJ.get(i).endSTN + "\n" +
    					"exBusEX : " + OBJ.get(i).EX + "\n " +
    					"exBusEY : " + OBJ.get(i).EY + "\n " +
    					"exBusPayment : " + OBJ.get(i).payment + "\n " +
    					"exBusTime : " + OBJ.get(i).time; 
    				logger.debug(": {}", a1);
    			}
    		}
        	
        	if(outBusRequest.count != 0){
    			ArrayList<OBJ> OBJ = outBusRequest.OBJ;
    			for(int i = 0; i < OBJ.size(); i++){
    				a1 = "\n " +
						"startCityName : " + model.result.startCityName + "\n" + 
	            		"endCityName : " + model.result.endCityName + "\n" + 
	            		"totalCount : " + model.result.totalCount + "\n" +
    					"outBusStartSTN : " + OBJ.get(i).startSTN + "\n" +
    					"outBusSX : " + OBJ.get(i).SX + "\n" +
    					"outBusSY : " + OBJ.get(i).SY + "\n" +
    					"outBusEndSTN : " + OBJ.get(i).endSTN + "\n" +
    					"outBusEX : " + OBJ.get(i).EX + "\n " +
    					"outBusEY : " + OBJ.get(i).EY + "\n " +
    					"outBusPayment : " + OBJ.get(i).payment + "\n " +
    					"outBusTime : " + OBJ.get(i).time;
    				logger.debug(": {}", a1);
    			}
    		}
        	
        	if(airRequest.count != 0){
    			ArrayList<OBJ> OBJ = airRequest.OBJ;
    			for(int i = 0; i < OBJ.size(); i++){
    				a1 = "\n " +
						"startCityName : " + model.result.startCityName + "\n" + 
	            		"endCityName : " + model.result.endCityName + "\n" + 
	            		"totalCount : " + model.result.totalCount + "\n" +
    					"airStartSTN : " + OBJ.get(i).startSTN + "\n" +
    					"airSX : " + OBJ.get(i).SX + "\n" +
    					"airSY : " + OBJ.get(i).SY + "\n" +
    					"airEndSTN : " + OBJ.get(i).endSTN + "\n" +
    					"airEX : " + OBJ.get(i).EX + "\n " +
    					"airEY : " + OBJ.get(i).EY + "\n " +
    					"airPayment : " + OBJ.get(i).payment + "\n " +
    					"airTime : " + OBJ.get(i).time;
    				logger.debug(": {}", a1);
    			}
    		}
        }        
        return;
	}
	
	class Model{
		Result result;
	}
	
	class Result{
		int searchType;
		
		//시내 대중교통 이용 시 사용할 변수
		ArrayList<path> path;
		int subwayCount;
		int busCount;
		int outTrafficCheck;
	
		//도시간 대중교통 이용 시 사용할 변수
		String startCityName; // 출발지 도시 이름
		String endCityName; // 도착지 도시 이름
		int totalCount; // 총 결과 개수
		trainRequest trainRequest; // 기차 관련
		exBusRequest exBusRequest; // 고속버스 관련
		outBusRequest outBusRequest; // 시외버스 관련
		airRequest airRequest; // 항공 관련
		
	}
	
	class path{
		int pathType;
		ArrayList<subPath> subPath;
		Info info;
	}
	
	class subPath{
		int trafficType;
		double distance;
		int sectionTime;
		ArrayList<Lane> lane = null;
		String startName;
		double startX;
		double startY;
		String endName;
		double endX;
		double endY;
	}
	
	class Lane{
		String busNo = null;
		String name = null;
	}
	
	class Info{
		int payment;
		int busTransitCount;
		int subwayTransitCount;
		int totalStationCount;
		int totalTime;
		int totalWalk;
		double trafficDistance;
		double totalDistance;
	}
	
	//도시간 이동시 사용하는 클래스
	class trainRequest{
		int count;
		ArrayList<OBJ> OBJ;
	}
	
	class exBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
	}
	
	class outBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
	}
	
	class airRequest{
		int count;
		ArrayList<OBJ> OBJ;
	}
	
	class OBJ{
		String startSTN; // 출발터미널
		double SX; // 출발x좌표
		double SY; // 출발y좌표 
		String endSTN; // 도착 터미널
		double EX; // 도착x좌표
		double EY; // 도착y좌표
		int payment; // 가격
		int time; // 시간
	}
}