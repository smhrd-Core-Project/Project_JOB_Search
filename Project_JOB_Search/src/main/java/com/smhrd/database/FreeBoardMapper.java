package com.smhrd.database;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.FreeBoardVO;

@Mapper
public interface FreeBoardMapper {

	public List<FreeBoardVO> select();
	
	public List<FreeBoardVO> Main_select();
	
	public void insert(FreeBoardVO vo);

	public FreeBoardVO selectOne(int post_idx);


	public List<FreeBoardVO> getPageList(Map<String, Integer> map);

	int getCount();






	
}

	

