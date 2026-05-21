package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.Department;
import java.util.List;

public interface DepartmentService extends IService<Department> {
    List<Department> listByType(Integer type);
    List<Department> listAllActive();
}