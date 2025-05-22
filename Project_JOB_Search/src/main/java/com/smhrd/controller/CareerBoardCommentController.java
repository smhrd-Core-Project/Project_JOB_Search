package com.smhrd.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.database.CareerBoardCommentMapper;
import com.smhrd.model.CareerBoardCommentVO;
import com.smhrd.model.CareerBoardVO;
import com.smhrd.model.MemberVO;

@Controller
public class CareerBoardCommentController {

	@Autowired
	private CareerBoardCommentMapper commentMapper;
	
	//댓글 수정
	@ResponseBody
	@PostMapping("/comment/update")
	public String updateComment(@RequestBody CareerBoardCommentVO vo, HttpSession session) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	   if(loginUser == null) {
		   return "unauthorized";
	   }
	    vo.setId(loginUser.getId()); // 작성자 체크

	    int res = commentMapper.updateComment(vo);
	    return res > 0 ? "success" : "unauthorized";
	}
	//댓글 삭제
	@ResponseBody
	@PostMapping("/comment/delete")
	public String deleteComment(@RequestBody Map<String, Object> payload, HttpSession session) {
	    int commentId = (int) payload.get("commentId");
	    
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if(loginUser == null) {
	    	return "unauthorized";
	    }
	    String loginId = loginUser.getId();
	    Integer boardCareerId = commentMapper.getBoardCareerIdByCommentId(commentId);
	    
	    int res = commentMapper.deleteComment(commentId, loginId);
	    if (res > 0 && boardCareerId != null) {
            commentMapper.decreaseCommentCount(boardCareerId); // ★ 댓글 수 감소
            return "success";
	    }
	    return res > 0 ? "success" : "unauthorized";
	}

	//댓글 작성
	@PostMapping("/commentInsert")
    public String insertComment(CareerBoardCommentVO vo, HttpSession session, RedirectAttributes ra) {
     MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
		if(loginUser ==null) {
    	   ra.addFlashAttribute("errorMsg","로그인 후 댓글을 작성할 수 있습니다.");
    	   return "redirect:/Login";
       }
		// 로그인한 사용자 ID 세션에서 가져오기
        
        vo.setId(loginUser.getId());  // 작성자 설정

        commentMapper.insertComment(vo);
        commentMapper.increaseCommentCount(vo.getBoardCareerId()); // ★ 댓글 수 증가

        // 댓글 작성 후 원래 게시글 상세보기로 리다이렉트
        return "redirect:/detail?boardCareerId=" + vo.getBoardCareerId();
    }
	
}
