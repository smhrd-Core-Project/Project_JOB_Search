package com.smhrd.model;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

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
	
	public String getCreatedAtStr() {
        if (createdAt != null) {
            return createdAt.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));
        }
        return "";
    }
	
}
