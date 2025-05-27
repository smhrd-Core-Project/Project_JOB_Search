package com.smhrd.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface CareerBoardLikeMapper {
	
	 int checkLiked(@Param("boardId") int boardId, @Param("userId") String userId);
	 int insertLike(@Param("boardId") int boardId, @Param("userId") String userId);
	 int deleteLike(@Param("boardId") int boardId, @Param("userId") String userId);
	 int deleteByBoardCareerId(int boardCareerId);
	
	
}
