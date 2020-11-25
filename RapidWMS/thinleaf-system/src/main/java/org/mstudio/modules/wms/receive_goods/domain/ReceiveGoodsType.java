package org.mstudio.modules.wms.receive_goods.domain;

public enum ReceiveGoodsType {
    /**
     * 新增
     */
    NEW("新增", 0),
    /**
     * 退货
     */
    REJECTED("退货", 1);

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