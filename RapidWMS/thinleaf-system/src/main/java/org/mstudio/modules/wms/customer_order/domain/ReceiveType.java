package org.mstudio.modules.wms.customer_order.domain;

public enum ReceiveType {
    /**
     * 正常签收
     */
    ALL_SEND("全部签收", 0),
    /**
     * 部分拒收
     */
    PARTIAL_REJECT("部分拒收", 1),
    /**
     * 全部拒收
     */
    ALL_REJECT("全部拒收", 2);

    private String name;
    private int index;

    ReceiveType(String name, int index) {
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