package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.Appointment;
import com.vme50.backend.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/appointment")
public class AppointmentController {

    @Autowired
    private AppointmentService appointmentService;

    @PostMapping("/reserve")
    public Result<Appointment> reserve(@RequestParam Long userId, @RequestParam Long patientId, @RequestParam Long scheduleId) {
        try {
            Appointment app = appointmentService.reserve(userId, patientId, scheduleId);
            return Result.success(app);
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PutMapping("/cancel")
    public Result<Void> cancel(@RequestParam Long appointmentId) {
        try {
            boolean ok = appointmentService.cancel(appointmentId);
            if (ok) {
                return Result.success(null);
            } else {
                return Result.error("取消失败");
            }
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @PutMapping("/checkin")
    public Result<Void> checkin(@RequestParam Long appointmentId) {
        try {
            boolean ok = appointmentService.checkin(appointmentId);
            if (ok) {
                return Result.success(null);
            } else {
                return Result.error("签到失败");
            }
        } catch (RuntimeException e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/user")
    public Result<List<Appointment>> listByUser(@RequestParam Long userId) {
        List<Appointment> list = appointmentService.listByUser(userId);
        return Result.success(list);
    }

    @GetMapping("/patient")
    public Result<List<Appointment>> listByPatient(@RequestParam Long patientId) {
        List<Appointment> list = appointmentService.listByPatient(patientId);
        return Result.success(list);
    }

    @GetMapping("/detail")
    public Result<Appointment> getDetail(@RequestParam Long id) {
        Appointment app = appointmentService.getById(id);
        if (app == null) {
            return Result.error("预约记录不存在");
        }
        return Result.success(app);
    }
}