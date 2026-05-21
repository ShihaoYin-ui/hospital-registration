package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.Patient;
import com.vme50.backend.mapper.PatientMapper;
import com.vme50.backend.service.PatientService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class PatientServiceImpl extends ServiceImpl<PatientMapper, Patient> implements PatientService {

    @Override
    public List<Patient> listByUserId(Long userId) {
        return baseMapper.findByUserId(userId);
    }

    @Override
    public Patient getDefault(Long userId) {
        return baseMapper.findDefaultByUserId(userId);
    }

    @Override
    @Transactional
    public boolean addPatient(Patient patient) {
        if (this.listByUserId(patient.getUser_id()).isEmpty()) {
            patient.setIs_default('Y');
        } else {
            patient.setIs_default('N');
        }
        return this.save(patient);
    }

    @Override
    @Transactional
    public boolean updatePatient(Patient patient) {
        return this.updateById(patient);
    }

    @Override
    @Transactional
    public boolean deletePatient(Long id, Long userId) {
        Patient patient = this.getById(id);
        if (patient == null || !patient.getUser_id().equals(userId)) {
            return false;
        }
        boolean isDefault = patient.getIs_default() == 'Y';
        boolean removed = this.removeById(id);
        if (removed && isDefault) {
            List<Patient> remaining = this.listByUserId(userId);
            if (!remaining.isEmpty()) {
                this.setDefault(remaining.get(0).getId(), userId);
            }
        }
        return removed;
    }

    @Override
    @Transactional
    public boolean setDefault(Long id, Long userId) {
        baseMapper.clearDefaultFlag(userId);
        return baseMapper.setDefault(id, userId) > 0;
    }
}