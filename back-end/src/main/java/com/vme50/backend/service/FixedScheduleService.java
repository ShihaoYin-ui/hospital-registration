package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.FixedSchedule;
import java.util.List;

public interface FixedScheduleService extends IService<FixedSchedule> {
    List<FixedSchedule> listByDoctorId(Long doctorId);
    List<FixedSchedule> listByDeptId(Long deptId);
}