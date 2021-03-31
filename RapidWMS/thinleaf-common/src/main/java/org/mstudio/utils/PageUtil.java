package org.mstudio.utils;

import cn.hutool.core.util.ObjectUtil;
import org.springframework.data.domain.Page;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 分页工具
 *
 * @date 2018-12-10
 */
public class PageUtil extends cn.hutool.core.util.PageUtil {

    /**
     * List 分页
     *
     * @param page
     * @param size
     * @param list
     * @return
     */
    public static List toPage(int page, int size, List list) {
        int fromIndex = page * size;
        int toIndex = page * size + size;

        if (fromIndex > list.size()) {
            return new ArrayList();
        } else if (toIndex >= list.size()) {
            return list.subList(fromIndex, list.size());
        } else {
            return list.subList(fromIndex, toIndex);
        }
    }

    /**
     * List 分页
     *
     * @param page
     * @param size
     * @param list
     * @return
     */
    public static Map toPageOfMap(int page, int size, List list) {
        return toPage(toPage(page, size, list), list.size());
    }

    /**
     * Page 数据处理，预防redis反序列化报错
     *
     * @param page
     * @return
     */
    public static Map toPage(Page page) {
        Map map = new HashMap();

        map.put("content", page.getContent());
        map.put("totalElements", page.getTotalElements());

        return map;
    }

    /**
     * Page 数据处理，预防redis反序列化报错
     *
     * @return
     */
    public static Map toPage(List list) {
        Map map = new HashMap();
        if (ObjectUtil.isNull(list)) {
            list = new ArrayList<>();
        }
        map.put("content", list);
        map.put("totalElements", list.size());

        return map;
    }

    /**
     * @param object
     * @param totalElements
     * @return
     */
    public static Map toPage(Object object, Object totalElements) {
        Map map = new HashMap();

        map.put("content", object);
        map.put("totalElements", totalElements);

        return map;
    }

}
