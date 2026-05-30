package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.User;
import com.vme50.backend.mapper.UserMapper;
import com.vme50.backend.service.UserService;
import org.springframework.stereotype.Service;
import org.springframework.util.DigestUtils;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    @Override
    public User login(String phone, String password) {
        User user = this.findByPhone(phone);
        if (user != null && user.getPassword().equals(encryptPassword(password))) {
            return user;
        }
        return null;
    }

    @Override
    public User register(User user) {
        if (this.findByPhone(user.getPhone()) != null) {
            throw new RuntimeException("手机号已注册");
        }
        if (user.getIdNumber() != null && baseMapper.findByIdNumber(user.getIdNumber()) != null) {
            throw new RuntimeException("身份证号已被注册");
        }
        if (user.getEmail() != null && !user.getEmail().isEmpty() && baseMapper.findByEmail(user.getEmail()) != null) {
            throw new RuntimeException("邮箱已被注册");
        }
        user.setPassword(encryptPassword(user.getPassword()));
        user.setStatus((short) 1);
        this.save(user);
        return user;
    }

    @Override
    public boolean updatePassword(Long userId, String oldPwd, String newPwd) {
        User user = this.getById(userId);
        if (user == null || !user.getPassword().equals(encryptPassword(oldPwd))) {
            return false;
        }
        user.setPassword(encryptPassword(newPwd));
        return this.updateById(user);
    }

    @Override
    public User findByPhone(String phone) {
        return this.getOne(new LambdaQueryWrapper<User>().eq(User::getPhone, phone));
    }

    private String encryptPassword(String raw) {
        return DigestUtils.md5DigestAsHex(raw.getBytes());
    }
}