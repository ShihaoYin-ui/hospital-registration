package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.Patient;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

@Mapper
public interface PatientMapper extends BaseMapper<Patient> {

    @Select("SELECT * FROM patient WHERE user_id = #{userId}")
    List<Patient> findByUserId(@Param("userId") Long userId);

    @Select("SELECT * FROM patient WHERE user_id = #{userId} AND is_default = 'Y'")
    Patient findDefaultByUserId(@Param("userId") Long userId);

    @Update("UPDATE patient SET is_default = 'N' WHERE user_id = #{userId}")
    int clearDefaultFlag(@Param("userId") Long userId);

    @Update("UPDATE patient SET is_default = 'Y' WHERE id = #{id} AND user_id = #{userId}")
    int setDefault(@Param("id") Long id, @Param("userId") Long userId);
}