package com.smhrd.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.smhrd.database.CareerBoardLikeMapper;
import com.smhrd.database.CareerBoardMapper;
import com.smhrd.model.CareerBoardCommentVO;
import com.smhrd.model.CareerBoardVO;


@Controller
public class CareerBoardController {
	
	@Autowired
	private CareerBoardMapper mapper;
	@Autowired
	private com.smhrd.database.CareerBoardCommentMapper commentMapper;
	@Autowired
	private CareerBoardLikeMapper likeMapper;
	
	//좋아요 기능
	@ResponseBody
	@PostMapping("/toggleLike")
	public Map<String, Object> toggleLike(@RequestParam int boardCareerId, HttpSession session) {
	    String userId = (String) session.getAttribute("id");
	    Map<String, Object> result = new HashMap<>();
	    
	    //로그인 확인
	    if (userId==null) {
	    	result.put("error","login_required");
	    	return result;
	    }
	    //사용자의 게시글 좋아요여부확인
	    boolean alreadyLiked = likeMapper.checkLiked(boardCareerId, userId) > 0;
	    
	    if(alreadyLiked) {//좋아요 취소
	    	likeMapper.deleteLike(boardCareerId, userId);
	    	mapper.decreaseLikes(boardCareerId);
	    	result.put("liked", false);
	    } else {//좋아요 추가
	    	likeMapper.insertLike(boardCareerId, userId);
	    	mapper.increaseLikes(boardCareerId);
	    	result.put("liked", true);
	    }
	    //변경 좋아요 출력
	    int newLikeCount = mapper.getLikes(boardCareerId);
	    result.put("likeCount", newLikeCount);
	    
	    return result;
	}
	
	//메인
	@RequestMapping("/")
	public String redirectToPageList() {
	    return "redirect:/careerboard?page=1";
	}
	
	// 게시글 작성처리
	@PostMapping("/insert")
	public String insert(CareerBoardVO vo, HttpSession session) {
	vo.setId ((String) session.getAttribute("id"));
	
		mapper.insert(vo);
		return "redirect:/detail?boardCareerId=" + vo.getBoardCareerId();
	}
	//게시글 작성폼
	@RequestMapping("/write")
	public String write(){
		return "careerboardwrite";
	}
	
	@PostMapping("/uploadImage")
	@ResponseBody
	public String uploadImage(@RequestParam("file") MultipartFile file, HttpServletRequest request) {
	    try {
	        // 업로드 경로 지정
	        String uploadDir = request.getSession().getServletContext().getRealPath("/resources/upload/");
	        File dir = new File(uploadDir);
	        if (!dir.exists()) dir.mkdirs();

	        // 저장 파일명
	        String filename = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
	        File uploadFile = new File(dir, filename);
	        file.transferTo(uploadFile);

	        // 웹에서 접근 가능한 경로 리턴
	        return request.getContextPath() + "/resources/upload/" + filename;
	    } catch (Exception e) {
	        e.printStackTrace();
	        return null;
	    }
	}
	
	
	//게시글 상세보기
	@RequestMapping("/detail")
	public String detail(@RequestParam("boardCareerId") int boardCareerId, Model model, HttpSession session) {
		String loginId = (String) session.getAttribute("id");
		
		mapper.increaseViews(boardCareerId);
	
		CareerBoardVO vo = mapper.selectOne(boardCareerId);
	   
		if(vo==null) {
			return "redirect:/careerboard";
		}
	   
	   boolean liked=false;
	   if(loginId !=null) {
		   liked = likeMapper.checkLiked(boardCareerId, loginId)> 0;
	   }
	   vo.setLiked(liked);
	   
	   model.addAttribute("board", vo);
	   model.addAttribute("loginId",loginId);
	   
	   List<CareerBoardCommentVO> comments = commentMapper.selectComments(boardCareerId); // 댓글 목록
	   model.addAttribute("comments", comments);
	   
	   return "careerboarddetail";
	}
	//게시글 수정폼
	@RequestMapping("/updateForm")
	public String update(@RequestParam("boardCareerId")int boardCareerId, Model model) {
		CareerBoardVO board = mapper.selectOne(boardCareerId);
		model.addAttribute("board", board);
		return "careerboardupdate";
	}
	
	
	@RequestMapping("/careerboard")
	public String careerboard(@RequestParam(defaultValue = "1") int page, Model model) {
	    int pageSize = 10;
	    int start = (page - 1) * pageSize;
	    int end = page * pageSize;

	    List<CareerBoardVO> list = mapper.selectPaged(start, end);
	    int total = mapper.countBoards();
	    int totalPage = (int) Math.ceil((double) total / pageSize);

	    model.addAttribute("list", list);
	    model.addAttribute("page", page);
	    model.addAttribute("totalPage", totalPage);
	    return "careerboard";
	}
	    
	//게시글 수정 처리
	@PostMapping("/update")
	public String update(CareerBoardVO vo) {
		mapper.update(vo);
		return "redirect:/detail?boardCareerId=" + vo.getBoardCareerId();
	}
	//게시글 삭제
	@PostMapping("/delete")
	public String delete(@RequestParam("boardCareerId") int boardCareerId) {
		//댓글 삭제
		commentMapper.deleteComments(boardCareerId);
		//좋아요 삭제
		likeMapper.deleteByBoardCareerId(boardCareerId);
		//게시글 삭제
		mapper.delete(boardCareerId);
	    return "redirect:/careerboard";
	}
	
}
