package org.mstudio.modules.wms.customer_order.domain;

/**
 * @author Macrow
 * @date 2019-03-26
 */

public enum OrderImportType {

    /**
     * 金蝶
     */
    KINGDEE("美倩金蝶出库单导入", 0),
    /**
     * 金蝶2
     */
    KINGDEE2("美倩金蝶调拨单导入", 1),
    /**
     * 手动生成订单
     */
    HTML("HTML订单导入", 2),
    /**
     * 通用格式导入订单
     */
    GENERAL("通用格式导入订单", 3);

    private String name;
    private int index;

    OrderImportType(String name, int index) {
        this.name = name;
        this.index = index;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIndex() {
        return this.index;
    }

    public void setIndex(int index) {
        this.index = index;
    }

}
