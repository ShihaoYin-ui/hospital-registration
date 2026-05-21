package com.vme50.backend.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.vme50.backend.entity.FeeConfig;
import com.vme50.backend.mapper.FeeConfigMapper;
import com.vme50.backend.service.FeeConfigService;
import org.springframework.stereotype.Service;
import java.util.Date;
import java.util.List;

@Service
public class FeeConfigServiceImpl extends ServiceImpl<FeeConfigMapper, FeeConfig> implements FeeConfigService {

    @Override
    public FeeConfig getValidConfig(Long deptId, Integer doctorTitle, Integer type, Date date) {
        return baseMapper.findValidConfig(deptId, doctorTitle, type, date);
    }

    @Override
    public List<FeeConfig> getExpiredConfigs(Date date) {
        return baseMapper.findExpiredConfigs(date);
    }
}