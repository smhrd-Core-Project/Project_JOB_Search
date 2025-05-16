package com.smhrd.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.FreeBoardCommentVO;

@Mapper
public interface FreeBoardCommentMapper {
    public static List<FreeBoardCommentVO> selectByPostIdx(int post_idx) {
		// TODO Auto-generated method stub
		return null;
	}
    public static void insert(FreeBoardCommentVO vo) {
		// TODO Auto-generated method stub
		
	}
}