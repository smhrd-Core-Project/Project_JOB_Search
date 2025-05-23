package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.database.CareerBoardMapper;
import com.smhrd.database.FreeBoardMapper;
import com.smhrd.database.MemberMapper;
import com.smhrd.model.CareerBoardVO;
import com.smhrd.model.FreeBoardVO;
import com.smhrd.model.MemberVO;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    MemberMapper mapper;
    
    @Autowired
	CareerBoardMapper C_mapper;
    
    @Autowired
	FreeBoardMapper F_mapper;
    
    // 프로젝트 시작 시 메인페이지로 바로 이동
    @GetMapping("/")
    public String home() {
        return "main"; 
    }
    

    @RequestMapping("/Login")
	public String member() {

		return "Login";
	}
    
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(@RequestBody MemberVO vo, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        MemberVO memberVo = mapper.login(vo);

        if (memberVo != null) {
            session.setAttribute("loginUser", memberVo);
            result.put("success", true);
            result.put("userName", memberVo.getName());
        } else {
            result.put("success", false);
            result.put("message", "아이디 또는 비밀번호가 올바르지 않습니다.");
        }

        return result;
    }
    
    
    // 로그인 임시 확인 창 (추후에는 삭제)
    @RequestMapping("/loginSuccess")
    public String loginSuccess(HttpSession session, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
    
        List<FreeBoardVO> list_F = F_mapper.Main_select();
        

        List<CareerBoardVO> list_C = C_mapper.Main_selectPaged();
        
      
        if(list_F!=null) {
        	model.addAttribute("list_F", list_F);
        	model.addAttribute("list_C", list_C);
        } else {
        	String error = "정보가 없습니다!";
        	System.err.println(error);
        }

        if (loginUser != null) {
            model.addAttribute("name", loginUser.getName());
            return "loginSuccess"; // loginSuccess.jsp로 이동
        } else {
            return "redirect:/Login";
        }
        
        
        
    }
    
}
