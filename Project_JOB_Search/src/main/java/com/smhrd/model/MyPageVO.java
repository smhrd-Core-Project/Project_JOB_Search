package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 

public class MyPageVO {
	private int comment_id;
	private int cmt_idx;
	private String content;
	private String cmt_content;
    private String id;
    
	private int post_idx;
	private String title;
	private int views;
	private int likes;
	private int comments;
	
    
   
}