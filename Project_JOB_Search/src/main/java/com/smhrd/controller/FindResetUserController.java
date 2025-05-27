package com.smhrd.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
    
    @RequestMapping("/resetPwForm")
    public String resetPwForm() {
    	return "resetPwForm";
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
    
    
    
    @PostMapping("/resetPassword")
    public String resetPassword(MemberVO vo, Model model) {
        MemberVO user = mapper.findPassword(vo);

        if (user != null) {
            model.addAttribute("verifiedUserId", user.getId());
            return "newPwForm"; 
        } else {
            model.addAttribute("error", "입력한 정보와 일치하는 계정이 없습니다.");
            return "resetPwForm";
        }
    }

    
    @PostMapping("/updatePassword")
    public String updatePassword(MemberVO vo,
                                 RedirectAttributes redirectAttributes) {

        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        vo.setPassword(encoder.encode(vo.getPassword())); // 암호화된 비밀번호로 set

        int result = mapper.updatePassword(vo);

        if (result > 0) {
            redirectAttributes.addFlashAttribute("msg", "비밀번호가 성공적으로 변경되었습니다!");
            return "redirect:/Login";
        } else {
            redirectAttributes.addFlashAttribute("msg", "비밀번호 변경 실패! 유효한 ID인지 확인해주세요.");
            return "redirect:/resetPwForm";
        }
    }

    
}
