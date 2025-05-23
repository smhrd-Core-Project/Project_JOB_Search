package com.smhrd.model;

import org.springframework.beans.factory.annotation.Autowired;

import com.smhrd.database.FreeBoardMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 

public class FreeBoardVO {

	private int post_idx;
	private String title;
	private String content;
	private String id;
	private int views;
	private int likes;
	private int comments;


}