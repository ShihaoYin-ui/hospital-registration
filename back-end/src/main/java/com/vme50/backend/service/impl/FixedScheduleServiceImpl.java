package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.FixedSchedule;
import com.vme50.backend.mapper.FixedScheduleMapper;
import com.vme50.backend.service.FixedScheduleService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class FixedScheduleServiceImpl extends ServiceImpl<FixedScheduleMapper, FixedSchedule> implements FixedScheduleService {

    @Override
    public List<FixedSchedule> listByDoctorId(Long doctorId) {
        return baseMapper.findByDoctorId(doctorId);
    }

    @Override
    public List<FixedSchedule> listByDeptId(Long deptId) {
        return baseMapper.findByDeptId(deptId);
    }
}