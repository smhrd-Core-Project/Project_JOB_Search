package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.CareerBoardVO;


@Mapper
public interface CareerBoardMapper {
	
	public List<CareerBoardVO> select();
}
