package com.smhrd.controller;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

import com.smhrd.database.CareerBoardMapper;
import com.smhrd.database.FreeBoardMapper;
import com.smhrd.database.MemberMapper;
import com.smhrd.model.CareerBoardVO;
import com.smhrd.model.FreeBoardVO;
import com.smhrd.model.MajorVO;
import com.smhrd.model.MemberVO;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class LoginController {

    @Autowired
    MemberMapper mapper;
    
    @Autowired
	CareerBoardMapper C_mapper;
    
    @Autowired
	FreeBoardMapper F_mapper;
    
    // 프로젝트 시작 시 메인페이지로 바로 이동!
    @GetMapping("/")
    public String home() {
        return "main"; 
    }
    

    @RequestMapping("/Login")
	public String member() {

		return "Login";
	}
    
    @PostMapping("/login")
    @ResponseBody
    public Map<String, Object> login(@RequestBody MemberVO vo, HttpSession session) {
        Map<String, Object> result = new HashMap<>();

        // 1. ID로만 사용자 정보 조회
        MemberVO memberVo = mapper.selectById(vo.getId()); // id만으로 조회하는 메서드 필요

        if (memberVo != null) {
            // 2. 입력한 평문 비밀번호 vs DB의 암호화된 비밀번호 비교
            BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
            if (encoder.matches(vo.getPassword(), memberVo.getPassword())) {
                session.setAttribute("loginUser", memberVo);
                result.put("success", true);
                result.put("userName", memberVo.getName());
            } else {
                result.put("success", false);
                result.put("message", "비밀번호가 일치하지 않습니다.");
            }
        } else {
            result.put("success", false);
            result.put("message", "존재하지 않는 사용자입니다.");
        }

        return result;
    }
    
    // 세션을 초기화하는 로그아웃
    @GetMapping("/Logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";  
    }
    
    
    // 로그인 임시 확인 창 (추후에는 삭제)
    @RequestMapping("/loginSuccess")
    public String loginSuccess(HttpSession session, Model model) {
        MemberVO loginUser = (MemberVO) session.getAttribute("loginUser");
        
        String user_id = loginUser.getId();
        
        String min_major = (String) mapper.min_major(user_id);

        // 컴마로 분리
        String[] majors = (min_major != null) 
            ? min_major.split("\\s*,\\s*")  // 공백 허용
            : new String[0];
        
	     // 각 순위별로 분리
	        String firstMajor  = majors.length > 0 ? majors[0] : "";
	        String secondMajor = majors.length > 1 ? majors[1] : "";
	        String thirdMajor  = majors.length > 2 ? majors[2] : "";
	        
	        model.addAttribute("firstMajor",  firstMajor);
	        model.addAttribute("secondMajor", secondMajor);
	        model.addAttribute("thirdMajor",  thirdMajor);
	        
	        String divsi = mapper.MAJOR_DIVISION(firstMajor);

	        if (divsi != null && divsi.length() > 2) {
	            divsi = divsi.substring(0, divsi.length() - 2);
	        }
	        session.setAttribute("major_type", divsi);
	        
    
        List<FreeBoardVO> list_F = F_mapper.Main_select();
        

        List<CareerBoardVO> list_C = C_mapper.Main_selectPaged();

       
        
        if(list_F!=null) {
        	model.addAttribute("list_F", list_F);
        	model.addAttribute("list_C", list_C);
        	model.addAttribute("min_major", min_major);
        } else {
        	String error = "정보가 없습니다!";
        	System.err.println(error);
        }

        if (loginUser != null) {
            model.addAttribute("name", loginUser.getName());
            return "loginSuccess"; // loginSuccess.jsp로 이동
        } else {
            return "redirect:/Login";
        }

    }
    
    
    
//    @GetMapping("/naverCallback")
//    @ResponseBody // 응답을 View가 아닌, 직접 문자열로 보내기 위해 추가
//    public String naverCallback(@RequestParam(required = false) String code, // 테스트를 위해 파라미터를 필수가 아니도록 변경
//                               @RequestParam(required = false) String state,
//                               HttpSession session) {
//        System.out.println("--- NAVER CALLBACK METHOD REACHED ---");
//        System.out.println("Code: " + code + ", State: " + state);
//        return "Naver Callback Test Reached! Code: " + code; // 브라우저에 이 메시지가 보이면 성공
//    }
    
    
    // 네이버 로그인 기능 구현
    @GetMapping("/naverCallback")
    public String naverCallback(@RequestParam String code, @RequestParam String state, HttpSession session) {
        String clientId = "HQtWXqb3kJJoNO1pP8Md";    
        String clientSecret = "WzJ4MJf4vL";      
        String redirectURI = "http://localhost:8083/web/naverCallback"; 

        try {
            // 1. Access Token 요청
            String tokenApiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                    + "&client_id=" + clientId
                    + "&client_secret=" + clientSecret
                    + "&redirect_uri=" + redirectURI
                    + "&code=" + code
                    + "&state=" + state;

            URL tokenUrl = new URL(tokenApiURL);
            HttpURLConnection tokenConnection = (HttpURLConnection) tokenUrl.openConnection();
            tokenConnection.setRequestMethod("GET");

            BufferedReader tokenReader = new BufferedReader(new InputStreamReader(tokenConnection.getInputStream()));
            StringBuilder tokenResponse = new StringBuilder();
            String line;
            while ((line = tokenReader.readLine()) != null) {
                tokenResponse.append(line);
            }
            tokenReader.close();

            JSONParser parser = new JSONParser();
            JSONObject tokenJson = (JSONObject) parser.parse(tokenResponse.toString());
            String accessToken = (String) tokenJson.get("access_token");

            if (accessToken == null) {
                System.err.println("네이버 Access Token을 받지 못했습니다. 응답: " + tokenResponse.toString());
                return "redirect:/Login?error=naver_token_error";
            }

            // 2. 사용자 프로필 정보 요청
            URL profileApiUrl = new URL("https://openapi.naver.com/v1/nid/me");
            HttpURLConnection profileConnection = (HttpURLConnection) profileApiUrl.openConnection();
            profileConnection.setRequestMethod("GET");
            profileConnection.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader profileReader = new BufferedReader(new InputStreamReader(profileConnection.getInputStream()));
            StringBuilder profileResponse = new StringBuilder();
            while ((line = profileReader.readLine()) != null) {
                profileResponse.append(line);
            }
            profileReader.close();

            JSONObject profileJsonBody = (JSONObject) parser.parse(profileResponse.toString());
            JSONObject profileData = (JSONObject) profileJsonBody.get("response");

            if (profileData == null) {
                System.err.println("네이버 프로필 정보를 받지 못했습니다. 응답: " + profileResponse.toString());
                return "redirect:/Login?error=naver_profile_error";
            }

            // 3. 네이버 유저 정보 추출
            String email = (String) profileData.get("email");
            String name = (String) profileData.get("name");
            String gender = (String) profileData.get("gender");
            String phone = ((String) profileData.get("mobile")).replaceAll("-", "");
            String naverUniqueId = (String) profileData.get("id");

            System.out.println("네이버 유저 정보: " + profileData.toJSONString());

            // 4. 기존 사용자 존재 여부 확인 → 자동 로그인
            MemberVO existingUser = mapper.selectByEmail(email);
            if (existingUser != null) {
                session.setAttribute("loginUser", existingUser);
                return "redirect:/loginSuccess";
            }

            // 5. 신규 사용자 → 회원가입 정보 세션 설정
            MemberVO userInfoForSignup = new MemberVO();
            userInfoForSignup.setEmail(email);
            userInfoForSignup.setName(name);
            userInfoForSignup.setGender(gender);
            userInfoForSignup.setPhone_number(phone);
            userInfoForSignup.setUser_sns("y");

            session.setAttribute("pendingNaverUniqueId", naverUniqueId);
            session.setAttribute("naverJoinInfo", userInfoForSignup);

            return "redirect:/Signup";

        } catch (Exception e) {
            System.err.println("네이버 연동 중 오류 발생: " + e.getMessage());
            e.printStackTrace(); 
            return "redirect:/Login?error=naver_link_failed";
        }
    }


    
    
    
    
    
    @PostMapping("/register")
    public String register(MemberVO vo, HttpSession session) {
        MemberVO existing = mapper.selectByEmail(vo.getEmail());

        if (existing != null) {
            session.setAttribute("loginUser", existing);
            session.removeAttribute("naverJoinInfo");
            return "redirect:/loginSuccess";
        }

        // 비밀번호 암호화
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encodedPassword = encoder.encode(vo.getPassword());
        vo.setPassword(encodedPassword);

        mapper.join(vo);
        session.setAttribute("loginUser", vo);
        return "redirect:/loginSuccess";
    }
    
}
