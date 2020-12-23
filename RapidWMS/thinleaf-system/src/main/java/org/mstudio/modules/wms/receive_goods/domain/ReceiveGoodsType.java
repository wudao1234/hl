package org.mstudio.modules.wms.receive_goods.domain;

public enum ReceiveGoodsType {
    /**
     * 采购入库
     */
    NEW("采购入库", 0),
    /**
     * 退货入库
     */
    REJECTED("退货入库", 1),
    /**
     * 政策入库
     */
    POLICY("政策入库", 2),
    /**
     * 其它入库
     */
    OTHER("其它入库", 3);

    private String name;
    private int index;

    ReceiveGoodsType(String name, int index) {
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