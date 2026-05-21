package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.DynamicSchedule;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.Date;
import java.util.List;

@Mapper
public interface DynamicScheduleMapper extends BaseMapper<DynamicSchedule> {

    @Select("SELECT * FROM dynamic_schedule WHERE doctor_id = #{doctorId} AND schedule_date BETWEEN #{startDate} AND #{endDate} ORDER BY schedule_date, time_slot")
    List<DynamicSchedule> findByDoctorAndDateRange(@Param("doctorId") Long doctorId,
                                                   @Param("startDate") Date startDate,
                                                   @Param("endDate") Date endDate);

    @Select("SELECT * FROM dynamic_schedule WHERE doctor_id = #{doctorId} AND schedule_date = #{scheduleDate} AND status = 1 AND remaining_quota > 0")
    List<DynamicSchedule> findAvailableByDoctorAndDate(@Param("doctorId") Long doctorId,
                                                       @Param("scheduleDate") Date scheduleDate);

    @Select("SELECT * FROM dynamic_schedule WHERE id = #{id} FOR UPDATE")
    DynamicSchedule lockById(@Param("id") Long id);

    @Update("UPDATE dynamic_schedule SET remaining_quota = remaining_quota - 1, " +
            "status = IF(remaining_quota - 1 = 0, 2, status) " +
            "WHERE id = #{id} AND remaining_quota > 0")
    int decreaseQuota(@Param("id") Long id);

    @Update("UPDATE dynamic_schedule SET remaining_quota = remaining_quota + 1, " +
            "status = IF(status = 2, 1, status) " +
            "WHERE id = #{id}")
    int increaseQuota(@Param("id") Long id);

    @Update("UPDATE dynamic_schedule SET status = 0 WHERE id = #{id}")
    int stopSchedule(@Param("id") Long id);
}