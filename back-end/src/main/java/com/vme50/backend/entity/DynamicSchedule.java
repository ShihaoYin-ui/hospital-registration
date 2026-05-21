package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("dynamic_schedule")
@NoArgsConstructor
public class DynamicSchedule {
    private Long id;

    private Long schedule_id;

    private Long doctor_id;

    private Date schedule_date;

    private String time_slot;

    private String period;

    private Integer total_quota;

    private Integer remaining_quota;

    private Integer status;

}
