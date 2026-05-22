package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.User;
import com.vme50.backend.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestParam String phone, @RequestParam String password) {
        User user = userService.login(phone, password);
        if (user == null) {
            return Result.error("手机号或密码错误");
        }
        Map<String, Object> data = new HashMap<>();
        data.put("id", user.getId());
        data.put("name", user.getName());
        data.put("phone", user.getPhone());
        return Result.success(data);
    }

    @PostMapping("/register")
    public Result<User> register(@RequestBody User user) {
        try {
            User newUser = userService.register(user);
            return Result.success(newUser);
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PutMapping("/password")
    public Result<Void> updatePassword(@RequestParam Long userId, @RequestParam String oldPwd, @RequestParam String newPwd) {
        boolean ok = userService.updatePassword(userId, oldPwd, newPwd);
        if (ok) {
            return Result.success(null);
        } else {
            return Result.error("原密码错误或用户不存在");
        }
    }

    @GetMapping("/info")
    public Result<User> getUserInfo(@RequestParam Long userId) {
        User user = userService.getById(userId);
        if (user == null) {
            return Result.error("用户不存在");
        }
        return Result.success(user);
    }
}