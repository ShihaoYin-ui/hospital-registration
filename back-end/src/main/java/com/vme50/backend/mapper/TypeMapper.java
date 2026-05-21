package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.Type;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

@Mapper
public interface TypeMapper extends BaseMapper<Type> {

    @Select("SELECT * FROM type WHERE parent_id IS NULL ORDER BY sort_order")
    List<Type> findAllRoot();

    @Select("SELECT * FROM type WHERE parent_id = #{parentId} ORDER BY sort_order")
    List<Type> findByParentId(@Param("parentId") Integer parentId);

    @Select("SELECT * FROM type WHERE code = #{code}")
    Type findByCode(@Param("code") String code);
}