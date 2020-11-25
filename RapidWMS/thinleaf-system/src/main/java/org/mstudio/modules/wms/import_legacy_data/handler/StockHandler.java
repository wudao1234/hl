package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.core.date.DateUtil;
import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer.repository.CustomerRepository;
import org.mstudio.modules.wms.goods.domain.Goods;
import org.mstudio.modules.wms.goods.repository.GoodsRepository;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoods;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsItem;
import org.mstudio.modules.wms.receive_goods.domain.ReceiveGoodsType;
import org.mstudio.modules.wms.receive_goods.repository.ReceiveGoodsItemRepository;
import org.mstudio.modules.wms.receive_goods.repository.ReceiveGoodsRepository;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.ware_position.domain.WarePosition;
import org.mstudio.modules.wms.ware_position.repository.WarePositionRepository;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@AllArgsConstructor
public class StockHandler implements RowHandler {

    private final static int GOOD_SN = 0;
    private final static int CUSTOMER_NAME = 3;
    private final static int EXPIRE_DATE = 4;
    private final static int QUANTITY = 5;
    private final static int WARE_POSITION = 9;

    private GoodsRepository goodsRepository;
    private CustomerRepository customerRepository;
    private WarePositionRepository warePositionRepository;
    private StockService stockService;
    private ReceiveGoodsRepository receiveGoodsRepository;
    private ReceiveGoodsItemRepository receiveGoodsItemRepository;

    @Override
    public void handle(int i, int i1, List<Object> list) {
        log.info("[{}] [{}] {}", i, i1, list);
        if (i1 >= 2) {
            Optional<Customer> optionalCustomer = customerRepository.findByName(list.get(CUSTOMER_NAME).toString());
            if (optionalCustomer.isPresent()) {
                Customer customer = optionalCustomer.get();
                String warePosition = list.get(WARE_POSITION).toString();
                String[] warePositionArray = warePosition.trim().split("-");
                if (warePositionArray.length == 3) {
                    if (warePositionArray[1].length() == 1) {
                        warePositionArray[1] = "0" + warePositionArray[1];
                    }
                    if (warePositionArray[2].length() == 1) {
                        warePositionArray[2] = "0" + warePositionArray[2];
                    }
                    warePosition = warePositionArray[0] + "-" + warePositionArray[1] + "-" + warePositionArray[2];
                    log.info("库位格式优化 " + list.get(WARE_POSITION).toString() + " -> " + warePosition);
                }
                Optional<WarePosition> optionalWarePosition = warePositionRepository.findByName(warePosition);
                Optional<List<Goods>> optionalGoods = goodsRepository.findByCustomerIdAndSn(customer.getId(), list.get(GOOD_SN).toString());

                if (optionalWarePosition.isPresent() && optionalGoods.isPresent()) {
                    ReceiveGoods receiveGoods = new ReceiveGoods();
                    receiveGoods.setDescription("导入库存");
                    receiveGoods.setReceiveGoodsType(ReceiveGoodsType.NEW);
                    receiveGoods.setCreator("导入账户");
                    receiveGoods.setIsAudited(true);
                    receiveGoods.setAuditor("自动审核");
                    receiveGoods.setAuditTime(new Timestamp(System.currentTimeMillis()));
                    receiveGoods.setCustomer(customer);
                    receiveGoods.setFlowSn(WmsUtil.generateTimeStampSN());
                    receiveGoods = receiveGoodsRepository.save(receiveGoods);

                    String quantityString = list.get(QUANTITY).toString();
                    Long quantity = Long.parseLong(quantityString.substring(0, quantityString.indexOf(".")));
                    if (quantity > 0) {
                        Date expireDate = DateUtil.parseDate(list.get(EXPIRE_DATE).toString());

                        List<ReceiveGoodsItem> items = new ArrayList<>();
                        ReceiveGoodsItem item = new ReceiveGoodsItem();
                        item.setGoods(optionalGoods.get().get(0));
                        item.setQuantity(quantity);
                        item.setWarePosition(optionalWarePosition.get());
                        item.setExpireDate(expireDate);
                        item.setReceiveGoods(receiveGoods);
                        item.setQuantityInitial(quantity);
                        item = receiveGoodsItemRepository.save(item);

                        items.add(item);
                        receiveGoods.setReceiveGoodsItems(items);
                        receiveGoods = receiveGoodsRepository.save(receiveGoods);

                        stockService.receiveGoods(receiveGoods);
                    }
                }
            }
        }
    }

}
