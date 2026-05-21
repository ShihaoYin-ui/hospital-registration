package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.VisitRecord;
import java.util.List;

public interface VisitRecordService extends IService<VisitRecord> {
    VisitRecord getByAppointmentId(Long appointmentId);
    List<VisitRecord> listByPatientId(Long patientId);
}