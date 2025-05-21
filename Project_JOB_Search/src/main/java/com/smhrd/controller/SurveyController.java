package com.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.database.SurveyMapper;

@Controller
public class SurveyController {
	
	@Autowired
    SurveyMapper mapper;
	
	
	// 설문조사 메인 페이지
	@RequestMapping("/surveyMain")
	public String member() {

		return "surveyMain";
	}
	
	// 설문조사 DB에서 가져오기
	@GetMapping("/survey")
    public String showSurveyByGroup(@RequestParam("group") String group, Model model) {
        List<String> surveys = mapper.getRandomSurveysByGroup(group);
        model.addAttribute("surveys", surveys);
        model.addAttribute("group", group); // JSP에서 표시용
        return "surveyPage"; // 설문 JSP
    }

}
