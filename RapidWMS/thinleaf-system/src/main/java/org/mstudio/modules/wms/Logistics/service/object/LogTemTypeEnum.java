package org.mstudio.modules.wms.Logistics.service.object;

/**
 * 按件：0；按重：1；按体积：2
 * @author lfj
 * @date 2020-12-12
 */

public enum LogTemTypeEnum {

    /**
     * 按件
     */
    NUM("按件", 0),
    /**
     * 按重
     */
    WEIGHT("按重", 1),
    /**
     * 按体
     */
    SIZE("按体", 2);


    private String name;
    private int index;

    LogTemTypeEnum(String name, int index) {
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
