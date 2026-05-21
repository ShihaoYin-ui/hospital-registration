package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.Department;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface DepartmentMapper extends BaseMapper<Department> {

    @Select("SELECT * FROM department WHERE type = #{type} AND status = 1 ORDER BY sort_order")
    List<Department> findByType(@Param("type") Integer type);

    @Select("SELECT * FROM department WHERE status = 1 ORDER BY sort_order")
    List<Department> findAllActive();
}