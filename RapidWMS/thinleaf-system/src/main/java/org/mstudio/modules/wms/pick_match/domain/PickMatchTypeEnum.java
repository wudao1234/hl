package org.mstudio.modules.wms.pick_match.domain;

/**
 * @author Macrow
 * @date 2019-03-11
 */

public enum PickMatchTypeEnum {

    /**
     * 拣配
     */
    PICK_MATCH("拣配", 0),
    /**
     * 复核
     */
    REVIEW("复核", 1);


    private String name;
    private int index;

    PickMatchTypeEnum(String name, int index) {
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
