package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("doctor")
@NoArgsConstructor
public class Doctor {
    private Long id;
    private String code;
    private String name;
    private Character gender;

    @TableField("birth_date")
    private Date birthDate;

    @TableField("dept_id")
    private Long deptId;

    private Integer title;
    private Short level;
    private String specialty;

    @TableField("practice_years")
    private Integer practiceYears;

    @TableField("pol_status")
    private String polStatus;

    private String education;
    private String resume;
    private String phone;
    private String email;

    @TableField("sort_order")
    private Integer sortOrder;

    private Short status;
}
