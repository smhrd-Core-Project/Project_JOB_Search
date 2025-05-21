package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.model.FreeBoardCommentVO;

@Mapper
public interface FreeBoardCommentMapper {
	
    public List<FreeBoardCommentVO> selectByPostIdx(int post_idx);
    public void insert(FreeBoardCommentVO vo);
}