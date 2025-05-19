package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class LoginFakeController {
	
	 @RequestMapping("/fakeLogin")
	    public String mockLogin(HttpSession session) {
	        session.setAttribute("id", "test02"); // 수동 생성한 아이디
	        System.out.println("로그인된 사용자: " + session.getAttribute("id"));
	        return "redirect:/"; // 홈 또는 게시판으로 이동
	    }
	
}
