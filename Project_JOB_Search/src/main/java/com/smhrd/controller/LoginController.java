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
	private CareerBoardMapper C_mapper;
    
    @Autowired
	FreeBoardMapper F_mapper;
    
    // 프로젝트 시작 시 메인페이지로 바로 이동
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
    
        List<FreeBoardVO> list_F = F_mapper.Main_select();
        

        List<CareerBoardVO> list_C = C_mapper.Main_selectPaged();
        
      
        if(list_F!=null) {
        	model.addAttribute("list_F", list_F);
        	model.addAttribute("list_C", list_C);
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
    
    
    
    
    
    @GetMapping("/naverCallback")
    public String naverCallback(@RequestParam String code, @RequestParam String state, HttpSession session) {
        String clientId = "HQtWXqb3kJJoNO1pP8Md";
        String clientSecret = "WzJ4MJf4vL";
        String redirectURI = "http://localhost:8083/naverCallback";

        String tokenURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code"
                + "&client_id=" + clientId
                + "&client_secret=" + clientSecret
                + "&redirect_uri=" + redirectURI
                + "&code=" + code
                + "&state=" + state;

        try {
            // Access Token 요청
            URL url = new URL(tokenURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");

            BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            StringBuilder response = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                response.append(line);
            }
            br.close();

            JSONParser parser = new JSONParser();
            JSONObject tokenJson = (JSONObject) parser.parse(response.toString());
            String accessToken = (String) tokenJson.get("access_token");

            // 사용자 정보 요청
            URL profileUrl = new URL("https://openapi.naver.com/v1/nid/me");
            HttpURLConnection profileCon = (HttpURLConnection) profileUrl.openConnection();
            profileCon.setRequestMethod("GET");
            profileCon.setRequestProperty("Authorization", "Bearer " + accessToken);

            BufferedReader profileReader = new BufferedReader(new InputStreamReader(profileCon.getInputStream()));
            StringBuilder profileResponse = new StringBuilder();
            while ((line = profileReader.readLine()) != null) {
                profileResponse.append(line);
            }
            profileReader.close();

            JSONObject profileJson = (JSONObject) parser.parse(profileResponse.toString());
            JSONObject res = (JSONObject) profileJson.get("response");

            // 필요한 사용자 정보만 추출
            String id = (String) res.get("id");
            String name = (String) res.get("name");
            String email = (String) res.get("email");
            String gender = (String) res.get("gender");

            // MemberVO에 저장
            MemberVO user = new MemberVO();
            user.setId(id);
            user.setName(name);
            user.setEmail(email);
            user.setGender(gender);

            session.setAttribute("naverJoinInfo", user);
            return "redirect:/Signup";

        } catch (Exception e) {
            e.printStackTrace();
            return "redirect:/Login?error=naver";
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
