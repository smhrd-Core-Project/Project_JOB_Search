package com.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.mapper.CareerBoardMapper;
import com.smhrd.model.CareerBoardCommentVO;
import com.smhrd.model.CareerBoardVO;


@Controller
public class CareerBoardController {
	
	@Autowired
	private CareerBoardMapper mapper;
	
	@Autowired
	private com.smhrd.mapper.CareerBoardCommentMapper commentMapper;
	
	
	
	@RequestMapping("/")
	public String list(Model model) {
	    List<CareerBoardVO> list = mapper.selectWithCommentCount();
	    model.addAttribute("list", list);
	    return "careerboard";
	}
	
	@RequestMapping("/careerboard")
	public String careerboard(Model model) {
	    List<CareerBoardVO> list = mapper.selectWithCommentCount();
	    model.addAttribute("list", list);
	    return "careerboard";
	}
	
	@PostMapping("/write")
	public String writesave(CareerBoardVO vo, HttpSession session) {
	vo.setId ((String) session.getAttribute("id"));
	
		mapper.insert(vo);
		return "redirect:/";
	}
	
	@RequestMapping("/write")
	public String write(){
		return "careerboardwrite";
		
	}
	
	@RequestMapping("/detail")
	public String detail(@RequestParam("boardCareerId") int boardCareerId, Model model, HttpSession session) {
	   CareerBoardVO vo = mapper.selectOne(boardCareerId);
	   model.addAttribute("board", vo);
	   
	   List<CareerBoardCommentVO> comments = commentMapper.selectComments(boardCareerId); // 댓글 목록
	   model.addAttribute("comments", comments);
	   
	   String loginId = (String) session.getAttribute("id");
	   model.addAttribute("loginId",loginId);
	    return "careerboarddetail";
	}
	
	@RequestMapping("/updateForm")
	public String update(@RequestParam("boardCareerId")int boardCareerId, Model model) {
		CareerBoardVO board = mapper.selectOne(boardCareerId);
		model.addAttribute("board", board);
		return "careerboardupdate";
	}
	
	@PostMapping("/update")
	public String update(CareerBoardVO vo) {
		mapper.update(vo);
		return "redirect:/careerboard";
	}
	
	@PostMapping("/delete")
	public String delete(@RequestParam("boardCareerId") int boardCareerId) {
		commentMapper.deleteComments(boardCareerId);
		mapper.delete(boardCareerId);
	    return "redirect:/careerboard";
	}
	
	
}
