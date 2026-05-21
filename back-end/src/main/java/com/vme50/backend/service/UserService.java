package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.User;

public interface UserService extends IService<User> {
    User login(String phone, String password);
    User register(User user);
    boolean updatePassword(Long userId, String oldPwd, String newPwd);
    User findByPhone(String phone);
}