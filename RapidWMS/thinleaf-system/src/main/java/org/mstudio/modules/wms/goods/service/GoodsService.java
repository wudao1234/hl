package org.mstudio.modules.wms.goods.service;

import org.mstudio.modules.wms.customer.service.object.CustomerVO;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.service.object.GoodsDTO;
import org.mstudio.modules.wms.goods.service.object.GoodsVO;
import org.mstudio.modules.wms.kpi.Object.TopUnSales;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
* @author Macrow
* @date 2019-02-22
*/

public interface GoodsService {

    GoodsDTO findById(Long id);

    GoodsDTO create(Goods resources);

    GoodsVO update(Long Id, Goods resources);

    void delete(Long id);

    Map queryAll(Set<CustomerVO> customers, Boolean exportExcel, String goodsTypeFilter, String goodsCustomerFilter, String search, Pageable pageable);

    byte[] exportExcelData(List<GoodsDTO> goods);

    Integer countByGoodsTypeId(Long id);

    Integer countByCustomerId(Long id);

    List<TopUnSales> queryUnSales(Date startDate, Date endDate, String customer);
    
}