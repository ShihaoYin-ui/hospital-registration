package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@TableName("`type`")
@NoArgsConstructor
public class Type {
    private Integer id;

    private String code;

    private String name;

    private Integer parent_id;

    private Integer sort_order;

    private Short status;

}
