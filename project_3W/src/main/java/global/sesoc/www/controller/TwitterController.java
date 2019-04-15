package global.sesoc.www.controller;

import java.io.ByteArrayInputStream;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import global.sesoc.www.dao.ScheduleDAO;
import global.sesoc.www.dao.TwitterDAO;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterException;
import twitter4j.TwitterFactory;
import twitter4j.auth.AccessToken;
import twitter4j.auth.RequestToken;
@Controller
public class TwitterController {
	
	private static final Logger logger = LoggerFactory.getLogger(TwitterController.class);

	static final private String APIkey = "RKEc3Gv79XfuYj9kBxHCdGtV6";
	static final private String APIsecretKey = "0ZMBgZLVyyKAziAGjobSwkOYOFWM312R21ZoacU3lCseykCrgI";
	
	@Autowired
	TwitterDAO dao;
	
	//연습용 pp.jsp 경로
	@RequestMapping(value = "pp", method = RequestMethod.GET)
	public String pp(HttpSession ses){
		//연습용 schedule
		String scontent = "새라 언니랑 밥 먹기";
		String slocation = "쿠우쿠우";
		String startdate = "오후 1시";
		
		ses.setAttribute("scontent", scontent);
		ses.setAttribute("slocation", slocation);
		ses.setAttribute("startdate", startdate);
	
		return "Gahyun/pp";
	}
	
	//트위터 공유하기 버튼 눌렀을 때, 인증된 사용자인지 체크
	@ResponseBody
	@RequestMapping(value = "twitterTokenCheck", method = RequestMethod.GET)
	public boolean twitterTokenCheck(HttpSession ses){
		boolean check = false;
		
		String email = (String) ses.getAttribute("loginId");
		
		//db에서 해당 email의 accessToken 가져오기
		byte[] serializedAccessToken = null;
		HashMap<String, Object> hmap = new HashMap<>();
		hmap = dao.selectAccessToken(email);
		logger.debug("hmap:{}", hmap);
		try {
			serializedAccessToken = (byte[]) hmap.get("blobData");
			logger.debug("token가져오기 성공");
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(serializedAccessToken == null){
			return check;
		}
	
		check = true;
		try (ByteArrayInputStream bais = new ByteArrayInputStream(serializedAccessToken)) {
		    try (ObjectInputStream ois = new ObjectInputStream(bais)) {
	            // 역직렬화된 accessToken 객체를 읽어온다.
	            Object objectAccToken = ois.readObject();
	            AccessToken accessToken =  (AccessToken) objectAccToken;
	            
	            //session에 accessToken 저장
	            ses.setAttribute("accessToken", accessToken);
	            logger.debug("세션에 accessToken 저장");
		    }
		    catch(Exception e){
		    	e.printStackTrace();
		    }
		}
		catch(Exception e){
			e.printStackTrace();
		}
		
		
		return check;
	}
	
	//트위터 계정 인증 페이지 오픈
	@RequestMapping(value = "twitterConnect", method = RequestMethod.GET)
	public void twitterConnect(HttpServletRequest request, HttpServletResponse response)
	throws TwitterException, IOException{
		
		Twitter twitter = new TwitterFactory().getInstance();	
		twitter.setOAuthConsumer(APIkey, APIsecretKey);					//트위터에게서 받은 API key, API secretKey
		RequestToken requestToken = twitter.getOAuthRequestToken();		//내쪽에서 requestToken 생성
		
		logger.debug("requestToken:{}",requestToken);
		
		request.getSession().setAttribute("ReqToken", requestToken); 	//요청 토큰 정보 세션에 구움
		response.sendRedirect(requestToken.getAuthorizationURL()); 		//인증 페이지로 이동시킴
	}
	
	//트위터 계정 인증
	@RequestMapping(value = "twitterAccess", method = RequestMethod.GET)
	public String twitterAccess(HttpServletRequest request, HttpSession ses,
			 HttpServletResponse response) 
			throws TwitterException, IOException{
		
		logger.debug("트위터 인증");
		int result = 0;
		String email = (String) ses.getAttribute("loginId");
		Twitter twitter = new TwitterFactory().getInstance();
		twitter.setOAuthConsumer(APIkey, APIsecretKey);
		
		AccessToken accessToken = null;
		
		//트위터에서 보내준 oauthToken, oauthVerifier 
		String oauthToken = request.getParameter("oauth_token");		//요청 토큰 일치여부 확인을 위한 token key
		String oauthVerifier = request.getParameter("oauth_verifier");	//인증검증 key
		
		RequestToken reqToken = (RequestToken)request.getSession().getAttribute("ReqToken"); //위에서 세션 저장한 요청 토큰 정보
		
		//트위터 인증 시도
		if(reqToken.getToken().equals(oauthToken)){
			try{
				accessToken = twitter.getOAuthAccessToken(reqToken, oauthVerifier);//검증
				twitter.setOAuthAccessToken(accessToken); //인증정보 저장

				logger.debug("1accToken:{}", accessToken);
				ses.setAttribute("accessToken", accessToken);
				logger.debug("트위터 인증성공");
				
			}
			catch (TwitterException e){
				e.printStackTrace();
				//트위터 인증 실패
			}
		}
		
		//DB에 accessToken저장하기
		byte[] serializedAccessToken;
	
        HashMap<String, Object> hmap = new HashMap<String, Object>();
        
        //accessToken 을 binary data로 바꿔서 byte[]에 넣기, byte[]를 mapper에 넣어 저장
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            try (ObjectOutputStream oos = new ObjectOutputStream(baos)) {
                oos.writeObject(accessToken);
             // serializedMember -> 직렬화된 accessToken 객체 
                serializedAccessToken = baos.toByteArray();
            }
            
            hmap.put("accessToken", serializedAccessToken);
            hmap.put("loginEmail", email);
            result = dao.insertAccessToken(hmap);
            if(result == 1){ logger.debug("db에 토큰 저장 성공");}
        }
        catch(Exception e){
        	e.printStackTrace();
        }
								
		return "redirect:pp";
	}

