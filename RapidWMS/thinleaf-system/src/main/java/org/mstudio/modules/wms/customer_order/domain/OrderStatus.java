package org.mstudio.modules.wms.customer_order.domain;

/**
 * @author Macrow
 * @date 2019-03-11
 */

public enum OrderStatus {

    // 额外说明： 此处的index必须和enum的自身排序index一一对应，因为系统用了这样的规则，否则订单状态会有错误
    /**
     * 生成订单
     */
    INIT("生成订单", 0),
    /**
     * 出库分拣
     */
    FETCH_STOCK("匹配出库", 1),
    /**
     * 正在分拣
     */
    GATHERING_GOODS("正在分拣", 2),
    /**
     * 分拣
     */
    GATHER_GOODS("分拣完成", 3),
    /**
     * 复核
     */
    CONFIRM("复核确认", 4),
    /**
     * 整理打包
     */
    PACKAGE("整理打包", 5),
    /**
     * 物流派送
     */
    SENDING("物流派送", 6),
    /**
     * 签收确认
     */
    CLIENT_SIGNED("签收确认", 7),
    /**
     * 签收完成
     */
    COMPLETE("回执完成", 8),
    /**
     * 订单作废
     */
    CANCEL("订单作废", 9);

    private String name;
    private int index;

    OrderStatus(String name, int index) {
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
