package org.mstudio.modules.wms.stock.service.object;

import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
* @author Macrow
* @date 2019-04-10
*/

@Data
public class StockSingleOperateDTO implements Serializable {

    private Long id;

    private String operate;

    private String description;

    private Long originWarePosition;

    private Long quantity;

    private Date expireDate;

    private Long[] warePosition;

}