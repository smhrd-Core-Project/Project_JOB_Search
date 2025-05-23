package com.smhrd.model;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MajorVO {
	 // 전공 식별자 전공 식별자
    private int majorIdx;

    // 전공 명 전공 명
    private String majorName;

    // 전공 계열 (문과/이과/예체능) 전공 계열 (문과/이과/예체능)
    private String majorDivision;

    // 전공 설명 전공 설명
    private String majorDescription;

    // 개설 대학 개설 대학
    private String university;

 
    // 전공 스킬 
    private String majorSkill;

    // 전공_공통과목 
    private String commonSubj;

    // 전공_일반과목 
    private String noMarlSubj;

    // 전공_진로선택과목 
    private String careerSelec;

    // 전공 계열 (생명/의학) 
    private String majorIclass;
    
    // 등록 일자 등록 일자
    private Timestamp createdAt;
}
