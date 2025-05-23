package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

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
	
    
}