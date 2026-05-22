package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.VisitRecord;
import com.vme50.backend.service.VisitRecordService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/visit")
public class VisitRecordController {

    @Autowired
    private VisitRecordService visitRecordService;

    @GetMapping("/byAppointment")
    public Result<VisitRecord> getByAppointment(@RequestParam Long appointmentId) {
        VisitRecord record = visitRecordService.getByAppointmentId(appointmentId);
        if (record == null) {
            return Result.error("未找到就诊记录");
        }
        return Result.success(record);
    }

    @GetMapping("/byPatient")
    public Result<List<VisitRecord>> listByPatient(@RequestParam Long patientId) {
        List<VisitRecord> list = visitRecordService.listByPatientId(patientId);
        return Result.success(list);
    }
}