package org.mstudio.modules.wms.customer_order.service.handler;

import lombok.extern.slf4j.Slf4j;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.domain.Customer;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrder;
import org.mstudio.modules.wms.customer_order.domain.CustomerOrderItem;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.common.MultiOperateResult;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @author Macrow
 * @date 2019-05-06
 */

@Slf4j
public class HtmlHandler {

    private MultiOperateResult result;
    private Customer customer;
    private CustomerOrderService orderService;
    private List<CustomerOrderItem> orderItems = new ArrayList<>();
    private String type;
    private String targetWareZone;
    private Boolean useNewAutoIncreaseSn;
    private String sn;
    private Date expireDateMin;
    private Date expireDateMax;
    private Boolean fetchAll;
    private Boolean fetchStocks;
    private int itemSortOrder = 1;

    public HtmlHandler(MultiOperateResult result, CustomerOrderService orderService, Customer customer, String targetWareZone, Boolean useNewAutoIncreaseSn, Date expireDateMin, Date expireDateMax, Boolean fetchAll, Boolean fetchStocks, String sn) {
        this.result = result;
        this.customer = customer;
        this.orderService = orderService;
        this.targetWareZone = targetWareZone;
        this.useNewAutoIncreaseSn = useNewAutoIncreaseSn;
        this.type = customer.getShortNameEn();
        this.expireDateMin = expireDateMin;
        this.expireDateMax = expireDateMax;
        this.fetchAll = fetchAll;
        this.fetchStocks = fetchStocks;
        this.sn = sn;
    }

    public void handleHtmlFile(String fileName) throws IOException {
        File input = new File(fileName);
        Document document = Jsoup.parse(input, "UTF-8", "http://dummy.com/");

        Element orderTable = document.selectFirst("table.detail-table");
        Element detailTable = orderTable.getElementsByTag("table").get(1);
        Elements detailTds = detailTable.getElementsByTag("td");

        CustomerOrder order = new CustomerOrder();

        order.setOwner(customer);
        order.setUsePackCount(false);
        order.setTargetWareZones(targetWareZone);
        order.setClientOrderSn(detailTds.get(1).text());
        order.setClientOrderSn2(detailTds.get(1).text());
        order.setClientName(detailTds.get(7).text());
        order.setClientOperator(null);
        order.setDescription(detailTds.get(3).text());

        // 以下两项信息暂时由订货点名称填入
        order.setClientAddress(detailTds.get(7).text());
        order.setClientStore(detailTds.get(7).text());
        order.setExpireDateMin(expireDateMin);
        order.setExpireDateMax(expireDateMax);
        order.setFetchAll(fetchAll);
        order.setFlowSn(WmsUtil.generateTimeStampSN());
        order.setIsActive(true);
        order.setOrderStatus(OrderStatus.INIT);
        sn = WmsUtil.getNewSn(type, sn, false);
        order.setAutoIncreaseSn(sn);

        Element table = orderTable.selectFirst("table#tbItems");
        Element tbody = table.getElementsByTag("tbody").first();
        Elements trs = tbody.getElementsByTag("tr");
        for (Element tr : trs) {
            Elements tds = tr.getElementsByTag("td");
            List<String> orderItemsString = tds.stream().map(td -> { return td.text(); }).collect(Collectors.toList());

            if (orderItemsString.get(1) == null || orderItemsString.get(1).isEmpty()) {
                break;
            }
            CustomerOrderItem item = new CustomerOrderItem();
            item.setSortOrder(itemSortOrder++);
            item.setName(orderItemsString.get(1));
            item.setSn(orderItemsString.get(11));
            // log.info(tds.get(6).selectFirst("label.hasTax-price").text());
            item.setPrice(new BigDecimal(tds.get(6).selectFirst("label.hasTax-price").text()));
            item.setQuantityInitial(Long.valueOf(orderItemsString.get(5)));
            item.setPackCount(1);
            item.setCustomerOrder(order);
            orderItems.add(item);
        }

        order.setCustomerOrderItems(orderItems);
        try {
            orderService.create(order, useNewAutoIncreaseSn, fetchStocks);
            result.addSucceed();
        } catch (BadRequestException e) {
            result.addFailed();
        }
    }
}
