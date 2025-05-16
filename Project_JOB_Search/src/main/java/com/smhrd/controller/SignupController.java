package com.smhrd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	
	@PostMapping("join")
	public String join(MemberVO vo, Model model) {
		
		mapper.join(vo);

		model.addAttribute("id", vo.getId());

		return "redirect:/join_success?id=" + vo.getId();
		
	}

}
