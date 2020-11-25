package org.mstudio.modules.wms.stock.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import org.mstudio.modules.security.security.JwtUser;
import org.mstudio.modules.wms.stock.domain.Stock;

import java.math.BigDecimal;

/**
 * @author Macrow
 * @date 2020/8/30
 */
@Data
@AllArgsConstructor
@Builder
public class MoveDTO {
    private Stock stock;
    private Stock newStock;
    private JwtUser user;
    private String description;
    private BigDecimal price;
}
