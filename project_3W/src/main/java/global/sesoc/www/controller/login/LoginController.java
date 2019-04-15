package global.sesoc.www.controller.login;

import javax.servlet.http.HttpSession;



import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;


import global.sesoc.www.dao.MemberDAO;
import global.sesoc.www.util.FileService;
import global.sesoc.www.vo.MemberVO;

//회원가입, 로그인, 로그아웃 기능
@Controller
public class LoginController {

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	MemberDAO dao;				//회원관련 데이터 처리객체
	
	final String uploadPath="/boardfile";
	
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
		model.addAttribute("member", member);
		logger.debug("update");
		return "updateForm";
	}
	
	//수정처리
	
	@RequestMapping(value="update", method=RequestMethod.POST)
	public String update(MemberVO member, HttpSession session, MultipartFile Savedfile){
		logger.info("수정처리 지나감");
		String email = (String) session.getAttribute("loginId");
		logger.debug("vo:{}", member);
		logger.debug("아이디:{}", email );
		
		String birth = member.getUserbirthdate();
		logger.info("birth: {}",birth);
		String birth2 = birth.substring(0, 4) + "/" + birth.substring(5,7) + "/" + birth.substring(8, 10);
		logger.info("birth2: {}",birth2);
		member.setUserbirthdate(birth2);
		
		logger.info("{}", Savedfile);
		
		logger.debug("파일 첨부 지나감 : {}", Savedfile);
		  //첨부파일이 있는경우 저장된 경로에 저장하고, 원폰 파일명과 저장된 파일명을  member객체에 세팅
		  if (Savedfile != null && !Savedfile.isEmpty())
		  {
			  String savedfile = FileService.saveFile(Savedfile, uploadPath);
			  member.setOriginalfile(Savedfile.getOriginalFilename());
			  member.setSavedfile(savedfile);
		  }
		 
		logger.info("updatePOST : {}", member);
/*		String photo = member.getProfile_photo();
		logger.debug("photo : {}", photo);
		member.setProfile_photo(photo);*/
		
		member.setEmail(email);
		int result = dao.update(member);
		return "redirect:/";
	}

}
