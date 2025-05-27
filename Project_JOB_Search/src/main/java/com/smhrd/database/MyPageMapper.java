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
	//댓글
	int deleteCareerCommentByIdx(@Param("comment_id") int comment_id);
	int deleteFreeCommentByIdx(@Param("cmt_idx") int cmt_idx);
	int updateCareerComment(MyPageVO vo);
	int updateFreeComment(MyPageVO vo);
	MyPageVO findCareerCommentById(Integer comment_id);
	MyPageVO findFreeCommentByIdx(Integer cmt_idx);

	//게시글
	List<MyPageVO> findCareerBoardByUserId(String id);
	List<MyPageVO> findFreeBoardByUserId(String id);
	int deleteCareerBoardById(Integer board_career_id);
	void deleteCareerBoardLikesByCareerId(Integer board_career_id);
	void deleteCareerBoardCommentsByCareerId(Integer board_career_id);
	int deleteFreeBoardById(Integer post_idx);
	void deleteFreeBoardLikesByPostIdx(Integer post_idx);
	void deleteFreeBoardCommentsByPostIdx(Integer post_idx);
	
	MyPageVO findCareerBoardById(Integer board_career_id);
	MyPageVO findFreeBoardById(Integer post_idx);
	int updateCareerBoard(MyPageVO vo);
	int updateFreeBoard(MyPageVO vo);
	
	/** 프로필 사진 관련 */
	int updateUserProfile(MyPageVO param);
	
	
	

	}