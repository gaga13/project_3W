package global.sesoc.www.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Controller
public class WeatherController {

	public static final Logger logger = LoggerFactory.getLogger(WeatherController.class);
	
	@RequestMapping(value = "weather_RealTime", method = RequestMethod.GET)
	public String weather_RealTime(){
		return "weather/weather_RealTime";
	}
	
	@RequestMapping(value = "weather_5Days", method = RequestMethod.GET)
	public String weather_5Days(){
		return "weather/weather_5Days";
	}
	
	@RequestMapping(value = "weather_Search", method = RequestMethod.GET)
	public String weather_Search(){
		return "weather/weather_Search";
	}
	
	//translate
	@ResponseBody
	@RequestMapping(value = "/translate", method=RequestMethod.GET)
	public String translate(String country, HttpSession session){
		session.setAttribute("searchLocation", country);
		String save = null;
		String clientId = "ibvum1Y0Dx5JXH1pXGDp";
        String clientSecret = "4Bwp4Jf6Cg";
        try {
            String text = URLEncoder.encode(country, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            // post request
            String postParams = "source=ko&target=en&text=" + text;
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close();
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { 
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            //파싱
            Gson gson = new Gson();
            JsonParser parser = new JsonParser();
            JsonObject json = (JsonObject)parser.parse(response.toString());
            Model model = gson.fromJson(json, Model.class);            
            save = model.message.result.translatedText;
        } catch (Exception e) {
            logger.debug(e.toString());
        }
        return save;
	}
	
	class Model{
		Message message;
	}
	
	class Message{
		Result result;
	}
	
	class Result{
		String translatedText;
	}
	
	//지역명 -> 좌표 변환
	@ResponseBody
	@RequestMapping(value="split", method=RequestMethod.POST)
	public  HashMap<String, Object> split(String loc, HttpSession session){
		String ar[] = loc.split("\n");
		String lat = ar[1].substring(4);
		String lng = ar[2].substring(4);
		
		HashMap<String,Object> map=new HashMap<>();
		map.put("lat", lat);
		map.put("lng", lng);
		
		return map;
	}

	@ResponseBody
	@RequestMapping(value="searchLocationSave", method=RequestMethod.POST)
	public void searchLocationSave(String loc, HttpSession session){
		String ar[] = loc.split("\n");
		String lat = ar[1].substring(4);
		String lon = ar[2].substring(4);
		
		session.setAttribute("searchLocationLat", lat);
		session.setAttribute("searchLocationLon", lon);
		
		return;
	}
}