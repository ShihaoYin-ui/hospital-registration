package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.FeeConfig;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.Date;
import java.util.List;

@Mapper
public interface FeeConfigMapper extends BaseMapper<FeeConfig> {

    @Select("SELECT * FROM fee_config WHERE dept_id = #{deptId} AND doctor_title = #{doctorTitle} " +
            "AND type = #{type} AND effective_date <= #{date} AND expire_date >= #{date} AND is_active = 1")
    FeeConfig findValidConfig(@Param("deptId") Long deptId,
                              @Param("doctorTitle") Integer doctorTitle,
                              @Param("type") Integer type,
                              @Param("date") Date date);

    @Select("SELECT * FROM fee_config WHERE is_active = 1 AND expire_date < #{date}")
    List<FeeConfig> findExpiredConfigs(@Param("date") Date date);
}