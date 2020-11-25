package org.mstudio.modules.wms.pack.domain;

public enum PackType {
    /**
     * 市区派送
     */
    SENDING("市区派送", 0),
    /**
     * 外发物流
     */
    TRANSFER("外发物流", 1),
    /**
     * 自行提取
     */
    SELF_PICKUP("自行提取", 2);

    private String name;
    private int index;

    PackType(String name, int index) {
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