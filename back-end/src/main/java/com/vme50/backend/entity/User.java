package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("user")
@NoArgsConstructor
public class User {
    private Long id;

    private String id_number;

    private String name;

    private Character gender;

    private Date birth_date;

    private String phone;

    private String native_place;

    private String address;

    private String email;

    private String password;

    private Short status;


}
