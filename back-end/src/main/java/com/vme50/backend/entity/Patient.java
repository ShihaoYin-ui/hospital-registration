package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("patient")
@NoArgsConstructor
public class Patient {
    private Long id;

    @TableField("user_id")
    private Long userId;

    private String name;

    private Character gender;

    @TableField("id_number")
    private String idNumber;

    private String phone;

    private String relationship;

    @TableField("is_default")
    private Character isDefault;

    @TableField("create_time")
    private Date createTime;

}