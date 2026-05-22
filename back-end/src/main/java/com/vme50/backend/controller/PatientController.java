package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.Patient;
import com.vme50.backend.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/patient")
public class PatientController {

    @Autowired
    private PatientService patientService;

    @GetMapping("/list")
    public Result<List<Patient>> listByUserId(@RequestParam Long userId) {
        List<Patient> list = patientService.listByUserId(userId);
        return Result.success(list);
    }

    @GetMapping("/default")
    public Result<Patient> getDefault(@RequestParam Long userId) {
        Patient patient = patientService.getDefault(userId);
        return Result.success(patient);
    }

    @PostMapping("/add")
    public Result<Void> addPatient(@RequestBody Patient patient) {
        boolean ok = patientService.addPatient(patient);
        if (ok) {
            return Result.success(null);
        } else {
            return Result.error("添加失败");
        }
    }

    @PutMapping("/update")
    public Result<Void> updatePatient(@RequestBody Patient patient) {
        boolean ok = patientService.updatePatient(patient);
        if (ok) {
            return Result.success(null);
        } else {
            return Result.error("更新失败");
        }
    }

    @DeleteMapping("/delete")
    public Result<Void> deletePatient(@RequestParam Long id, @RequestParam Long userId) {
        boolean ok = patientService.deletePatient(id, userId);
        if (ok) {
            return Result.success(null);
        } else {
            return Result.error("删除失败，就诊人不存在或权限不足");
        }
    }

    @PutMapping("/setDefault")
    public Result<Void> setDefault(@RequestParam Long id, @RequestParam Long userId) {
        boolean ok = patientService.setDefault(id, userId);
        if (ok) {
            return Result.success(null);
        } else {
            return Result.error("设置默认失败");
        }
    }
}