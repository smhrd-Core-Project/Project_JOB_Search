package com.smhrd.database;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.FreeBoardVO;

@Mapper
public interface FreeBoardMapper {

	public List<FreeBoardVO> select();
	
	public List<FreeBoardVO> Main_select();
	
	public void insert(FreeBoardVO vo);

	public FreeBoardVO selectOne(@Param("post_idx") int post_idx);


	public List<FreeBoardVO> getPageList(Map<String, Integer> map);

	int getCount();

	
	 int checkLike(@Param("post_idx") int post_idx, @Param("id") String id);

	 void insertLike(@Param("post_idx") int post_idx, @Param("id") String id);

	 void deleteLike(@Param("post_idx") int post_idx, @Param("id") String id);

	  int countLikes(@Param("post_idx") int post_idx);
	  
	  void incrementLikeCount(@Param("post_idx") int post_idx);
	  void decrementLikeCount(@Param("post_idx") int post_idx);


	  void incrementCommentCount(@Param("post_idx") int post_idx);
	  void decrementCommentCount(@Param("post_idx") int post_idx);

	public int deleteComment(String id);

	public void incrementViewsCount(int post_idx);

	public int updateComment(String cmt_idx, String cmt_content);

	public int deleteComment(int commentId, String id);


	
}

	

