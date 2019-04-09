package global.sesoc.project1.controller;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class weatherController {
	public static final Logger logger = LoggerFactory.getLogger(weatherController.class);
	
	@RequestMapping(value="/weather", method=RequestMethod.GET)
	public String weather(Model model){
		return "weatherTest";
	}
	
	@RequestMapping(value="/weather2", method=RequestMethod.GET)
	public String weather2(Model model){
		return "weatherTest2";
	}
	
	@RequestMapping(value="/sessionSave", method=RequestMethod.GET)
	public String sessionSave(){
		return "sessionSave";
	}
	
	//session에 위도(lat), 경도(lng) 저장하기 위해 사용.
	@RequestMapping(value="/locationSave", method=RequestMethod.POST)
	public String locationSave(HttpSession session,double lat, double lng){
		session.setAttribute("lat", lat);
		session.setAttribute("lng", lng);
		return "redirect:/";
	}
	
	@RequestMapping(value="split", method=RequestMethod.POST)
	public void split(String loc, HttpSession session){
		String ar[] = loc.split("\n");
		String lat = ar[1].substring(4);
		String lng = ar[2].substring(4);
		session.setAttribute("lat", lat);
		session.setAttribute("lng", lng);
		return;
	}
	
	@RequestMapping(value="/weather3", method=RequestMethod.GET)
	public String weather3(){
		return "weatherTest3";
	}
	
	//translate
	@RequestMapping(value = "/translate", method=RequestMethod.GET)
	public void translate(HttpSession session){
		String clientId = "ibvum1Y0Dx5JXH1pXGDp";
        String clientSecret = "4Bwp4Jf6Cg";
        String country = (String)session.getAttribute("country") + " " + (String)session.getAttribute("region");
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
            String[] aa = response.toString().split(":");
            String[] aaa = aa[8].split(",");
            String b = aaa[0].replaceAll("\"", "");
            String bb = aaa[1].replaceAll("\"}}}", "");
            b = b.replaceAll(" ", "");
            
            String country2 = b + bb;
            
            session.setAttribute("country2", country2);
            
        } catch (Exception e) {
            logger.debug(e.toString());
        }
        return;
	}
}
