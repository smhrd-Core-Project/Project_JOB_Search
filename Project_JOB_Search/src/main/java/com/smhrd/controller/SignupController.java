package com.smhrd.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.database.MemberMapper;
import com.smhrd.model.MemberVO;

@Controller
public class SignupController {
	
	
	@Autowired
	MemberMapper mapper;
	
	
	@RequestMapping("/Signup")
	public String member() {

		return "Signup";
	}
	
	// 회원가입 기능
	@PostMapping("join")
	public String join(MemberVO vo, HttpSession session, Model model) {
		// ID 중복 체크
	    if (mapper.checkId(vo.getId()) > 0) {
	        model.addAttribute("error", "중복된 ID입니다.");
	        return "Signup";
	    }
	    
	    // 6) 비밀번호 암호화
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    vo.setPassword(encoder.encode(vo.getPassword()));

	    
	    // 실제 회원가입 처리
	    mapper.join(vo);

	    String combinedMajors = String.join(",",
	            (String) session.getAttribute("major1"),
	            (String) session.getAttribute("major2"),
	            (String) session.getAttribute("major3")
	        );
	    
	    
	   System.out.println(combinedMajors);
	        mapper.user_log(vo.getId(), combinedMajors);

	        session.removeAttribute("major1");
	        session.removeAttribute("major2");
	        session.removeAttribute("major3");


	   
	   

	    // 8) 가입 성공 페이지로 리다이렉트
	    return "redirect:/joinSuccess?id=" + vo.getId();
	}

	
	
	@RequestMapping("/joinSuccess")
	public String joinSuccessPage(@RequestParam("id") String id, Model model) {
	    model.addAttribute("id", id);
	    return "joinSuccess";  // -> /WEB-INF/views/joinSuccess.jsp 로 연결
	}
	
	
	// 아이디 중복 방지
	@RequestMapping("/checkId")
	@ResponseBody
	public Map<String, Boolean> checkId(@RequestParam String id) {
	    boolean available = mapper.checkId(id) == 0;
	    Map<String, Boolean> result = new HashMap<>();
	    result.put("available", available);
	    return result;
	}
	
	// 이메일 중복 방지
	@RequestMapping("/checkEmail")
	@ResponseBody
	public Map<String, Boolean> checkEmail(@RequestParam String email) {
	    int count = mapper.checkEmail(email); // DB에서 count(*)로 중복 확인
	    boolean available = (count == 0);

	    Map<String, Boolean> response = new HashMap<>();
	    response.put("available", available);
	    return response;
	}

}
