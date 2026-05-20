package com.vme50.hospital.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

@Data
@TableName("patient")
public class Patient {
    private Long id;

    private Long user_id;

    private String name;

    private Character gender;

    private String id_number;

    private String phone;

    private String relationship;

    private Character is_default;

    private Date create_time;

}
