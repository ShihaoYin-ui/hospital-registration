package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.Type;
import com.vme50.backend.mapper.TypeMapper;
import com.vme50.backend.service.TypeService;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class TypeServiceImpl extends ServiceImpl<TypeMapper, Type> implements TypeService {

    @Override
    public List<Type> listRoot() {
        return baseMapper.findAllRoot();
    }

    @Override
    public List<Type> listByParentId(Integer parentId) {
        return baseMapper.findByParentId(parentId);
    }

    @Override
    public Type findByCode(String code) {
        return baseMapper.findByCode(code);
    }
}