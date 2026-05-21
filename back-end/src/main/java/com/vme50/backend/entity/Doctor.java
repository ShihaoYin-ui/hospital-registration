package com.vme50.backend.entity;

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

    private Date birth_date;

    private Long dept_id;

    private Integer tittle;

    private Short level;

    private String speciality;

    private Integer practice_years;

    private String pol_status;

    private String education;

    private String resume;

    private String phone;

    private String email;

    private Integer sort_order;

    private Short status;

}
