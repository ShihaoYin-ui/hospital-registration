package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;

@Data
@TableName("fixed_schedule")
@NoArgsConstructor
public class FixedSchedule {
    private Long id;

    @TableField("dept_id")
    private Long deptId;

    @TableField("doctor_id")
    private Long doctorId;

    @TableField("time_slot")
    private String timeSlot;

    private String period;

    @TableField("week_day")
    private Integer weekDay;

    @TableField("total_quota")
    private Integer totalQuota;

    private BigDecimal fee;

}
