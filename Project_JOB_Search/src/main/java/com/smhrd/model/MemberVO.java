package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor // 모든 매개변수를 받아 필드 초기화하는 생성자
@NoArgsConstructor // 기본 생성자
public class MemberVO {

	private String id;
	private String name;
	private String email;
	private String password;
	private String school;
	private String gender;
	private int grade;
	private String phone_number;
	private String user_sns;
	
	
	private String User_profile;
	
	private String ShareToke;
	
	
	private String major1;
	private String major2;
	private String major3;
	
	
	

	public String getShareToken() {
		// TODO Auto-generated method stub
		return null;
	}

	public void setShareToken(String shareToken) {
		// TODO Auto-generated method stub
		
	}


}
