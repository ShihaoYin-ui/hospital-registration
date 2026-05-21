package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.FixedSchedule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface FixedScheduleMapper extends BaseMapper<FixedSchedule> {

    @Select("SELECT * FROM fixed_schedule WHERE doctor_id = #{doctorId}")
    List<FixedSchedule> findByDoctorId(@Param("doctorId") Long doctorId);

    @Select("SELECT * FROM fixed_schedule WHERE dept_id = #{deptId}")
    List<FixedSchedule> findByDeptId(@Param("deptId") Long deptId);
}