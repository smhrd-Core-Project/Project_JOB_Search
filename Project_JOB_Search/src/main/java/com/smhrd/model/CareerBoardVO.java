package com.smhrd.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@AllArgsConstructor
@NoArgsConstructor 
public class CareerBoardVO {

	
	private int boardCareerId;
    private String id;
    private String title;
    private String content;
    private String careerTopic;
    private String relatedMajor;
    private String questionType;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private int views;
    private int likes;
    private int comments;
    private boolean liked;
    
    public String getCreatedAtStr() {
        if (createdAt != null) {
            return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        }
        return "";
    }
   

    
}
