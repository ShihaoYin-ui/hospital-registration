package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.Doctor;
import com.vme50.backend.mapper.DoctorMapper;
import com.vme50.backend.service.DoctorService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DoctorServiceImpl extends ServiceImpl<DoctorMapper, Doctor> implements DoctorService {

    @Override
    public List<Doctor> listByDeptId(Long deptId) {
        return baseMapper.findByDeptId(deptId);
    }

    @Override
    public List<Doctor> searchByName(String keyword) {
        return baseMapper.searchByName(keyword);
    }
}