package global.sesoc.www.controller;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

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
	public void trafficTest1(String str, Model model){
		//넘어오는 정보
		logger.debug("{}",str);
		//gson
		Gson gson = new Gson();
        JsonParser parser = new JsonParser();
        
        //Json
        JsonObject json = (JsonObject)parser.parse(str);
        
        //맨 처음 {} 벗기기
        PubPath pb = gson.fromJson(json, PubPath.class);
        
        //리스트들
		ArrayList<subPath> s = new ArrayList<>(); 
		ArrayList<OBJ> OBJ = new ArrayList<>();
		ArrayList<path> path = new ArrayList<>();
		subPath[][] pathar = null;
        int count = 0;
        
        Result result = pb.result;
        
        logger.debug("결과값:{}", result.totalCount);
        try{
        	
        	if(result.path != null){
        		pathar = new subPath[result.path.size()][];
        	}

        //도시 내 이동일 때
        	if(result.searchType == 0){    
        		path= result.path;
	        
        		logger.debug("반복문 전에 path사이즈:{}", path.size());
        		for(int i = 0; i < path.size(); i ++){
	        	
        			count = i;
	        	
        			path p = path.get(i);
	        	
        			ArrayList<subPath> subpath = p.subPath;
        			pathar[i]= new subPath[subpath.size()];
        			
        			for(int j = 0; j < subpath.size(); j ++){
        				pathar[i][j] = subpath.get(j);
        				s.add(subpath.get(j));
	        		
        				JsonObject result1 = (JsonObject)json.get("result");
        				JsonArray pathh = (JsonArray) result1.get("path");
        				JsonObject route = (JsonObject) pathh.get(i);
        				JsonArray subP = (JsonArray) route.get("subPath");
        				JsonObject route2 = (JsonObject) subP.get(j);
	        			
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
        			logger.debug("기차 들림");
        			OBJ.addAll(trainRequest.OBJ);
        		}
        	
        		if(exBusRequest.count != 0){
        			logger.debug("버스 들림");
        			OBJ.addAll(exBusRequest.OBJ);

        		}
        	
        		if(outBusRequest.count != 0){
        			logger.debug("아웃버스 들림");
        			OBJ.addAll(outBusRequest.OBJ);
        		}
        	
        		if(airRequest.count != 0){
        			logger.debug("비행기 들림");
        			OBJ.addAll(airRequest.OBJ);
        		}
        	}

        	if(pathar!= null){
        		for(int i=0 ; i<pathar.length;i++){
        			logger.debug(i+"번째"+"path{}", path.get(i));
        			logger.debug("가격:{}", path.get(i).info.payment);
        			logger.debug("도착시간:{}", path.get(i).info.totalTime);
        			logger.debug("출발정류장:{}", path.get(i).info.firstStartStation);
        			logger.debug("도착정류장:{}", path.get(i).info.lastEndStation);
        			logger.debug("도보:{}", path.get(i).info.totalWalk);
        			logger.debug("환승여부- 버스:{}, 지하철:{}", path.get(i).info.busTransitCount, path.get(i).info.subwayTransitCount);
        	
        			for(int j=0; j<pathar[i].length;j++){
        				System.out.println("j값"+j);
        				
        				if(pathar[i][j].lane == null){
        					logger.debug("도보");
        				}else if(pathar[i][j].lane.get(0).busNo != null){
        					logger.debug(i+"행"+j+"열 버스:{}", pathar[i][j].lane.get(0).busNo);
            	
        				}else if(pathar[i][j].lane.get(0).name !=null){
        					logger.debug(i+"행"+j+"열 지하철:{}", pathar[i][j].lane.get(0).name);
        				}
        			}
        		}
        		model.addAttribute("subpath", pathar);
        	}else if(OBJ != null){
        	logger.debug("obj크기:{}", OBJ.size());
        	for(int k =0;  k<OBJ.size();k++){	
        		logger.debug(k+"번째 시외 정보:{}", OBJ.get(k));
        	}
        	model.addAttribute("obj",OBJ);
        	}
        }catch(NullPointerException n){
        	n.printStackTrace();
        }
        return;
	}
	
	class PubPath{
		Result result;

		@Override
		public String toString() {
			return "PubPath [result=" + result + "]";
		}
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
	
		@Override
		public String toString() {
			return "Result [searchType=" + searchType + ", path=" + path + ", subwayCount=" + subwayCount
					+ ", busCount=" + busCount + ", outTrafficCheck=" + outTrafficCheck + ", startCityName="
					+ startCityName + ", endCityName=" + endCityName + ", totalCount=" + totalCount + ", trainRequest="
					+ trainRequest + ", exBusRequest=" + exBusRequest + ", outBusRequest=" + outBusRequest
					+ ", airRequest=" + airRequest + "]";
		}	
		
	}
	
	class path{
		int pathType;
		ArrayList<subPath> subPath;
		Info info;
		
		@Override
		public String toString() {
			return "path [pathType=" + pathType + ", subPath=" + subPath + ", info=" + info + "]";
		}
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
		
		@Override
		public String toString() {
			return "subPath [trafficType=" + trafficType + ", distance=" + distance + ", sectionTime=" + sectionTime
					+ ", lane=" + lane + ", startName=" + startName + ", startX=" + startX + ", startY=" + startY
					+ ", endName=" + endName + ", endX=" + endX + ", endY=" + endY + "]";
		}
		
	}
	
	class Lane{
		String busNo = null;
		String name = null;
		
		@Override
		public String toString() {
			return "Lane [busNo=" + busNo + ", name=" + name + "]";
		}
	}
	
	class Info{
		int payment;
		int busTransitCount;
		int subwayTransitCount;
		int totalStationCount;
		int totalTime;
		int totalWalk;
		String firstStartStation;
		String lastEndStation;
		double trafficDistance;
		double totalDistance;
		
		@Override
		public String toString() {
			return "Info [payment=" + payment + ", busTransitCount=" + busTransitCount + ", subwayTransitCount="
					+ subwayTransitCount + ", totalStationCount=" + totalStationCount + ", totalTime=" + totalTime
					+ ", totalWalk=" + totalWalk + ", firstStartStation=" + firstStartStation + ", lastEndStation="
					+ lastEndStation + ", trafficDistance=" + trafficDistance + ", totalDistance=" + totalDistance
					+ "]";
		}
		
	}
	
	//도시간 이동시 사용하는 클래스
	class trainRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		@Override	
		public String toString() {
			return "trainRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	class exBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		@Override	
		public String toString() {
			return "exBusRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	class outBusRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		@Override
		public String toString() {
			return "outBusRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
		
	}
	
	class airRequest{
		int count;
		ArrayList<OBJ> OBJ;
		
		@Override
		public String toString() {
			return "airRequest [count=" + count + ", OBJ=" + OBJ + "]";
		}
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
		
		@Override
		public String toString() {
			return "OBJ [startSTN=" + startSTN + ", SX=" + SX + ", SY=" + SY + ", endSTN=" + endSTN + ", EX=" + EX
					+ ", EY=" + EY + ", payment=" + payment + ", time=" + time + "]";
		}
		
	}
}