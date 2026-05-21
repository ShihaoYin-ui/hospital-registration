package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.Patient;
import java.util.List;

public interface PatientService extends IService<Patient> {
    List<Patient> listByUserId(Long userId);
    Patient getDefault(Long userId);
    boolean addPatient(Patient patient);
    boolean updatePatient(Patient patient);
    boolean deletePatient(Long id, Long userId);
    boolean setDefault(Long id, Long userId);
}