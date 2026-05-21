package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("visit_record")
@NoArgsConstructor
public class VisitRecord {
    private Long id;

    private Long appointment_id;

    private Long patient_id;

    private Long doctor_id;

    private Date visit_date;

    private String diagnosis;

    private String prescription;

    private String remarks;

    private Date create_time;

}
