package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.repository.CustomerRepository;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.goods_type.domain.GoodsType;
import org.mstudio.modules.wms.goods_type.service.GoodsTypeService;

import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
public class GoodsHandler implements RowHandler {

    private final static int SN = 0;
    private final static int NAME = 1;
    private final static int CUSTOMER_NAME = 2;
    private final static int UNIT = 3;
    private final static int PACK_COUNT = 4;
    private final static int YEARS = 5;
    private final static int PRICE = 6;

    private GoodsTypeService goodsTypeService;

    private GoodsService goodsService;

    private CustomerRepository customerRepository;

    private GoodsType goodsType;

    public GoodsHandler(GoodsTypeService goodsTypeService, GoodsService goodsService, CustomerRepository customerRepository) {
        this.goodsTypeService = goodsTypeService;
        this.goodsService = goodsService;
        this.customerRepository = customerRepository;
    }

    @Override
    public void handle(int i, int i1, List<Object> list) {

        if (i1 == 0) {
            goodsType = new GoodsType();
            goodsType.setName("日化品");
            goodsType.setSortOrder(1);
            goodsTypeService.create(goodsType);
        }

        log.info("[{}] [{}] {}", i, i1, list);
        if (i1 >= 2) {
            Goods goods = new Goods();
            goods.setSn(list.get(SN).toString());
            goods.setName(list.get(NAME).toString());
            goods.setUnit(list.get(UNIT).toString());
            goods.setPackCount(Integer.parseInt(list.get(PACK_COUNT).toString().isEmpty() ? "1" : list.get(PACK_COUNT).toString()));
            goods.setGoodsType(goodsType);

            String year = list.get(YEARS).toString();
            goods.setMonthsOfWarranty(Integer.parseInt(year.substring(0, year.indexOf("."))) * 12);
            goods.setPrice(Float.parseFloat(list.get(PRICE).toString()));

            String customerName = list.get(CUSTOMER_NAME).toString();
            // 把商品放入符合条件的第一个客户名目下
            Optional<Customer> optionalCustomer = customerRepository.findByName(customerName);
            if (optionalCustomer.isPresent()) {
                Customer customer = optionalCustomer.get();
                goods.setCustomer(customer);
                goodsService.create(goods);
            }
        }
    }

}
