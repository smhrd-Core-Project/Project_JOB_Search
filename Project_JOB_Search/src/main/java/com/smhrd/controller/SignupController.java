package com.smhrd.controller;

import java.util.HashMap;
import java.util.Map;

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
	public String join(MemberVO vo, Model model) {
	    if (mapper.checkId(vo.getId()) > 0) {
	        model.addAttribute("error", "중복된 ID입니다.");
	        return "Signup";
	    }

	    // 비밀번호 암호화 추가
	    BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
	    vo.setPassword(encoder.encode(vo.getPassword()));

	    mapper.join(vo);
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
