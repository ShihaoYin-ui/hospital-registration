package com.vme50.hospital.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("appointment")
public class Appointment {
    private Long id;

    private Long user_id;

    private Long patient_id;

    private Long dept_id;

    private Long doctor_id;

    private Long schedule_id;

    private Long type;

    private Date appointment_time;

    private BigDecimal fee;

    private Integer status;

    private Date cancel_time;

    private Date checkin_time;

    private Date create_time;

}