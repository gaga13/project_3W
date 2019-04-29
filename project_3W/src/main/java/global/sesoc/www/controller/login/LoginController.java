package global.sesoc.www.controller.login;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.sql.Blob;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import global.sesoc.www.dao.MemberDAO;
import global.sesoc.www.util.FileService;
import global.sesoc.www.vo.MemberVO;
import twitter4j.auth.AccessToken;

//회원가입, 로그인, 로그아웃 기능
@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	MemberDAO dao;				//회원관련 데이터 처리객체
	
	final String uploadPath="/boardfile";	//업로드할 파일 경로
	
	//회원가입시 이메일 중복 확인 -> 중복 아니면 회원가입
	@ResponseBody
	@RequestMapping(value="joinCheck", method=RequestMethod.GET)
	public String joinCheck(MemberVO memberVO){
	
		String emailCheck = "no";
		
		MemberVO Mvo = dao.getMember(memberVO.getEmail());
		//email 중복확인
		if(Mvo != null){
			emailCheck = "yes"; 		//사용자가 입력한 email이 이미 존재함 
			return emailCheck;
		}
		else{
			//회원가입처리
			int result = 0;
			result = dao.insertMember(memberVO);
			logger.debug("result:{}", result);
			//본인인증 이메일 전송
		}
		
		return emailCheck;
	}
	
	//로그인시 회원인지 체크 -> 아이디, 비밀번호 일치하면  로그인
	@ResponseBody
	@RequestMapping(value="loginCheck", method=RequestMethod.GET)
	public String loginCheck(String email, String password, HttpSession ses){
		
		logger.debug("checkemail:{}, pw:{}", email, password);
		String check = "false";
		MemberVO memberVO = dao.getMember(email);
		if(memberVO == null){
			logger.debug("memberVO == null");
			return check;
		}
		else{
			if(memberVO.getPassword().equals(password)){
				check = "true";
				logger.debug("email, pw 일치");
				//로그인된 아이디 세션에 저장
				ses.setAttribute("loginId", email);
				logger.debug("세션 아이디:{}", ses.getAttribute("loginId"));

				return check;
			}
		}
		logger.debug(check);
		return check;
	}
	
	//로그아웃
	@RequestMapping(value = "logout", method=RequestMethod.GET)
	public String logout(HttpSession session){
		logger.debug("logout");
		session.invalidate();
		return "redirect:/";
	}
	
	//회원 정보 수정폼으로 이동
	@RequestMapping(value="update", method=RequestMethod.GET)
	public String updateForm(Model model, HttpSession session){
		logger.info("수정폼 지나감");
		String email = (String) session.getAttribute("loginId");
		MemberVO member = dao.getMember(email);
		String birthdate = member.getUserbirthdate();
		if(birthdate != null){
		member.setUserbirthdate(birthdate.split(" ")[0]);
		logger.debug("생일:{}", member.getUserbirthdate());
		}
		model.addAttribute("member", member);
		logger.debug("member:{}", member);
		return "login/updateForm";
	}
	
	//수정처리
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(MemberVO member, HttpSession session){
		logger.info("수정처리 지나감");
		String email = (String) session.getAttribute("loginId");
		
		String img = member.getsavedImage();
		MemberVO UpdateMember = dao.getMember(email);
		String birth = member.getUserbirthdate();
		logger.info("birth: {}",birth);
		String birth2 = birth.substring(0, 4) + "/" + birth.substring(5,7) + "/" + birth.substring(8, 10);
		logger.info("birth2: {}",birth2);
		member.setUserbirthdate(birth2);
		
		int result = 0;
		/*//db에서 사진 저장하기
		byte[] savedImage;
		
        HashMap<String, Object> hmap = new HashMap<String, Object>();
        
        //savedImage를 binary data로 바꿔서 byte[]에 넣기, byte[]를 mapper에 넣어 저장
        try (ByteArrayOutputStream baos = new ByteArrayOutputStream()) {
            try (ObjectOutputStream oos = new ObjectOutputStream(baos)) {
                oos.writeObject(img);
             // serializedMember -> 직렬화된 accessToken 객체 
                savedImage = baos.toByteArray();
            }
            
            hmap.put("savedImage", savedImage);
            hmap.put("email", email);
            result = dao.insertImage(hmap);
            if(result == 1){ logger.debug("db에 토큰 저장 성공");}
        }
        catch(Exception e){
        	e.printStackTrace();
        }			*/
		UpdateMember.setUsername(member.getUsername());
		UpdateMember.setUserbirthdate(member.getUserbirthdate());
		UpdateMember.setPassword(member.getPassword());
		logger.debug("수정용:{}",UpdateMember);
		int result2 = dao.update(UpdateMember);
		return "home";
	}
	
	@RequestMapping(value="getByteImage", method=RequestMethod.GET)
	public ResponseEntity<byte[]> getByteImage(HttpSession session) {
		String email = (String) session.getAttribute("loginId");
		byte[] Image = null;
		HashMap<String, Object> hmap = dao.selectImage(email);
		
		Image = (byte[]) hmap.get("blobData");
		
		logger.debug("Image : {}", Image);
		
		try (ByteArrayInputStream bais = new ByteArrayInputStream(Image)) {
		    try (ObjectInputStream ois = new ObjectInputStream(bais)) {
	            
		    	Object ImageFile = ois.readObject();   
		    	
		    	logger.debug("ImageFile: {}", ImageFile);
		    }
		    catch(Exception e){
		    	e.printStackTrace();
		    }
		}
		catch(Exception e){
			e.printStackTrace();
		}		
		
		final HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.IMAGE_PNG);
		
		return new ResponseEntity<byte[]>(Image, headers, HttpStatus.OK);
	}
}
