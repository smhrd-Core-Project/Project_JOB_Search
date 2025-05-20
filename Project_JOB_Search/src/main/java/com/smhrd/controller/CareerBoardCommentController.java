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

import com.smhrd.mapper.CareerBoardCommentMapper;
import com.smhrd.model.CareerBoardCommentVO;
import com.smhrd.model.CareerBoardVO;

@Controller
public class CareerBoardCommentController {

	@Autowired
	private CareerBoardCommentMapper commentMapper;
	
	//댓글 수정
	@ResponseBody
	@PostMapping("/comment/update")
	public String updateComment(@RequestBody CareerBoardCommentVO vo, HttpSession session) {
	    String loginId = (String) session.getAttribute("id");
	    vo.setId(loginId); // 작성자 체크

	    int res = commentMapper.updateComment(vo);
	    return res > 0 ? "success" : "unauthorized";
	}
	//댓글 삭제
	@ResponseBody
	@PostMapping("/comment/delete")
	public String deleteComment(@RequestBody Map<String, Object> payload, HttpSession session) {
	    int commentId = (int) payload.get("commentId");
	    String loginId = (String) session.getAttribute("id");

	    int res = commentMapper.deleteComment(commentId, loginId);
	    return res > 0 ? "success" : "unauthorized";
	}

	@PostMapping("/commentInsert")
    public String insertComment(CareerBoardCommentVO vo, HttpSession session) {
        // 로그인한 사용자 ID 세션에서 가져오기
        String userId = (String) session.getAttribute("id");
        vo.setId(userId);  // 작성자 설정

        commentMapper.insertComment(vo);

        // 댓글 작성 후 원래 게시글 상세보기로 리다이렉트
        return "redirect:/detail?boardCareerId=" + vo.getBoardCareerId();
    }
}
