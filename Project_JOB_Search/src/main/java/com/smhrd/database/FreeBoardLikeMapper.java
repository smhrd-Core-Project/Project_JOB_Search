package com.smhrd.database;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.FreeBoardVO;

@Mapper
public interface FreeBoardLikeMapper {
	 public int checkLike(@Param("post_idx") int post_idx, @Param("id") String id);
	 public void insertLike(@Param("post_idx") int post_idx, @Param("id") String id);
	 public void deleteLike(@Param("post_idx") int post_idx, @Param("id") String id);
	 public int countLikes(@Param("post_idx") int post_idx);

	

}