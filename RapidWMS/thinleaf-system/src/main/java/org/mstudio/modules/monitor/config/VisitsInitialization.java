package org.mstudio.modules.monitor.config;

import org.mstudio.modules.monitor.service.VisitsService;
import org.springframework.context.annotation.Configuration;

/**
 * 初始化站点统计
 *
 */
@Configuration
public class VisitsInitialization {

    public VisitsInitialization(VisitsService visitsService){
        System.out.println("--------------- 初始化站点统计，如果存在今日统计则跳过 ---------------");
        visitsService.save();
        System.out.println("--------------- 初始化站点统计完成 ---------------");
    }
}
