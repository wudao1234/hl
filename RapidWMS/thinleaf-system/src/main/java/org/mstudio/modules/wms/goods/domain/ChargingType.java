package org.mstudio.modules.wms.goods.domain;

public enum ChargingType {
    /**
     * 价格
     */
    PRICE("价格", 0),
    /**
     * 重量
     */
    WEIGHT("重量", 1),
    /**
     * 重量
     */
    COUNT("数量", 2),
    /**
     * 重量
     */
    VOLUME("体积", 3);

    private String name;
    private int index;

    ChargingType(String name, int index) {
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