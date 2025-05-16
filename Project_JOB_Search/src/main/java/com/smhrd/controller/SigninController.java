package com.smhrd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SigninController {
	
	
	@RequestMapping("/Signin")
	public String member() {

		return "Signin";
	}

}
