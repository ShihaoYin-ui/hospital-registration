package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.DynamicSchedule;
import java.util.Date;
import java.util.List;

public interface DynamicScheduleService extends IService<DynamicSchedule> {
    List<DynamicSchedule> listByDoctorAndDateRange(Long doctorId, Date startDate, Date endDate);
    List<DynamicSchedule> listAvailableByDoctorAndDate(Long doctorId, Date scheduleDate);
    boolean decreaseQuota(Long id);
    boolean increaseQuota(Long id);
    DynamicSchedule lockById(Long id);
}