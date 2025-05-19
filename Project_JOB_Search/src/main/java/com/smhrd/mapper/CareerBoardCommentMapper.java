package com.smhrd.mapper;

import java.util.List;
import com.smhrd.model.CareerBoardCommentVO;

public interface CareerBoardCommentMapper {
	
	public void insertComment(CareerBoardCommentVO vo);
    public List<CareerBoardCommentVO> selectComments(int boardCareerId);
    void deleteComments(int boardCareerId);
    
}
