package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("user")
@NoArgsConstructor
public class User {
    private Long id;

    @TableField("id_number")
    private String idNumber;

    private String name;

    private Character gender;

    @TableField("birth_date")
    private Date birthDate;

    private String phone;

    @TableField("native_place")
    private String nativePlace;

    private String address;

    private String email;

    @JsonProperty(access = JsonProperty.Access.WRITE_ONLY)
    @TableField("password")
    private String password;

    private Short status;

}
