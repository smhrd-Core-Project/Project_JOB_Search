package com.smhrd.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smhrd.mapper.CareerBoardMapper;
import com.smhrd.model.CareerBoardVO;


@Controller
public class CareerBoardController {

	
	@Autowired
	CareerBoardMapper mapper;
	
	@RequestMapping("/tb_careerboard")
	public String list(Model model) {
		List<CareerBoardVO> list =mapper.select();
		model.addAttribute("list", list);
		return "/tb_careerboard";
	}
}
