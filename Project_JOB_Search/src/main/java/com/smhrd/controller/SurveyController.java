package com.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smhrd.database.SurveyMapper;

@Controller
public class SurveyController {
	
	@Autowired
    SurveyMapper mapper;
	
	
	@GetMapping("/Survey")
    public String showSurvey(Model model) {
        List<String> surveys = mapper.getRandomSurveys();
        model.addAttribute("surveys", surveys);
        return "Survey1";  // JSP 파일 이름
    }

}
