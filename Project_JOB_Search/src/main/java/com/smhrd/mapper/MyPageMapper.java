package com.smhrd.mapper;

import java.util.List;

import com.smhrd.model.MyPageVO;

public interface MyPageMapper {

	 List<MyPageVO> findCareerCommentsByUserId(String id);
	 List<MyPageVO> findFreeCommentsByUserId(String id);
	}