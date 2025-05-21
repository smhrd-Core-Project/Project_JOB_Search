package com.smhrd.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 
public class CareerBoardCommentVO {

	private int commentId;
	private int boardCareerId;
	private String content;
	private LocalDateTime createdAt;
	private String id;
	
}
