package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 

public class FreeBoardVO {

	private String post_idx;
	private String title;
	private String content;
	private String id;
	private int views;
	private int likes;
	private int comments;

	
}
