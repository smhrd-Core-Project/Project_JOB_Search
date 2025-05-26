package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.JobVO;
import com.smhrd.model.MajorVO;

@Mapper
public interface MyPageSearchReultMapper {

	// 1. 유저 아이디로 추천전공 문자열 가져오기
    String selectRecommendedMajors(String user_id);

    // 2. 전공명 리스트로 상세정보 가져오기
    List<MajorVO> selectMajorInfoList(List<String> majorList);

    
	List<JobVO> selectTop5JobsByMajorIdx(int majorIdx);

	// 유저 토큰 찾기 
	String selectUserIdByToken(String token);

	 // 토큰 저장 메서드(공유 최초 생성용, 필요 시)
    int updateShareToken(@Param("userId") String userId, @Param("shareToken") String shareToken);

	String selectUserNameByUserId(String token);

	
	

}
