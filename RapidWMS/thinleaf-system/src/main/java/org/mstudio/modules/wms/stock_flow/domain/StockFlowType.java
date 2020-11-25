package org.mstudio.modules.wms.stock_flow.domain;

public enum StockFlowType {
    /**
     * 新增入库
     */
    IN_ADD("入库-新增到货", 0),
    /**
     * 退货入库
     */
    IN_CUSTOMER_REJECTED("入库-客户退货", 1),
    /**
     * 盘盈
     */
    IN_PROFIT("入库-库存盘盈", 2),
    /**
     * 盘亏
     */
    OUT_LOSSES("出库-库存盘亏", 3),
    /**
     * 出库-订单匹配
     */
    OUT_ORDER_FIT("出库-订单匹配", 4),
    /**
     * 移库
     */
    MOVE("移库-仓库管理", 5),
    /**
     * 其他
     */
    OTHER("其他", 99);

    private String name;
    private int index;

    StockFlowType(String name, int index) {
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