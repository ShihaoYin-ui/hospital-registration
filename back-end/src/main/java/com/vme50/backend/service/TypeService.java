package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.Type;
import java.util.List;

public interface TypeService extends IService<Type> {
    List<Type> listRoot();
    List<Type> listByParentId(Integer parentId);
    Type findByCode(String code);
}