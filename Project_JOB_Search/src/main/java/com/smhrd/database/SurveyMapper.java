package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.beans.factory.annotation.Autowired;

@Mapper
public interface SurveyMapper {

	public List<String> getRandomSurveys();

	public List<String> getRandomSurveysByGroup(String group);

	
	
}
