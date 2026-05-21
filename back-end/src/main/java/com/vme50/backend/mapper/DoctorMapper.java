package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.Doctor;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DoctorMapper extends BaseMapper<Doctor> {

    @Select("SELECT * FROM doctor WHERE dept_id = #{deptId} AND status = 1 ORDER BY sort_order")
    List<Doctor> findByDeptId(@Param("deptId") Long deptId);

    @Select("SELECT * FROM doctor WHERE name LIKE CONCAT('%', #{keyword}, '%') AND status = 1")
    List<Doctor> searchByName(@Param("keyword") String keyword);
}