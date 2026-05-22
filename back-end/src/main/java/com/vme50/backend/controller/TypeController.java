package com.vme50.backend.controller;

import com.vme50.backend.common.Result;
import com.vme50.backend.entity.Type;
import com.vme50.backend.service.TypeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/type")
public class TypeController {

    @Autowired
    private TypeService typeService;

    @GetMapping("/root")
    public Result<List<Type>> getRootTypes() {
        List<Type> list = typeService.listRoot();
        return Result.success(list);
    }

    @GetMapping("/children")
    public Result<List<Type>> getChildren(@RequestParam Integer parentId) {
        List<Type> list = typeService.listByParentId(parentId);
        return Result.success(list);
    }
}