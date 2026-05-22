package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.Doctor;
import com.vme50.backend.service.DoctorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/doctor")
public class DoctorController {

    @Autowired
    private DoctorService doctorService;

    @GetMapping("/listByDept")
    public Result<List<Doctor>> listByDeptId(@RequestParam Long deptId) {
        List<Doctor> list = doctorService.listByDeptId(deptId);
        return Result.success(list);
    }

    @GetMapping("/search")
    public Result<List<Doctor>> search(@RequestParam String keyword) {
        List<Doctor> list = doctorService.searchByName(keyword);
        return Result.success(list);
    }

    @GetMapping("/detail")
    public Result<Doctor> getDetail(@RequestParam Long id) {
        Doctor doctor = doctorService.getById(id);
        if (doctor == null) {
            return Result.error("医生不存在");
        }
        return Result.success(doctor);
    }
}