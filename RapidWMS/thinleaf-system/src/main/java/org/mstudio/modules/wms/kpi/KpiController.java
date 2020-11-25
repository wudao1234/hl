package org.mstudio.modules.wms.kpi;

import cn.hutool.core.date.DateUtil;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.customer_order.domain.OrderStatus;
import org.mstudio.modules.wms.customer_order.service.CustomerOrderService;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.kpi.Object.*;
import org.mstudio.modules.wms.pack.service.PackService;
import org.mstudio.modules.wms.stock_flow.service.StockFlowService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Date;
import java.util.List;

/**
 * @author Macrow
 * @date 2019-05-16
 */

@Slf4j
@RestController
@RequestMapping("api/kpi")
public class KpiController {

    @Autowired
    private CustomerOrderService customerOrderService;

    @Autowired
    private StockFlowService stockFlowService;

    @Autowired
    private PackService packService;

    @Autowired
    private GoodsService goodsService;

    @GetMapping("/dashboard_today")
    @PreAuthorize("hasAnyRole('ADMIN', 'K_TODAY')")
    public ResponseEntity dashboardToday() {
        TodayKpiDTO todayKpiDTO = new TodayKpiDTO();

        Date startDate = DateUtil.beginOfDay(DateUtil.date());
        Date endDate = DateUtil.endOfDay(DateUtil.date());

        todayKpiDTO.setOrderCountToday(customerOrderService.countByCreateTimeBetween(startDate, endDate));
        todayKpiDTO.setTotalPriceToday(customerOrderService.countTotalPriceByCreateTimeBetween(startDate, endDate));
        todayKpiDTO.setUnConfirmOrders(customerOrderService.countByOrderStatus(OrderStatus.FETCH_STOCK));
        todayKpiDTO.setConfirmOrdersToday(customerOrderService.countByOrderStatusAndUpdateTimeBetween(OrderStatus.CONFIRM, startDate, endDate));
        todayKpiDTO.setPackCountDetailToday(packService.countDetailByCreateTimeBetween(startDate, endDate));
        todayKpiDTO.setPackCountToday(packService.countByCreateTimeBetween(startDate, endDate));
        todayKpiDTO.setPackCountDetailSending(packService.countDetailByPackStatus(OrderStatus.PACKAGE));
        todayKpiDTO.setPackCountSending(packService.countByPackStatus(OrderStatus.PACKAGE));

        return new ResponseEntity<>(todayKpiDTO, HttpStatus.OK);
    }

    @GetMapping("/order_sales")
    @PreAuthorize("hasAnyRole('ADMIN', 'K_TODAY')")
    public ResponseEntity orderSales(@RequestParam String type, @RequestParam String date) {
        List<OrderSales> orderSales = customerOrderService.queryOrderSales(type, date);
        List<TopSales> topSales = stockFlowService.queryTopSales(type);
        return new ResponseEntity<>(new OrderSalesKpiDTO(orderSales, topSales), HttpStatus.OK);
    }

    @GetMapping("goods_unsalable")
    @PreAuthorize("hasAnyRole('ADMIN', 'K_UNSALE')")
    public ResponseEntity unsalable(@RequestParam String type, @RequestParam String date, @RequestParam String customerId) {
        Date startDate, endDate;
        Date queryDate = DateUtil.parseDate(date);
        switch (type) {
            case "week":
                startDate = DateUtil.beginOfWeek(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfWeek(queryDate), 1);
                break;
            case "month":
                startDate = DateUtil.beginOfMonth(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfMonth(queryDate), 1);
                break;
            case "year":
                startDate = DateUtil.beginOfYear(queryDate);
                endDate = DateUtil.offsetSecond(DateUtil.endOfYear(queryDate), 1);
                break;
            default:
                return null;
        }
        List<TopUnSales> unSales = goodsService.queryUnSales(startDate, endDate, customerId);
        return new ResponseEntity<>(unSales, HttpStatus.OK);
    }

}
