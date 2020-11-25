package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;

import java.io.Serializable;

/**
* @author Macrow
* @date 2019-04-11
*/

@Data
public class StockMultipleOperateDTO implements Serializable {

    private Long[] ids;

    private String operate;

    private String description;

    private Long[] originWarePosition;

    private Long[] quantity;

    private Long[] warePosition;

}