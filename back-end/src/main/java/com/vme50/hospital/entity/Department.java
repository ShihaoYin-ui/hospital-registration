package com.vme50.hospital.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("department")
public class Department {
    private Long id;

    private String code;

    private String name;

    private Integer type;

    private Integer level;

    private String introduction;

    private Long leader_id;

    private String phone;

    private String location;

    private Integer sort_order;

    private Short status;

}
