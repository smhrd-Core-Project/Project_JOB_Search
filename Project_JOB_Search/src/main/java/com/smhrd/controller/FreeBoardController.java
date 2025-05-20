package com.smhrd.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.mapper.FreeBoardCommentMapper;
import com.smhrd.mapper.FreeBoardLikeMapper;
import com.smhrd.mapper.FreeBoardMapper;
import com.smhrd.model.FreeBoardCommentVO;
import com.smhrd.model.FreeBoardVO;
import com.smhrd.model.MemberVO;



@Controller
public class FreeBoardController {
	
	@Autowired
	FreeBoardMapper mapper;
	
	@Autowired
	FreeBoardCommentMapper commentmapper;
	
	@Autowired
	private FreeBoardLikeMapper likeMapper;
	
	
	@RequestMapping("/FreeBoard")
	public String select(Model model) {
		List<FreeBoardVO> list =mapper.select();
		model.addAttribute("list", list);
		return "FreeBoard";
	}
	
	@RequestMapping("/FreeBoardWrite")
	public String writeForm() {
		return "FreeBoardWrite";
	}
	
	/*
	@RequestMapping("/InsertBoard")
	public String insertBoard(FreeBoardVO vo, HttpSession session) {
	    // 세션에서 로그인 정보 가져오기
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    if (loginUser != null) {
	        vo.setId(loginUser.getId());
	        vo.setViews(0); // 기본값 설정
	        mapper.insert(vo);
	    } else {
	        return "redirect:/Login"; // 로그인 안 되어 있으면 로그인 페이지로
	    }

	    return "redirect:/FreeBoard";
	}
	*/
	//테스트용
	@RequestMapping("/InsertBoard")
	public String insertBoard(FreeBoardVO vo, HttpSession session) {
	    // 테스트용 가짜 로그인
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    // 로그인 정보가 없으면 테스트용 ID 강제 주입
	    if (loginUser == null) {
	        loginUser = new MemberVO();
	        loginUser.setId("tester1234"); // 임시 아이디
	        session.setAttribute("loginUser", loginUser); // 세션에 저장
	    }

	    vo.setId(loginUser.getId());
	    vo.setViews(0);
	    mapper.insert(vo);

	    return "redirect:/FreeBoard";
	}
	
    @RequestMapping("/FreeBoardDetail")
    public String detail(int post_idx, Model model) {
        FreeBoardVO post = mapper.selectOne(post_idx);
        List<FreeBoardCommentVO> comments = commentmapper.selectByPostIdx(post_idx);

        int likeCount = likeMapper.countLikes(post_idx);
        post.setLikes(likeCount);
        
        model.addAttribute("post", post);
        model.addAttribute("comments", comments);
        return "FreeBoardDetail";
    }
    /*
    @RequestMapping("/InsertComment")
    public String insertComment(FreeBoardCommentVO vo, HttpSession session) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser != null) {
            vo.setWriter(loginUser.getId());
            FreeBoardCommentMapper.insert(vo);
        }
        return "redirect:/FreeBoardDetail?post_idx=" + vo.getPost_idx();
    }
    */
    //테스트
    @RequestMapping("/InsertComment")
    public String insertComment(FreeBoardCommentVO vo, HttpSession session, @RequestParam int post_idx) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

        // 없으면 테스트용으로 넣어줌
        if (loginUser == null) {
            loginUser = new MemberVO();
            loginUser.setId("tester1234");
            session.setAttribute("loginUser", loginUser);
        }

        vo.setId(loginUser.getId());
        vo.setPost_idx(post_idx);
        commentmapper.insert(vo);
        
        System.out.println(vo.getId());
        System.out.println(vo.getPost_idx());

        return "redirect:/FreeBoardDetail?post_idx=" + vo.getPost_idx();
    }
    


}