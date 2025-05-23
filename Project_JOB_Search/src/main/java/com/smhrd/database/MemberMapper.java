package com.smhrd.database;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.MemberVO;

@Mapper
public interface MemberMapper {
	
	
	
    public void join(MemberVO vo);

	public int checkId(String email);

	public int checkEmail(String email);

	public MemberVO login(MemberVO vo);
    
    public void update(MemberVO vo);
    
    public void deleteUser(MemberVO vo);
    
}