package com.smhrd.controller;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.database.MemberMapper;
import com.smhrd.database.MyPageMapper;
import com.smhrd.model.FreeBoardCommentVO;
import com.smhrd.model.MemberVO;
import com.smhrd.model.MyPageVO;

	@Controller
	public class MyPageController {
		
	@Autowired
	private MyPageMapper mypagemapper;
	
	@Autowired
	MemberMapper mapper;
	
	
	@RequestMapping("/MyPage")
	public String myPage() {
		return "MyPage";
		}
	
	@GetMapping("/Update")
	   public String update() {
	      return "Update";
	   }
	   
	@PostMapping("/Update2")
	   public String update2(MemberVO vo, Model model) {
	      System.out.println(vo);
	      mapper.update(vo);
	      model.addAttribute("updateSuccess", true);
	      return "MyPage";
	      
	   }
	
	@RequestMapping("/DeleteUser")
	public String deleteUser(HttpSession session) {
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser != null) {
	        mapper.deleteUser(loginUser); // id가 들어있는 MemberVO 넘김
	        session.invalidate();
	    } else {
	    	System.out.println("탈퇴 실패");
	    }
	    return "redirect:/";
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
	
	@RequestMapping(value = "/deleteBoard", method = RequestMethod.POST)
	public String deleteBoard(
	        @RequestParam(required = false) Integer board_career_id,
	        @RequestParam(required = false) Integer post_idx,
	        @RequestParam String type,
	        Model model) {

	    int cnt = 0;

	    if ("career".equals(type) && board_career_id != null) {
	        // 진로게시판: 자식(좋아요/댓글) → 부모
	        mypagemapper.deleteCareerBoardLikesByCareerId(board_career_id);
	        mypagemapper.deleteCareerBoardCommentsByCareerId(board_career_id);
	        cnt = mypagemapper.deleteCareerBoardById(board_career_id);

	    } else if ("free".equals(type) && post_idx != null) {
	        // 자유게시판: 자식(좋아요/댓글) → 부모
	        mypagemapper.deleteFreeBoardLikesByPostIdx(post_idx);
	        mypagemapper.deleteFreeBoardCommentsByPostIdx(post_idx);
	        cnt = mypagemapper.deleteFreeBoardById(post_idx);

	    } else {
	        model.addAttribute("msg", "잘못된 요청입니다.");
	        return "redirect:/MyBoard";
	    }

	    if (cnt > 0) {
	        model.addAttribute("msg", "게시글이 삭제되었습니다.");
	    } else {
	        model.addAttribute("msg", "삭제에 실패했습니다.");
	    }

	    return "redirect:/MyBoard";
	}
	
	
	
	@GetMapping("/UpdateBoard")
	public String updateBoard(@RequestParam String type,
	                            @RequestParam(required = false) Integer board_career_id,
	                            @RequestParam(required = false) Integer post_idx,
	                            Model model) {

	    MyPageVO board = null;

	    if ("career".equals(type) && board_career_id!= null) {
	    	board = mypagemapper.findCareerBoardById( board_career_id);
	    } else if ("free".equals(type) && post_idx != null) {
	    	board = mypagemapper.findFreeBoardById(post_idx);
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
	
	 /**
     * 프로필 사진 등록/수정 처리
     */
	@PostMapping("/updateProfileImage")
	public String updateProfileImage(@RequestParam("profileImage") MultipartFile multipartFile,
	                                 HttpSession session,
	                                 RedirectAttributes rttr) {
	    // 1. 로그인 유저 확인
	    MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	    if (loginUser == null) {
	        rttr.addFlashAttribute("profileError", "로그인이 필요합니다.");
	        return "redirect:/login";
	    }

	    // 2. 파일이 비어있지 않으면 처리
	    if (multipartFile != null && !multipartFile.isEmpty()) {
	        try {
	            // 2-1. 확장자 검사 (이미지 파일만 허용)
	            String original = multipartFile.getOriginalFilename();
	            String ext = original.substring(original.lastIndexOf('.')).toLowerCase();
	            String[] allowedExt = {".jpg", ".jpeg", ".png", ".gif", ".webp"};
	            boolean valid = Arrays.stream(allowedExt).anyMatch(e -> ext.equals(e));
	            if (!valid) {
	                rttr.addFlashAttribute("profileError", "이미지 파일(.jpg, .jpeg, .png, .gif, .webp)만 업로드할 수 있습니다.");
	                return "redirect:/MyPage";
	            }

	            // 2-2. 저장할 파일명 생성 (UUID + 확장자)
	            String newName = UUID.randomUUID().toString() + ext;
	            // 2-3. 저장 경로 얻기
	            String uploadDir = session.getServletContext().getRealPath("/resources/img/user_profile/");
	            File dir = new File(uploadDir);
	            if (!dir.exists()) dir.mkdirs();
	            // 2-4. 기존 파일(기본이미지 제외) 삭제
	            String oldPath = loginUser.getUser_profile();
	            if (oldPath != null && !oldPath.isEmpty() && !oldPath.contains("/default/")) {
	                File oldFile = new File(session.getServletContext().getRealPath(oldPath));
	                if (oldFile.exists()) oldFile.delete();
	            }
	            // 2-5. 파일 저장
	            File dest = new File(dir, newName);
	            multipartFile.transferTo(dest);
	            // 2-6. DB에 저장할 경로 (웹 접근 상대경로)
	            String dbPath = "/resources/img/user_profile/" + newName;

	            // 3. DB 업데이트
	            MyPageVO param = new MyPageVO();
	            param.setId(loginUser.getId());
	            param.setUser_profile(dbPath);
	            int result = mypagemapper.updateUserProfile(param);

	            if (result > 0) {
	                // 4. 세션 갱신
	                loginUser.setUser_profile(dbPath);
	                session.setAttribute("loginUser", loginUser);
	                return "redirect:/MyPage";
	            } else {
	                rttr.addFlashAttribute("profileError", "프로필 사진 등록에 실패했습니다. 다시 시도해주세요.");
	                return "redirect:/MyPage";
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            rttr.addFlashAttribute("profileError", "파일 업로드 중 오류가 발생했습니다.");
	            return "redirect:/MyPage";
	        }
	    }

	    // 파일이 비었거나 선택되지 않은 경우
	    rttr.addFlashAttribute("profileError", "선택된 파일이 없습니다.");
	    return "redirect:/MyPage";
	}


	
	
}
