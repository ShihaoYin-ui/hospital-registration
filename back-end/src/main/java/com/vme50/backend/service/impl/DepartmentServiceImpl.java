package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.Department;
import com.vme50.backend.mapper.DepartmentMapper;
import com.vme50.backend.service.DepartmentService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements DepartmentService {

    @Override
    public List<Department> listByType(Integer type) {
        return baseMapper.findByType(type);
    }

    @Override
    public List<Department> listAllActive() {
        return baseMapper.findAllActive();
    }
}