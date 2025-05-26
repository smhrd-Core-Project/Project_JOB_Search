package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.FreeBoardCommentVO;

@Mapper
public interface FreeBoardCommentMapper {
	
    public List<FreeBoardCommentVO> selectByPostIdx(int post_idx);
    public void insert(FreeBoardCommentVO vo);
	public void increaseComment(int post_idx);

	public int deleteComment(@Param("cmt_idx") int cmt_idx);
	//public int editComment(String cmt_idx, String cmt_content);
	public int editComment(FreeBoardCommentVO comment);

}