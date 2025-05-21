package com.smhrd.model;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor 
public class CareerBoardVO {

	
	private Long boardCareerId;
    private String id;
    private String title;
    private String content;
    private String careerTopic;
    private String relatedMajor;
    private String questionType;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int views;
    private String isDeleted;
    private int likes;
    private int comments;
}
