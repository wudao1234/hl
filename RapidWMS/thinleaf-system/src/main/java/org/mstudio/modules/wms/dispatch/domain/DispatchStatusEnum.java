package org.mstudio.modules.wms.dispatch.domain;

/**
 * @author lfj
 * @date 2020-12-12
 */

public enum DispatchStatusEnum {

    /**
     * 待完成
     */
    UN_FINISH("待完成", 0),
    /**
     * 完成
     */
    FINISH("完成", 1);


    private String name;
    private int index;

    DispatchStatusEnum(String name, int index) {
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
