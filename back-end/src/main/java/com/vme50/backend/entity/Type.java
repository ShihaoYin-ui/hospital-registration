package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
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

    @TableField("parent_id")
    private Integer parentId;

    @TableField("sort_order")
    private Integer sortOrder;

    private Short status;
}
