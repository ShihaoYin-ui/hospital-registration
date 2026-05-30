package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
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

    @TableField("dept_id")
    private Long deptId;

    @TableField("doctor_id")
    private Long doctorId;

    @TableField("schedule_id")
    private Long scheduleId;

    private Long type;

    @TableField("appointment_time")
    private Date appointmentTime;

    private BigDecimal fee;

    private Integer status;

    @TableField("cancel_time")
    private Date cancelTime;

    @TableField("checkin_time")
    private Date checkinTime;

    @TableField("create_time")
    private Date createTime;

}
