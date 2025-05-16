package com.smhrd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.http.MediaType;

import com.smhrd.mapper.ConnMapper;
import com.smhrd.model.ConnVO;


@Controller
public class ConnController {
	@ Autowired
	ConnMapper mapper;

	@PostMapping("/ConnV")
	public String Conn(@ModelAttribute ConnVO vo, Model model) {
		int num1 = vo.getIn_num1();
		int num2 = vo.getIn_num2();

		// FastAPI로 JSON POST 요청
		String url = "http://192.168.219.234:9001/calculate";

		RestTemplate restTemplate = new RestTemplate();
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);

		Map<String, Integer> requestBody = new HashMap<>();
		requestBody.put("num1", num1);
		requestBody.put("num2", num2);

		HttpEntity<Map<String, Integer>> request = new HttpEntity<>(requestBody, headers);

		ResponseEntity<Map> response = restTemplate.postForEntity(url, request, Map.class);
		int result = (int) response.getBody().get("result");

		model.addAttribute("result", result);
		return "ConnV";
	}

	@RequestMapping("/Conn")
	public String member() {

		return "Conn";
	}
	
	@RequestMapping("/tb_careerboard")
	public String select(Model model) {
		List<ConnVO> list =mapper.select();
		model.addAttribute("list", list);
		return "/tb_careerboard";
	}
}
