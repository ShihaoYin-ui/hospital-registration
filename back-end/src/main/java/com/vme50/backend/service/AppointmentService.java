package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.Appointment;
import java.util.List;

public interface AppointmentService extends IService<Appointment> {
    Appointment reserve(Long userId, Long patientId, Long scheduleId);
    boolean cancel(Long appointmentId);
    boolean checkin(Long appointmentId);
    List<Appointment> listByUser(Long userId);
    List<Appointment> listByPatient(Long patientId);
}