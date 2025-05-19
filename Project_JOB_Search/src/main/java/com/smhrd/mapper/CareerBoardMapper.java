package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.CareerBoardVO;


@Mapper
public interface CareerBoardMapper {
	
	
	public List<CareerBoardVO> select();
	
	public void insert(CareerBoardVO vo);

	public CareerBoardVO selectOne(int boardCareerId);
	
	public List<CareerBoardVO> selectWithCommentCount();

	public int update(CareerBoardVO vo);
	
	void delete(int boardCareerId);
}
