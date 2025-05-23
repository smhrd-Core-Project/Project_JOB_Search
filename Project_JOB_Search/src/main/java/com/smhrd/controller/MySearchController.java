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
	  public String MySearchResult(HttpSession session) {
        // 1) 로그인 사용자 체크
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/login";
        }
        String user_id = loginUser.getId();
        System.out.println("유저 아이디 확인: " + user_id);

        // 2) 추천 전공명 문자열 조회
        String majorsStr = MyPageSerch_result.selectRecommendedMajors(user_id);
        List<MajorVO> sortedList = null;

        if (majorsStr != null) {
            // 2-1) 콤마로 분리
            List<String> majorNames = Arrays.stream(majorsStr.split(","))
                                            .map(String::trim)
                                            .collect(Collectors.toList());

            // 2-2) DB에서 상세 전공 정보 조회
            List<MajorVO> majorInfoList = MyPageSerch_result.selectMajorInfoList(majorNames);
            if (majorInfoList != null) {
                // 2-3) 추천 순서대로 리스트 정렬
                sortedList = majorNames.stream()
                    .map(name -> majorInfoList.stream()
                        .filter(m -> name.equals(m.getMajorName()))
                        .findFirst()
                        .orElse(null))
                    .collect(Collectors.toList());

                // 2-4) 세션에 저장
                session.setAttribute("Myresult_major", sortedList);
            } else {
                System.out.println("전공 정보를 찾을 수 없습니다");
            }
        } else {
            System.out.println("추천 받은 전공이 없습니다");
        }

        // 3) 혹시 sortedList가 null 이면, 세션에서 꺼내오기
        if (sortedList == null) {
            sortedList = (List<MajorVO>) session.getAttribute("Myresult_major");
        }

     // 4) 전공별 TOP3 직업 조회 → 순위별 Map(Integer 키)로 분리
        if (sortedList != null) {
            Map<Integer, JobVO> firstJobMap  = new LinkedHashMap<>();
            Map<Integer, JobVO> secondJobMap = new LinkedHashMap<>();
            Map<Integer, JobVO> thirdJobMap  = new LinkedHashMap<>();

            for (MajorVO major : sortedList) {
                if (major != null) {
                    int key = major.getMajorIdx();
                    List<JobVO> jobs = MyPageSerch_result.selectTop5JobsByMajorIdx(key);

                    // 1순위
                    if (!jobs.isEmpty()) {
                        firstJobMap.put(key, jobs.get(0));
                    }
                    // 2순위
                    if (jobs.size() > 1) {
                        secondJobMap.put(key, jobs.get(1));
                    }
                    // 3순위
                    if (jobs.size() > 2) {
                        thirdJobMap.put(key, jobs.get(2));
                    }

                }
            }

            session.setAttribute("firstJobMap",  firstJobMap);
            session.setAttribute("secondJobMap", secondJobMap);
            session.setAttribute("thirdJobMap",  thirdJobMap);
        }


        // 5) 결과 뷰 리턴
        return "MyLogResult";
    }
}

