package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smhrd.model.CareerBoardCommentVO;

public interface CareerBoardCommentMapper {
	
	public void insertComment(CareerBoardCommentVO vo);
    public List<CareerBoardCommentVO> selectComments(int boardCareerId);
    void deleteComments(int boardCareerId);
    
    int updateComment(CareerBoardCommentVO vo);
    int deleteComment(@Param("commentId") int commentId, @Param("id") String id);
    
}
