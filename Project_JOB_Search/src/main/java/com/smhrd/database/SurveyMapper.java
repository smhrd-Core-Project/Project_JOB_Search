package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper
public interface SurveyMapper {

	public List<String> getRandomSurveys();

	public List<String> getRandomSurveysByGroup(String group);

	 /**
     * 재탐색 시 기존 로그를 업데이트 합니다.
     * @param id                회원 아이디
     * @param recombinedMajors  쉼표로 이은 추천 전공 문자열
     */
    void user_relog(@Param("id") String id,
                      @Param("recombinedMajors") String recombinedMajors);

	
	
}
