package com.smhrd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.database.CareerBoardMapper;
import com.smhrd.database.FreeBoardMapper;
import com.smhrd.database.MemberMapper;
import com.smhrd.model.MemberVO;

@Controller
public class FindResetUserController {
	
	
	@Autowired
    MemberMapper mapper;
    
    @Autowired
	private CareerBoardMapper C_mapper;
    
    @Autowired
	FreeBoardMapper F_mapper;
    
    
    @RequestMapping("/findIdForm")
    public String findIdForm() {
        return "findIdForm";
    }
    
    
    @PostMapping("/findId")
    public String findId(MemberVO vo, Model model) {
        String id = mapper.findIdByNameEmail(vo);
        if (id != null) {
            model.addAttribute("foundId", id);
        } else {
            model.addAttribute("error", "일치하는 정보가 없습니다.");
        }
        return "findIdForm";
    }

}
