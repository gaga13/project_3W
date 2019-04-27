package global.sesoc.www.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import global.sesoc.www.vo.NewsVO;

@Controller
public class NewsController {
	private final static Logger logger = LoggerFactory.getLogger(NewsController.class);
	
	@RequestMapping(value="getNews", method=RequestMethod.GET)
	public String getNews(){
		return "news";
	}
	
	//네이버 뉴스
	@ResponseBody
	@RequestMapping(value="news", method=RequestMethod.POST, produces="application/json;charset=UTF-8")
	public List<NewsVO> output(Model model, HttpSession session){
		int n = 0;
		String keywr[] ={"사망","사고","사건","주의","피해","살인","아동","인명","자연재해","화재","홍수","안전","소방","경찰"}; 
		String res = null;
		SimpleDateFormat oldFormat = new SimpleDateFormat("EEE, dd MMM yyyy HH:mm:ss Z", Locale.US);
		SimpleDateFormat newFormat = new SimpleDateFormat("yyyy년 MM월 dd일");

		String clientId = "SXuDuY9peRkbfT9sVQeo";//애플리케이션 클라이언트 아이디값";
		String clientSecret = "12Y2ZWzXru";//애플리케이션 클라이언트 시크릿값";
		String local = session.getAttribute("location").toString();
		try {
			String text = URLEncoder.encode(local, "UTF-8");
			String apiURL = "https://openapi.naver.com/v1/search/news.json?query="+ text+"&display=20&start=1&sort=date"; // json 결과
			//String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // xml 결과
			
			URL url = new URL(apiURL);
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			con.setRequestProperty("X-Naver-Client-Id", clientId);
			con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
			int responseCode = con.getResponseCode();
			BufferedReader br;
			if(responseCode==200) { // 정상 호출
				br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {  // 에러 발생
				br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = br.readLine()) != null) {
				response.append(inputLine);
			}
			br.close();
			res = response.toString();
			
		} catch (Exception e) {
			System.out.println(e);
		}
		
		//json의 VO클래스 객체화
		Gson gson = new Gson();
		JsonParser parser = new JsonParser();
		JsonElement items = parser.parse(res).getAsJsonObject().get("items");
		NewsVO[] news = gson.fromJson(items,NewsVO[].class);
		ArrayList<NewsVO> list = new ArrayList<NewsVO>(Arrays.asList(news));
		
		//중복된 기사 삭제
		for(n=0; n<list.size();n++){
			for(int a = 1; a<n;a++){
				if( n!=a && list.get(n).getTitle().compareTo(list.get(a).getTitle()) == 0|| list.get(a).getTitle().length()<10){
					list.remove(a);
				}
			}
		}
		//\로 나오는 부분 변경& 키워드를 통한 정렬 
		for(n = list.size()-1 ; n>0 ;n--){
			for(int m = 0 ; m<keywr.length-1;m++){
				if(list.get(n).getTitle().contains(keywr[m])){
					NewsVO vo = list.get(n);
					list.remove(n);
					list.add(0, vo);
				}
				if(list.get(n).getTitle().contains("\\")){
				list.get(n).setTitle(list.get(n).getTitle().replace("\\", ""));	
				}
			}
		}
				
		
		//Date포맷
		for(int i = 0 ; i<list.size();i++){
			try{
				Date parseDate = oldFormat.parse(list.get(i).getPubDate());
				String date = newFormat.format(parseDate);
				list.get(i).setPubDate(date);
			}catch(Exception e){
				e.printStackTrace();
			}//catch       
		}//반복문

		
		return list;
	}
}
