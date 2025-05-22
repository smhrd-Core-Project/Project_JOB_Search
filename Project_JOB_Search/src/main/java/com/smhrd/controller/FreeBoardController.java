package com.smhrd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.database.FreeBoardCommentMapper;
import com.smhrd.database.FreeBoardLikeMapper;
import com.smhrd.database.FreeBoardMapper;
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



	@RequestMapping("/FreeBoardWrite")
	public String writeForm() {
		return "FreeBoardWrite";
	}

	@RequestMapping("/InsertBoard")
	public String insertBoard(FreeBoardVO vo, HttpSession session) {
		// 테스트용 가짜 로그인
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser != null) {
			vo.setId(loginUser.getId());
			vo.setViews(0); // 기본값
			mapper.insert(vo);
			return "redirect:/FreeBoard";
		} else {
			// 로그인 안 된 경우 로그인 페이지로 리디렉션
			return "redirect:/Login";
		}
	}


	@RequestMapping("/FreeBoardDetail")
	public String detail(int post_idx, Model model) {
		FreeBoardVO post = mapper.selectOne(post_idx);
		List<FreeBoardCommentVO> comments = commentmapper.selectByPostIdx(post_idx);

		model.addAttribute("post", post);
		model.addAttribute("comments", comments);
		return "FreeBoardDetail";
	}
	
	@RequestMapping("/InsertComment")
	public String insertComment(FreeBoardCommentVO vo, HttpSession session, @RequestParam int post_idx) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser != null) {
			vo.setId(loginUser.getId()); // 또는 setWriter() 사용한 경우에 맞춰 수정
			commentmapper.insert(vo);
			return "redirect:/FreeBoardDetail?post_idx=" + vo.getPost_idx();
		} else {
			// 로그인 안 된 경우 로그인 페이지로 보내기
			return "redirect:/Login";
		}

	}
	@RequestMapping("/FreeBoard")
	public String freeboard(@RequestParam(defaultValue = "1") int page, Model model) {
	    int pageSize = 10;
	    int offset = (page - 1) * pageSize;

	    Map<String, Integer> map = new HashMap<>();
	    map.put("offset", offset);
	    map.put("pageSize", pageSize);

	    List<FreeBoardVO> list = mapper.getPageList(map);
	    int totalCount = mapper.getCount();
	    int totalPage = (int) Math.ceil(totalCount / (double) pageSize);

	    model.addAttribute("list", list);
	    model.addAttribute("page", page);
	    model.addAttribute("totalPage", totalPage);

	    return "FreeBoard";  // JSP 혹은 뷰 이름
	}
}