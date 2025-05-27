package com.smhrd.model;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 
public class FreeBoardCommentVO {
    private int cmt_idx;
    private int post_idx;
    private String cmt_content;
    private String id;
    private Date created_at;

}
