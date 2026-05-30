package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("visit_record")
@NoArgsConstructor
public class VisitRecord {
    private Long id;

    @TableField("appointment_id")
    private Long appointmentId;

    @TableField("patient_id")
    private Long patientId;

    @TableField("doctor_id")
    private Long doctorId;

    @TableField("visit_date")
    private Date visitDate;

    private String diagnosis;
    private String prescription;
    private String remarks;

    @TableField("create_time")
    private Date createTime;
}
