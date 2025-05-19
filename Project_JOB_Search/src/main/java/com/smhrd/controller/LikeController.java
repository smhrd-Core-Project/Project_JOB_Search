package com.smhrd.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.mapper.FreeBoardLikeMapper;
import com.smhrd.model.FreeBoardVO;
import com.smhrd.model.MemberVO;


@RestController
public class LikeController {
	
	 @Autowired
	    FreeBoardLikeMapper likeMapper;

	    @PostMapping("/ToggleLike")
	    public Map<String, Object> toggleLike(@RequestParam int post_idx, HttpSession session) {
	        MemberVO user = (MemberVO) session.getAttribute("loginUser");

	        if (user == null) {
	            user = new MemberVO();
	            user.setId("tester1234");
	            session.setAttribute("loginUser", user);
	        }

	        String id = user.getId();
	        Map<String, Object> result = new HashMap<>();

	        int liked = likeMapper.checkLike(post_idx, id);
	        if (liked == 0) {
	            likeMapper.insertLike(post_idx, id);
	            result.put("liked", true);
	        } else {
	            likeMapper.deleteLike(post_idx, id);
	            result.put("liked", false);
	        }

	        int likeCount = likeMapper.countLikes(post_idx);
	        result.put("status", "success");
	        result.put("likeCount", likeCount);
	        return result;
	    }

}
