package org.mstudio.modules.wms.common;

import lombok.Data;

/**
 * @author Macrow
 * @date 2019-08-01
 */

@Data
public class MultiOperateResult {

    public MultiOperateResult() {
        this.countTotal = 0;
        this.countSucceed= 0;
        this.countFailed = 0;
    }

    public int addSucceed() {
        this.countSucceed++;
        this.countTotal++;
        return countSucceed;
    }

    public int addFailed() {
        this.countFailed++;
        this.countTotal++;
        return countFailed;
    }

    public int addResult(MultiOperateResult result) {
        this.countSucceed += result.getCountSucceed();
        this.countFailed += result.getCountFailed();
        this.countTotal += result.getCountTotal();
        return countTotal;
    }

    private int countSucceed;
    private int countFailed;
    private int countTotal;

}
