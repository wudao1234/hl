package org.mstudio.modules.monitor.service;

import org.mstudio.modules.monitor.domain.vo.RedisVo;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * 可自行扩展
 *
 * @date 2018-12-10
 */
public interface RedisService {

    /**
     * findById
     * @param key
     * @return
     */
    public Page findByKey(String key, Pageable pageable);

    /**
     * create
     * @param redisVo
     */
    public void save(RedisVo redisVo);

    /**
     * delete
     * @param key
     */
    public void delete(String key);

    /**
     * 清空所有缓存
     */
    public void flushdb();
}
