package com.smhrd.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.xml.stream.events.Comment;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.smhrd.database.MyPageMapper;
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
	
	
	//댓글작업
	@RequestMapping("/MyComment")
	public String showMyComments(HttpSession session, Model model) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        // 로그인 안 되어 있으면 로그인 페이지로 리디렉션
	        return "redirect:/Login";
	    }

	    // 로그인한 사용자의 아이디로 댓글 조회
	    List<MyPageVO> careerComments = mypagemapper.findCareerCommentsByUserId(loginUser.getId());
	    List<MyPageVO> freeComments = mypagemapper.findFreeCommentsByUserId(loginUser.getId());

	    model.addAttribute("careerComments", careerComments);
	    model.addAttribute("freeComments", freeComments);
	    
	    return "MyComment"; // 보여줄 JSP 페이지
	}
	
	
	
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	public String deleteComment(
	        @RequestParam(required = false) Integer comment_id,
	        @RequestParam(required = false) Integer cmt_idx,
	        @RequestParam String type,
	        Model model) {
	    
	    int cnt = 0;
	    if ("career".equals(type) && comment_id != null) {
	        cnt = mypagemapper.deleteCareerCommentByIdx(comment_id);
	    } else if ("free".equals(type) && cmt_idx != null) {
	        cnt = mypagemapper.deleteFreeCommentByIdx(cmt_idx);
	    } else {
	        model.addAttribute("msg", "잘못된 요청입니다.");
	        return "redirect:/MyComment";
	    }

	    if (cnt > 0) {
	        model.addAttribute("msg", "댓글이 삭제되었습니다.");
	    } else {
	        model.addAttribute("msg", "삭제 실패했습니다.");
	    }

	    return "redirect:/MyComment";
	}
	
	
	@GetMapping("/UpdateComment")
	public String updateComment(@RequestParam String type,
	                            @RequestParam(required = false) Integer comment_id,
	                            @RequestParam(required = false) Integer cmt_idx,
	                            Model model) {

	    MyPageVO comment = null;

	    if ("career".equals(type) && comment_id != null) {
	        comment = mypagemapper.findCareerCommentById(comment_id);
	    } else if ("free".equals(type) && cmt_idx != null) {
	        comment = mypagemapper.findFreeCommentByIdx(cmt_idx);
	    }

	    if (comment == null) {
	        // 유효하지 않은 접근일 경우 처리
	        return "redirect:/MyComment";
	    }

	    model.addAttribute("comment", comment);
	    model.addAttribute("type", type);

	    return "UpdateComment";
	}
	
	@PostMapping("/UpdateComment")
	public String update2(MyPageVO vo, @RequestParam String type) {
	    System.out.println(vo);

	    int cnt = 0;
	    if ("career".equals(type)) {
	        cnt = mypagemapper.updateCareerComment(vo);
	    } else if ("free".equals(type)) {
	        cnt = mypagemapper.updateFreeComment(vo);
	    }

	    if (cnt > 0) {
	        System.out.println("댓글 수정 성공");
	    } else {
	        System.out.println("댓글 수정 실패");
	    }

	    return "redirect:/MyComment";
	}
	
	
	

	
	
	//보드작업
	

	@RequestMapping("/MyBoard")
	public String showMyBoard(HttpSession session, Model model) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

	    if (loginUser == null) {
	        // 로그인 안 되어 있으면 로그인 페이지로 리디렉션
	        return "redirect:/Login";
	    }

	    // 로그인한 사용자의 아이디로 댓글 조회
	    List<MyPageVO> careerBoard = mypagemapper.findCareerBoardByUserId(loginUser.getId());
	    List<MyPageVO> freeBoard = mypagemapper.findFreeBoardByUserId(loginUser.getId());

	    model.addAttribute("careerBoard", careerBoard);
	    model.addAttribute("freeBoard", freeBoard);
	    
	    return "MyBoard"; // 보여줄 JSP 페이지
	}
	
	@RequestMapping(value = "/deletBoard", method = RequestMethod.POST)
	public String deleteBoard(
	        @RequestParam(required = false) Integer comment_id,
	        @RequestParam(required = false) Integer cmt_idx,
	        @RequestParam String type,
	        Model model) {
	    
	    int cnt = 0;
	    if ("career".equals(type) && comment_id != null) {
	        cnt = mypagemapper.deleteCareerBoardByIdx(comment_id);
	    } else if ("free".equals(type) && cmt_idx != null) {
	        cnt = mypagemapper.deleteFreeBoardByIdx(cmt_idx);
	    } else {
	        model.addAttribute("msg", "잘못된 요청입니다.");
	        return "redirect:/MyBoard";
	    }

	    if (cnt > 0) {
	        model.addAttribute("msg", "게시글이 삭제되었습니다.");
	    } else {
	        model.addAttribute("msg", "삭제 실패했습니다.");
	    }

	    return "redirect:/MyBoard";
	}
	
	
	@GetMapping("/UpdateBoard")
	public String updateBoard(@RequestParam String type,
	                            @RequestParam(required = false) Integer comment_id,
	                            @RequestParam(required = false) Integer cmt_idx,
	                            Model model) {

	    MyPageVO board = null;

	    if ("career".equals(type) && comment_id != null) {
	    	board = mypagemapper.findCareerBoardtById(comment_id);
	    } else if ("free".equals(type) && cmt_idx != null) {
	    	board = mypagemapper.findFreeBoardByIdx(cmt_idx);
	    }

	    if (board == null) {
	        // 유효하지 않은 접근일 경우 처리
	        return "redirect:/MyBoard";
	    }

	    model.addAttribute("board", board);
	    model.addAttribute("type", type);

	    return "UpdateBoard";
	}
	
	@PostMapping("/UpdateBoard")
	public String updateBoard2(MyPageVO vo, @RequestParam String type) {
	    System.out.println(vo);

	    int cnt = 0;
	    if ("career".equals(type)) {
	        cnt = mypagemapper.updateCareerBoard(vo);
	    } else if ("free".equals(type)) {
	        cnt = mypagemapper.updateFreeBoard(vo);
	    }

	    if (cnt > 0) {
	        System.out.println("댓글 수정 성공");
	    } else {
	        System.out.println("댓글 수정 실패");
	    }

	    return "redirect:/MyBoard";
	}
	
	
	
}
