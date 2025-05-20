package com.smhrd.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor 

public class MyPageVO {
    private int cmt_idx;
    private String id;
    private String cmt_content;
}