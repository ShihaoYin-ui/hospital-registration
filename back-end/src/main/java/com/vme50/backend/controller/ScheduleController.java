package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.DynamicSchedule;
import com.vme50.backend.service.DynamicScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/api/schedule")
public class ScheduleController {

    @Autowired
    private DynamicScheduleService dynamicScheduleService;

    @GetMapping("/available")
    public Result<List<DynamicSchedule>> getAvailable(@RequestParam Long doctorId,
                                                      @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date date) {
        List<DynamicSchedule> list = dynamicScheduleService.listAvailableByDoctorAndDate(doctorId, date);
        return Result.success(list);
    }

    @GetMapping("/range")
    public Result<List<DynamicSchedule>> getByDateRange(@RequestParam Long doctorId,
                                                        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date startDate,
                                                        @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") Date endDate) {
        List<DynamicSchedule> list = dynamicScheduleService.listByDoctorAndDateRange(doctorId, startDate, endDate);
        return Result.success(list);
    }
}