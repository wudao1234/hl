package org.mstudio.modules.wms.common;

import lombok.AllArgsConstructor;
import lombok.Data;

/**
 * @author Macrow
 * @date 2019-03-25
 */

@Data
@AllArgsConstructor
public class ResultMessage {

    private String message;

    private int countSucceed;

    private int countFailed;

}
