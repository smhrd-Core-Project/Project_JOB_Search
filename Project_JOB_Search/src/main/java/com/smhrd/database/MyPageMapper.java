package com.smhrd.database;

import java.util.List;
import java.util.Map;

import javax.xml.stream.events.Comment;

import org.apache.ibatis.annotations.Param;

import com.smhrd.model.FreeBoardCommentVO;
import com.smhrd.model.MyPageVO;

public interface MyPageMapper {

	List<MyPageVO> findCareerCommentsByUserId(String id);
	List<MyPageVO> findFreeCommentsByUserId(String id);
	int deleteCareerCommentByIdx(@Param("comment_id") int comment_id);
	int deleteFreeCommentByIdx(@Param("cmt_idx") int cmt_idx);
	int updateCareerComment(MyPageVO vo);
	int updateFreeComment(MyPageVO vo);
	MyPageVO findCareerCommentById(Integer comment_id);
	MyPageVO findFreeCommentByIdx(Integer cmt_idx);
	
	
	

	}