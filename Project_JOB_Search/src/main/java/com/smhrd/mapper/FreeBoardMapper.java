package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.FreeBoardVO;

@Mapper
public interface FreeBoardMapper {

	public List<FreeBoardVO> select();
	
	public void insert(FreeBoardVO vo);

	public FreeBoardVO selectOne(int post_idx);



	
}
