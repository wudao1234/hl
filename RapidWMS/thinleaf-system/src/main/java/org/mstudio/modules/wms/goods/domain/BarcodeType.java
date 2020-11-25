package org.mstudio.modules.wms.goods.domain;

public enum BarcodeType {
    /**
     * 条形码
     */
    ONE("条形码", 0),
    /**
     * 二维码
     */
    TWO("二维码", 1);

    private String name;
    private int index;

    BarcodeType(String name, int index) {
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
