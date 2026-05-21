package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.Appointment;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.Date;
import java.util.List;

@Mapper
public interface AppointmentMapper extends BaseMapper<Appointment> {

    @Select("SELECT * FROM appointment WHERE user_id = #{userId} ORDER BY create_time DESC")
    List<Appointment> findByUserId(@Param("userId") Long userId);

    @Select("SELECT * FROM appointment WHERE patient_id = #{patientId} ORDER BY create_time DESC")
    List<Appointment> findByPatientId(@Param("patientId") Long patientId);

    @Select("SELECT * FROM appointment WHERE doctor_id = #{doctorId} AND appointment_time BETWEEN #{startDate} AND #{endDate}")
    List<Appointment> findByDoctorAndDateRange(@Param("doctorId") Long doctorId,
                                               @Param("startDate") Date startDate,
                                               @Param("endDate") Date endDate);

    @Update("UPDATE appointment SET status = 2, cancel_time = #{cancelTime} WHERE id = #{id} AND status = 1")
    int cancelById(@Param("id") Long id, @Param("cancelTime") Date cancelTime);

    @Update("UPDATE appointment SET status = 3, checkin_time = #{checkinTime} WHERE id = #{id}")
    int checkin(@Param("id") Long id, @Param("checkinTime") Date checkinTime);

    @Update("UPDATE appointment SET status = 4 WHERE id = #{id}")
    int markAsNoShow(@Param("id") Long id);
}