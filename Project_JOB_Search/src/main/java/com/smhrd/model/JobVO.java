package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 
public class JobVO {

 // 직업 명 직업 명
 private String jobName;

 // 직업 설명 직업 설명
 private String jobDesc;

 // 평균 연봉 평균 연봉
 private String jobSalary;

 // 필수 스킬 필수 스킬
 private String requiredSkills;

 // 자격증 
 private String jobQualifications;




}