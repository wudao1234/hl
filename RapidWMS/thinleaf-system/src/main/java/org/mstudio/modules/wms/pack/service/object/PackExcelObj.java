package org.mstudio.modules.wms.pack.service.object;

import lombok.Data;

import java.math.BigDecimal;

/**
 * @author Macrow
 * @date 2019-05-07
 */

@Data
public class PackExcelObj {

    private Long index;

    private String customerName;

    private String addressName;

    private String addressContact;

    private String addressPhone;

    private String packType;

    private String packStatus;

    private String sendUserName;

    private String flowSn;

    private Integer packages;

    private BigDecimal totalPrice;

    private String isActive;

    private String orderClientSn;

    private String orderClientSn2;

    private String orderCreateTime;

    private String description;

    private String receiveType;

}
