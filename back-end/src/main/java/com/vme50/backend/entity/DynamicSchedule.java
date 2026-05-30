package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

@Data
@TableName("dynamic_schedule")
@NoArgsConstructor
public class DynamicSchedule {
    private Long id;

    @TableField("schedule_id")
    private Long scheduleId;

    @TableField("doctor_id")
    private Long doctorId;

    @TableField("schedule_date")
    private Date scheduleDate;

    @TableField("time_slot")
    private String timeSlot;

    private String period;

    @TableField("total_quota")
    private Integer totalQuota;

    @TableField("remaining_quota")
    private Integer remainingQuota;

    private Integer status;

}