	//트윗하는 페이지 jsp 경로
	@RequestMapping(value="twitterWrite", method=RequestMethod.GET)
	public String twitterWriteOpen(){
		return "Gahyun/twitterPractice";
	}
		
	//트윗하는 기능		//twitt : 트윗 할 내용이 담김
	@RequestMapping(value="twitterWrite" , method = RequestMethod.POST)
	public String twitterWrite( HttpSession ses, 
			String twitt, HttpServletRequest request) throws TwitterException{
		
		
		logger.debug("twitt:{}", twitt );
		Twitter twitter = new TwitterFactory().getInstance();
		
		AccessToken accessToken = (AccessToken) ses.getAttribute("accessToken");
		
		twitter.setOAuthConsumer(APIkey, APIsecretKey);
		twitter.setOAuthAccessToken(accessToken);
		   
		try{
			
			Status status = twitter.updateStatus(twitt); 		//괄호안의 내용 포스팅함
			logger.debug("twitter update success");
			
		} catch(TwitterException te){
			if(401 == te.getStatusCode()){
				//unable to get the access token
			} else{
				te.printStackTrace();
			}
		}
		return "Main";
	}
	
	/*//accessToken db에 저장하기
	@RequestMapping(value = "InsertAcc", method=RequestMethod.GET)
	public String serial(HttpSession ses){
		
		
		String id = "nghyun13@gmail.com";
		AccessToken accessToken = (AccessToken) ses.getAttribute("accessToken");
		byte[] serializedAccessToken;
		
		
	        HashMap<String, Object> hmap = new HashMap<String, Object>();
	        //accessToken 을 binary data로 바꿔서 byte[]에 넣기, byte[]를 mapper에 넣어 저장
	        
	        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
	            try (ObjectOutputStream oos = new ObjectOutputStream(baos)) {
	                oos.writeObject(accessToken);
	             // serializedMember -> 직렬화된 accessToken 객체 
	                serializedAccessToken = baos.toByteArray();
	            }
	            
	            hmap.put("accessToken", serializedAccessToken);
	            dao.insertAccessToken(hmap);
	        }
	        catch(Exception e){
	        	e.printStackTrace();
	        }
	      
		return "home";
	}
	
	//DB에서 token 불러오기
	@RequestMapping(value = "getAcc", method=RequestMethod.GET)
	public String getAcc(HttpSession ses){
		
		String id = "a";
		byte[] serializedAccessToken;
		HashMap<String, Object> hmap = new HashMap<>();
		hmap = dao.selectAccessToken(id);
		
		serializedAccessToken = (byte[]) hmap.get("blobData");
		
		logger.debug("hmap:{}", hmap);
		logger.debug("serial:{}", serializedAccessToken);
		
		
	   
	    try (ByteArrayInputStream bais = new ByteArrayInputStream(serializedAccessToken)) {
	        try (ObjectInputStream ois = new ObjectInputStream(bais)) {
	            // 역직렬화된 accessToken 객체를 읽어온다.
	            Object objectAccToken = ois.readObject();
	            AccessToken accessToken =  (AccessToken) objectAccToken;
	            logger.debug("accToken:{}", accessToken);
	            
	            Twitter twitter = new TwitterFactory().getInstance();
	        	
	    		twitter.setOAuthConsumer(APIkey, APIsecretKey);
	    		twitter.setOAuthAccessToken(accessToken);
	    		   
	    		try{
	    			
	    			Status status = twitter.updateStatus("먀먀");//괄호안의 내용 포스팅함
	    			logger.debug("twitter update success");
	    			
	    		} catch(TwitterException te){
	    			if(401 == te.getStatusCode()){
	    				//unable to get the access token
	    			} else{
	    				te.printStackTrace();
	    			}
	    		}
	    		
	            
	        } 
	        catch (IOException | ClassNotFoundException e) {
				e.printStackTrace();
			}
	    } 
	    catch (IOException e1) {
			e1.printStackTrace();
		}
		
		return "home";
	}
	
*/
}
	
