package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.Department;
import com.vme50.backend.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/department")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @GetMapping("/listByType")
    public Result<List<Department>> listByType(@RequestParam Integer type) {
        List<Department> list = departmentService.listByType(type);
        return Result.success(list);
    }

    @GetMapping("/allActive")
    public Result<List<Department>> listAllActive() {
        List<Department> list = departmentService.listAllActive();
        return Result.success(list);
    }

    @GetMapping("/detail")
    public Result<Department> getDetail(@RequestParam Long id) {
        Department dept = departmentService.getById(id);
        if (dept == null) {
            return Result.error("科室不存在");
        }
        return Result.success(dept);
    }
}