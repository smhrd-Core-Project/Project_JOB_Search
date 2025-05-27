package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.MajorVO;
import com.smhrd.model.MemberVO;

@Mapper
public interface MemberMapper {
	
	
	
    public void join(MemberVO vo);

	public int checkId(String email);

	public int checkEmail(String email);

	public MemberVO login(MemberVO vo);

	public void insertUser(MemberVO vo);

	public MemberVO selectByEmail(String email);

	public MemberVO selectById(String id);

	public String findIdByNameEmail(MemberVO vo);

	public int updatePassword(MemberVO vo);

	public MemberVO findPassword(MemberVO vo);

    
    public void update(MemberVO vo);
    
    public void deleteUser(MemberVO vo);

    /** 추천된 학과만 가져오기 */
	public String min_major(String user_id);

	public String MAJOR_DIVISION(String firstMajor);
	
	
	 /**
     * 사용자 ID별로 추천 전공(콤마 구분) 로그 저장
     * @param id             회원 아이디
     * @param majorsCombined "문과,이과,예체능" 처럼 쉼표로 이은 3개 전공
     */
    void user_log(@Param("id") String id,
                  @Param("majorsCombined") String majorsCombined);
	
    
}