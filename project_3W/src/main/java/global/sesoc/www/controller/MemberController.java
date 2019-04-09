package global.sesoc.www.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import global.sesoc.www.dao.MemberDAO;
import global.sesoc.www.vo.MemberVO;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	@Autowired
	MemberDAO dao;				//회원관련 데이터 처리객체
	
	//회원 가입폼으로 이동
	@RequestMapping(value="join", method=RequestMethod.GET)
	public String joinForm(){
		logger.debug("joinGET 들어옴");
		return "joinForm";
	}
	
	//회원가입처리
	@RequestMapping(value="join", method=RequestMethod.POST)
	public String join(MemberVO member){
		logger.debug("join POST {}",member);
		int result = 0;
		result = dao.insertMember(member);
		return "redirect:/";
	}
	
	//로그인 폼으로 이동
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String loginForm(){
		logger.debug("login GET");
		return "login/loginForm";
	}
	
	//로그인시 회원인지 체크
	@ResponseBody
	@RequestMapping(value="loginCheck", method=RequestMethod.GET)
	public boolean loginCheck(String email, String password){
		
		logger.debug("email:{}, pw:{}", email, password);
		Boolean check = false;
		MemberVO memberVO = dao.getMember(email);
		if(memberVO == null){
			logger.debug("memberVO == null");
			return check;
		}
		else{
			if(memberVO.getPassword().equals(password)){
				check = true;
			}
		}
		
		return check;
	};
	
	//로그인 처리
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(String email, String password, Model model, HttpSession session){
		logger.debug("email:{}, password:{}", email, password);
		
		MemberVO result = null;
		result = dao.getMember(email);
		logger.debug("{}",result);
		if(result != null && result.getPassword().equals(password)){
			session.setAttribute("loginId", email);
			return "redirect:/";
		}
		return "redirect:login";
	}
	//로그아웃
	@RequestMapping(value = "logout", method=RequestMethod.GET)
	public String logout(HttpSession session){
		logger.debug("logout");
		session.invalidate();
		return "redirect:/";
	}
	/*
	@RequestMapping(value="joinPost", method=RequestMethod.POST)
	public String joinPost(@ModelAttribute("MemberVO") MemberVO member) throws Exception {
		logger.info("currnent join member: " + member.toString());
		userService.create(member);
		
		return "/user/joinPost";
	}
	*/
}
