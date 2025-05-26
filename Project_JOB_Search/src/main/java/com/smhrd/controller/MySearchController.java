package com.smhrd.controller;

import java.util.Arrays;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.smhrd.database.MyPageSearchReultMapper;
import com.smhrd.model.JobVO;
import com.smhrd.model.MajorVO;
import com.smhrd.model.MemberVO;

@Controller
public class MySearchController {

	@Autowired
	private MyPageSearchReultMapper MyPageSerch_result;

	@SuppressWarnings("unchecked")
	@RequestMapping("/MySearch_result")
	public String MySearchResult(HttpSession session, HttpServletRequest request) {
	    String token = request.getParameter("token");
	    String user_id = null;
	    String shareToken = null;

	    if (token != null && !token.isEmpty()) {
	        // 공유 토큰 조회
	        user_id = MyPageSerch_result.selectUserIdByToken(token);
	        if (user_id == null) {
	            return "redirect:/errorShare"; // 안내 페이지로 리다이렉트!
	        }
	        shareToken = token; // 그대로 사용
	     // 이름도 함께 전달
	        String shareUserName = MyPageSerch_result.selectUserNameByUserId(user_id);
	        
	        session.setAttribute("shareUserName", shareUserName);
	    } else {
	        // 로그인 사용자
	        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
	        if (loginUser == null) {
	            return "redirect:/login";
	        }
	        user_id = loginUser.getId();

	        // ★ 공유 토큰이 없으면 자동 생성/저장
	        shareToken = loginUser.getShareToken();
	        if (shareToken == null || shareToken.isEmpty()) {
	            shareToken = java.util.UUID.randomUUID().toString();
	            MyPageSerch_result.updateShareToken(user_id, shareToken);
	            loginUser.setShareToken(shareToken); // 세션객체에도 반영
	            session.setAttribute("loginUser", loginUser);
	        }
	    }

	    // (JSP에서 ${shareToken}으로 접근할 수 있도록 request에 저장)
	    request.setAttribute("shareToken", shareToken);

	    // 이하 기존 코드 동일
	    String majorsStr = MyPageSerch_result.selectRecommendedMajors(user_id);
	    List<MajorVO> sortedList = null;

	    if (majorsStr != null) {
	        List<String> majorNames = Arrays.stream(majorsStr.split(","))
	                                        .map(String::trim)
	                                        .collect(Collectors.toList());
	        List<MajorVO> majorInfoList = MyPageSerch_result.selectMajorInfoList(majorNames);
	        if (majorInfoList != null) {
	            sortedList = majorNames.stream()
	                .map(name -> majorInfoList.stream()
	                    .filter(m -> name.equals(m.getMajorName()))
	                    .findFirst()
	                    .orElse(null))
	                .collect(Collectors.toList());
	            session.setAttribute("Myresult_major", sortedList);
	        }
	    }
	    if (sortedList == null) {
	        sortedList = (List<MajorVO>) session.getAttribute("Myresult_major");
	    }
	    if (sortedList != null) {
	        Map<Integer, JobVO> firstJobMap  = new LinkedHashMap<>();
	        Map<Integer, JobVO> secondJobMap = new LinkedHashMap<>();
	        Map<Integer, JobVO> thirdJobMap  = new LinkedHashMap<>();

	        for (MajorVO major : sortedList) {
	            if (major != null) {
	                int key = major.getMajorIdx();
	                List<JobVO> jobs = MyPageSerch_result.selectTop5JobsByMajorIdx(key);
	                if (!jobs.isEmpty()) {
	                    firstJobMap.put(key, jobs.get(0));
	                }
	                if (jobs.size() > 1) {
	                    secondJobMap.put(key, jobs.get(1));
	                }
	                if (jobs.size() > 2) {
	                    thirdJobMap.put(key, jobs.get(2));
	                }
	            }
	        }
	        session.setAttribute("firstJobMap",  firstJobMap);
	        session.setAttribute("secondJobMap", secondJobMap);
	        session.setAttribute("thirdJobMap",  thirdJobMap);
	    }

	    // 결과 뷰에서 공유 토큰 접근 가능
	    return "MyLogResult";
	}


}

