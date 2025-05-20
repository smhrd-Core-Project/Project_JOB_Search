package com.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smhrd.mapper.MyPageMapper;
import com.smhrd.model.FreeBoardCommentVO;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MyPageVO;

	@Controller
	public class MyPageController {
		
	@Autowired
	private MyPageMapper mypagemapper;
	
	
	@RequestMapping("/MyPage")
	public String myPage() {
		return "MyPage";
		}
	

	@RequestMapping("/MyComment")
	public String showMyComments(HttpSession session, Model model) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        // 임시 테스트 아이디 강제 주입
	        loginUser = new MemberVO();
	        loginUser.setId("tester1234");
	        session.setAttribute("loginUser", loginUser);
	    }

	    List<MyPageVO> careerComments = mypagemapper.findCareerCommentsByUserId(loginUser.getId());
	    List<MyPageVO> freeComments = mypagemapper.findFreeCommentsByUserId(loginUser.getId());

	    model.addAttribute("careerComments", careerComments);
	    model.addAttribute("freeComments", freeComments);
	    
	    return "MyComment"; // JSP 이름
	}
	
	
}
		
	
