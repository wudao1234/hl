package org.mstudio.modules.wms.receive_goods.domain;

/**
 * 收货计件 类型
 * @author lfj
 * @date 2020-12-12
 */

public enum ReceiveGoodsPieceTypeEnum {

    /**
     * 收货
     */
    UNLOAD("收货", 0),
    /**
     * 入库
     */
    PUT_IN("入库", 1);


    private String name;
    private int index;

    ReceiveGoodsPieceTypeEnum(String name, int index) {
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
