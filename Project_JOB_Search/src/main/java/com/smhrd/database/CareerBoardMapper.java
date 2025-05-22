package com.smhrd.database;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.smhrd.model.CareerBoardVO;


@Mapper
public interface CareerBoardMapper {
	
	
	public List<CareerBoardVO> select();
	
	public void insert(CareerBoardVO vo);

	public CareerBoardVO selectOne(int boardCareerId);
	
	public List<CareerBoardVO> selectWithCommentCount();

	public int update(CareerBoardVO vo);
	
	void delete(int boardCareerId);
	
	//게시글 좋아요기능
	int increaseLikes(int boardCareerId);
	int decreaseLikes(int boardCareerId);
	int getLikes(int boardCareerId);

	int increaseViews(int boardCareerId);
	
	 // 전체 게시글 수 조회용
	List<CareerBoardVO> selectPaged(@Param("start") int start, @Param("end") int end);
	int countBoards();

	// 메인 출력용
	public List<CareerBoardVO> Main_selectPaged();
}
