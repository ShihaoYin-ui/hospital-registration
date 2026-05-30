package com.vme50.backend.entity;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.util.Date;

@Data
@TableName("fee_config")
@NoArgsConstructor
public class FeeConfig {
    private Long id;

    @TableField("dept_id")
    private Long deptId;

    private Integer doctorTitle;
    private Integer type;
    private BigDecimal fee;

    @TableField("effective_date")
    private Date effectiveDate;

    @TableField("expire_date")
    private Date expireDate;

    @TableField("is_active")
    private Integer isActive;
}
