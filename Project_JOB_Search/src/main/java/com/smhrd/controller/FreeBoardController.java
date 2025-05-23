package com.smhrd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
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
	public String detail(@RequestParam("post_idx") int post_idx, Model model,HttpSession session) {
		
		mapper.incrementViewsCount(post_idx);
		
		FreeBoardVO post = mapper.selectOne(post_idx);
		List<FreeBoardCommentVO> comments = commentmapper.selectByPostIdx(post_idx);
		
		 MemberVO user = (MemberVO) session.getAttribute("loginUser");
		    boolean liked = false;
		    if (user != null) {
		        int likedCount = likeMapper.checkLike(post_idx, user.getId());
		        liked = likedCount > 0;
		    }
		  
		model.addAttribute("post", post);
		model.addAttribute("comments", comments);
		model.addAttribute("liked",liked);
		return "FreeBoardDetail";
	}
	

	@RequestMapping("/InsertComment")
	@Transactional
	public String insertComment(FreeBoardCommentVO vo, HttpSession session, @RequestParam int post_idx) {
		MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");

		if (loginUser != null) {
			vo.setId(loginUser.getId()); // 또는 setWriter() 사용한 경우에 맞춰 수정
			commentmapper.insert(vo);
			mapper.incrementCommentCount(vo.getPost_idx());
			return "redirect:/FreeBoardDetail?post_idx=" + vo.getPost_idx();
		} else {
			// 로그인 안 된 경우 로그인 페이지로 보내기
			return "redirect:/Login";
		}

	}
	
	@RequestMapping("/DeleteComment")
	@Transactional
	public String deleteComment(@RequestParam("comment_id") int commentId,
	                            @RequestParam("post_idx") int postIdx,
	                            HttpSession session) {
	    MemberVO user = (MemberVO) session.getAttribute("loginUser");

	    if (user == null) {
	        return "redirect:/Login";
	    }

	    int deleteCount = mapper.deleteComment(commentId, user.getId());

	    if (deleteCount > 0) {
	        mapper.decrementCommentCount(postIdx);
	    }

	    // 댓글 삭제 후 다시 상세 페이지로 이동
	    return "redirect:/FreeBoardDetail?post_idx=" + postIdx;
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
	

	@Transactional
	@PostMapping("/ToggleLike")
	@ResponseBody
	public Map<String, Object> toggleLike(@RequestParam("post_idx") int post_idx, HttpSession session) {
		MemberVO user = (MemberVO) session.getAttribute("loginUser");
		String id = user != null ? user.getId() : null;
		
		System.out.println("post_idx = " + post_idx + ", id = " + id);

	    
		Map<String, Object> result = new HashMap<>();

	    if (id == null) {
	        result.put("status", "fail");
	        result.put("message", "로그인 필요");
	        return result;
	    }

	    boolean liked;

	    int alreadyLiked = mapper.checkLike(post_idx, id);
	    
	    if (alreadyLiked > 0) {
	    	 System.out.println("좋아요 DELETE 시도");
	        mapper.deleteLike(post_idx, id);
	        mapper.decrementLikeCount(post_idx);
	        liked = false;
	    } else {
	    	 System.out.println("좋아요 INSERT 시도");
	        mapper.insertLike(post_idx, id);
	        mapper.incrementLikeCount(post_idx);
	        liked = true;
	    }

	    int likeCount = mapper.countLikes(post_idx);

	    result.put("status", "success");
	    result.put("liked", liked);
	    result.put("likeCount", likeCount);
	    return result;
	}
	

}