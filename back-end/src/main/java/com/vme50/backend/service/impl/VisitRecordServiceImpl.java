package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.VisitRecord;
import com.vme50.backend.mapper.VisitRecordMapper;
import com.vme50.backend.service.VisitRecordService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class VisitRecordServiceImpl extends ServiceImpl<VisitRecordMapper, VisitRecord> implements VisitRecordService {

    @Override
    public VisitRecord getByAppointmentId(Long appointmentId) {
        return baseMapper.findByAppointmentId(appointmentId);
    }

    @Override
    public List<VisitRecord> listByPatientId(Long patientId) {
        return baseMapper.findByPatientId(patientId);
    }
}