package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.util.Date;

/**
 * @author Macrow
 * @date 2020/8/30
 */
@Data
@AllArgsConstructor
@Builder
public class UpdateExpireDateDTO {
    private Long stockId;
    private Long changeQuantity;
    private Date newExpireDate;
}
