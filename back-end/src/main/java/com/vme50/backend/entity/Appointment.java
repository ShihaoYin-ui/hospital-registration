package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("appointment")
@NoArgsConstructor
public class Appointment {
    private Long id;

    private Long userId;

    private Long patientId;

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