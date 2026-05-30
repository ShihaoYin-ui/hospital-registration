package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@TableName("department")
@NoArgsConstructor
public class Department {
    private Long id;
    private String code;
    private String name;
    @TableField("type_id")
    private Integer type;
    private Integer level;
    @TableField("intro")
    private String introduction;

    @TableField("leader_id")
    private Long leaderId;

    private String phone;
    private String location;

    @TableField("sort_order")
    private Integer sortOrder;

    private Short status;
}
