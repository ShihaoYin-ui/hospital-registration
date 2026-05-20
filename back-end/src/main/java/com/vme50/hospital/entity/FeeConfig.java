package com.vme50.hospital.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("fee_config")
public class FeeConfig {
    private Long id;

    private Long dept_id;

    private Integer doctor_title;

    private Integer type;

    private BigDecimal fee;

    private Date effective_date;

    private Date expire_date;

    private Integer is_active;

}
