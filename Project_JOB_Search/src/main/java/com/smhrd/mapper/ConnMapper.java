package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.ConnVO;

@Mapper
public interface ConnMapper {
	public List<ConnVO> select();
}
