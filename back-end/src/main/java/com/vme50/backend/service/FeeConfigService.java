package com.vme50.backend.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.vme50.backend.entity.FeeConfig;
import java.util.Date;
import java.util.List;

public interface FeeConfigService extends IService<FeeConfig> {
    FeeConfig getValidConfig(Long deptId, Integer doctorTitle, Integer type, Date date);
    List<FeeConfig> getExpiredConfigs(Date date);
}