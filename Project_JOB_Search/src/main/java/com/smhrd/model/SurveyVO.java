package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor // 모든 매개변수를 받아 필드 초기화하는 생성자
@NoArgsConstructor // 기본 생성자
public class SurveyVO {
	
	private String survey_content;
	private String survey_group;
	
}
