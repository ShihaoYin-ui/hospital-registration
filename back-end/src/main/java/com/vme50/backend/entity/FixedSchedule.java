package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@TableName("fixed_schedule")
@NoArgsConstructor
public class FixedSchedule {
    private Long id;

    private Long dept_id;

    private Long doctor_id;

    private String time_slot;

    private String period;

    private Integer week_day;

    private Integer total_quota;

    private BigDecimal fee;

}
