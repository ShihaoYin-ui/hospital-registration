package com.vme50.hospital.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("type")
public class Type {
    private Integer id;

    private String code;

    private String name;

    private Integer parent_id;

    private Integer sort_order;

    private Short status;

}
