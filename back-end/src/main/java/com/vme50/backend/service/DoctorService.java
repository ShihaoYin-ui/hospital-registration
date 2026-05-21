package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.Doctor;
import java.util.List;

public interface DoctorService extends IService<Doctor> {
    List<Doctor> listByDeptId(Long deptId);
    List<Doctor> searchByName(String keyword);
}