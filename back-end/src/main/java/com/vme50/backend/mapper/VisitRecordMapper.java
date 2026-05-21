package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.VisitRecord;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface VisitRecordMapper extends BaseMapper<VisitRecord> {

    @Select("SELECT * FROM visit_record WHERE appointment_id = #{appointmentId}")
    VisitRecord findByAppointmentId(@Param("appointmentId") Long appointmentId);

    @Select("SELECT * FROM visit_record WHERE patient_id = #{patientId} ORDER BY visit_date DESC")
    List<VisitRecord> findByPatientId(@Param("patientId") Long patientId);
}