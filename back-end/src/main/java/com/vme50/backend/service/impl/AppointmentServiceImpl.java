package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.Appointment;
import com.vme50.backend.entity.DynamicSchedule;
import com.vme50.backend.entity.FixedSchedule;
import com.vme50.backend.entity.Patient;
import com.vme50.backend.mapper.AppointmentMapper;
import com.vme50.backend.mapper.DynamicScheduleMapper;
import com.vme50.backend.mapper.FixedScheduleMapper;
import com.vme50.backend.mapper.PatientMapper;
import com.vme50.backend.service.AppointmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.Date;
import java.util.List;

@Service
public class AppointmentServiceImpl extends ServiceImpl<AppointmentMapper, Appointment> implements AppointmentService {

    @Autowired
    private DynamicScheduleMapper dynamicScheduleMapper;
    @Autowired
    private PatientMapper patientMapper;
    @Autowired
    private FixedScheduleMapper fixedScheduleMapper;

    @Override
    @Transactional
    public Appointment reserve(Long userId, Long patientId, Long scheduleId) {
        Patient patient = patientMapper.selectById(patientId);
        if (patient == null || !patient.getUser_id().equals(userId)) {
            throw new RuntimeException("就诊人信息错误");
        }
        DynamicSchedule ds = dynamicScheduleMapper.lockById(scheduleId);
        if (ds == null || ds.getRemaining_quota() <= 0 || ds.getStatus() != 1) {
            throw new RuntimeException("号源已满或已停诊");
        }
        FixedSchedule fs = fixedScheduleMapper.selectById(ds.getSchedule_id());
        if (fs == null) {
            throw new RuntimeException("排班模板不存在");
        }
        int affected = dynamicScheduleMapper.decreaseQuota(scheduleId);
        if (affected == 0) {
            throw new RuntimeException("扣减号源失败，请重试");
        }
        Appointment app = new Appointment();
        app.setUserId(userId);
        app.setPatientId(patientId);
        app.setDept_id(fs.getDept_id());
        app.setDoctor_id(ds.getDoctor_id());
        app.setSchedule_id(scheduleId);
        app.setType(1L);
        app.setAppointment_time(new Date());
        app.setFee(fs.getFee());
        app.setStatus(1);
        app.setCreate_time(new Date());
        this.save(app);
        return app;
    }

    @Override
    @Transactional
    public boolean cancel(Long appointmentId) {
        Appointment app = this.getById(appointmentId);
        if (app == null || app.getStatus() != 1) {
            throw new RuntimeException("预约记录不存在或不可取消");
        }
        dynamicScheduleMapper.increaseQuota(app.getSchedule_id());
        return baseMapper.cancelById(appointmentId, new Date()) > 0;
    }

    @Override
    @Transactional
    public boolean checkin(Long appointmentId) {
        Appointment app = this.getById(appointmentId);
        if (app == null || app.getStatus() != 1) {
            throw new RuntimeException("预约状态不可签到");
        }
        return baseMapper.checkin(appointmentId, new Date()) > 0;
    }

    @Override
    public List<Appointment> listByUser(Long userId) {
        return baseMapper.findByUserId(userId);
    }

    @Override
    public List<Appointment> listByPatient(Long patientId) {
        return baseMapper.findByPatientId(patientId);
    }
}