package com.smhrd.database;

import java.sql.Date;
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

	public int editComment(FreeBoardCommentVO comment);
	public int countByPostIdx(int post_idx);
	public void updatetime(FreeBoardCommentVO comment);
	
		
	

}