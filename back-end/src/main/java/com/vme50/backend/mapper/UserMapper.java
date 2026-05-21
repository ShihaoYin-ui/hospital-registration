package com.vme50.backend.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.vme50.backend.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface UserMapper extends BaseMapper<User> {

    @Select("SELECT * FROM user WHERE phone = #{phone}")
    User findByPhone(@Param("phone") String phone);

    @Select("SELECT * FROM user WHERE id_number = #{idNumber}")
    User findByIdNumber(@Param("idNumber") String idNumber);

    @Select("SELECT * FROM user WHERE email = #{email}")
    User findByEmail(@Param("email") String email);
}