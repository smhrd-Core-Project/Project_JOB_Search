package com.smhrd.controller;

import java.io.UnsupportedEncodingException;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import com.smhrd.database.SurveyMapper;
import com.smhrd.model.MemberVO;

@Controller
public class SurveyController {
	
	@Autowired
    SurveyMapper mapper;
	
	
	// 설문조사 메인 페이지
	@RequestMapping("/surveyMain")
	public String member() {

		return "surveyMain";
	}
	
	// 설문조사 DB에서 가져와서 페이지에 시현
	@GetMapping("/survey")
    public String showSurveyByGroup(@RequestParam("group") String group, Model model, HttpSession session) {
        List<String> surveys = mapper.getRandomSurveysByGroup(group);
        model.addAttribute("surveys", surveys);
        session.setAttribute("group", group); 
        
        return "surveyPage";
    }
	
	
	@PostMapping("/sendSurvey.do")
	public String sendSurvey(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
	    List<Map<String, Object>> answers = new ArrayList<>();
	    int questionCount = 10; // 문항 수

	    request.setCharacterEncoding("UTF-8");
	    
	    for (int i = 1; i <= questionCount; i++) {
	        String qText = request.getParameter("q" + i + "_text");
	        String qScore = request.getParameter("q" + i + "_score"); // 이제 "그렇다", "보통이다", "아니다" 문자열!
	        if (qText != null && qScore != null) {
	            Map<String, Object> answer = new HashMap<>();
	            answer.put("question", qText);
	            answer.put("score", qScore); // 숫자 변환 없이 문자열 그대로!
	            answers.add(answer);
	        }
	    }

	    String majorType = request.getParameter("major_type");

	    // FastAPI로 전달할 JSON Body
	    Map<String, Object> body = new HashMap<>();
	    body.put("answers", answers);
	    body.put("major_type", majorType);

	    HttpHeaders headers = new HttpHeaders();
	    headers.setContentType(MediaType.APPLICATION_JSON);
	    HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(body, headers);

	    String url = "http://localhost:9001/recommend_major";
	    RestTemplate restTemplate = new RestTemplate();
	    ResponseEntity<Map> response = restTemplate.postForEntity(url, requestEntity, Map.class);

	    // 결과 활용
	    Map result = response.getBody();
	    List<String> majors = (List<String>) result.get("majors");

	    // JSP 등에 결과 전달
	    request.setAttribute("recommendMajors", majors);
	    
	    if (majors.size() >= 3) {
	        session.setAttribute("major1", majors.get(0));
	        session.setAttribute("major2", majors.get(1));
	        session.setAttribute("major3", majors.get(2));

	    }
	    return "resultPage"; // 결과 보여줄 JSP
	}

	
	// 설문조사 메인 페이지
		@RequestMapping("/re_surveyMain")
		public String re_member() {

			return "re_surveyMain";
		}
	
		@GetMapping("/re_survey")
	    public String show_re_SurveyByGroup(@RequestParam("group") String group, Model model, HttpSession session) {
	        List<String> surveys = mapper.getRandomSurveysByGroup(group);
	        model.addAttribute("surveys", surveys);
	        session.setAttribute("group", group); 
	        
	        return "re_surveyPage";
	    }
		
		
		@PostMapping("/re_sendSurvey.do")
		public String send_re_Survey(HttpServletRequest request, HttpSession session) throws UnsupportedEncodingException {
		    List<Map<String, Object>> answers = new ArrayList<>();
		    int questionCount = 10; // 문항 수

		    request.setCharacterEncoding("UTF-8");
		    
		    for (int i = 1; i <= questionCount; i++) {
		        String qText = request.getParameter("q" + i + "_text");
		        String qScore = request.getParameter("q" + i + "_score"); // 이제 "그렇다", "보통이다", "아니다" 문자열!
		        if (qText != null && qScore != null) {
		            Map<String, Object> answer = new HashMap<>();
		            answer.put("question", qText);
		            answer.put("score", qScore); // 숫자 변환 없이 문자열 그대로!
		            answers.add(answer);
		        }
		    }

		    String majorType = request.getParameter("major_type");

		    // FastAPI로 전달할 JSON Body
		    Map<String, Object> body = new HashMap<>();
		    body.put("answers", answers);
		    body.put("major_type", majorType);

		    HttpHeaders headers = new HttpHeaders();
		    headers.setContentType(MediaType.APPLICATION_JSON);
		    HttpEntity<Map<String, Object>> requestEntity = new HttpEntity<>(body, headers);

		    String url = "http://localhost:9001/recommend_major";
		    RestTemplate restTemplate = new RestTemplate();
		    ResponseEntity<Map> response = restTemplate.postForEntity(url, requestEntity, Map.class);

		    // 결과 활용
		    Map result = response.getBody();
		    List<String> remajors = (List<String>) result.get("majors");

		    // JSP 등에 결과 전달
		    request.setAttribute("re_recommendMajors", remajors);
		    
		    if (remajors.size() >= 3) {
		        session.setAttribute("remajor1", remajors.get(0));
		        session.setAttribute("remajor2", remajors.get(1));
		        session.setAttribute("remajor3", remajors.get(2));

		    }
		    
		    String recombinedMajors = String.join(",",
		            (String) session.getAttribute("remajor1"),
		            (String) session.getAttribute("remajor2"),
		            (String) session.getAttribute("remajor3")
		        );
		    
		    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		    
		    System.out.println("유저 아이디 : "+loginUser.getId());
		        mapper.user_relog(loginUser.getId(), recombinedMajors);

		        session.removeAttribute("remajor1");
		        session.removeAttribute("remajor2");
		        session.removeAttribute("remajor3");
		    
		    
		        session.setAttribute("loginUser", loginUser);
		    
		    return "re_resultPage"; // 결과 보여줄 JSP
		}


}
