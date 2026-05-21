package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.DynamicSchedule;
import com.vme50.backend.mapper.DynamicScheduleMapper;
import com.vme50.backend.service.DynamicScheduleService;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

@Service
public class DynamicScheduleServiceImpl extends ServiceImpl<DynamicScheduleMapper, DynamicSchedule> implements DynamicScheduleService {

    @Override
    public List<DynamicSchedule> listByDoctorAndDateRange(Long doctorId, Date startDate, Date endDate) {
        return baseMapper.findByDoctorAndDateRange(doctorId, startDate, endDate);
    }

    @Override
    public List<DynamicSchedule> listAvailableByDoctorAndDate(Long doctorId, Date scheduleDate) {
        return baseMapper.findAvailableByDoctorAndDate(doctorId, scheduleDate);
    }

    @Override
    public boolean decreaseQuota(Long id) {
        return baseMapper.decreaseQuota(id) > 0;
    }

    @Override
    public boolean increaseQuota(Long id) {
        return baseMapper.increaseQuota(id) > 0;
    }

    @Override
    public DynamicSchedule lockById(Long id) {
        return baseMapper.lockById(id);
    }
}