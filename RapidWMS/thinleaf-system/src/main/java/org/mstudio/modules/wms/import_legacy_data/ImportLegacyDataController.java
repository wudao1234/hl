package org.mstudio.modules.wms.import_legacy_data;

import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.address.service.AddressService;
import org.mstudio.modules.wms.address_type.repository.AddressTypeRepository;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.customer.repository.CustomerRepository;
import org.mstudio.modules.wms.customer.service.CustomerService;
import org.mstudio.modules.wms.goods.repository.GoodsRepository;
import org.mstudio.modules.wms.goods.service.GoodsService;
import org.mstudio.modules.wms.goods_type.service.GoodsTypeService;
import org.mstudio.modules.wms.import_legacy_data.handler.*;
import org.mstudio.modules.wms.receive_goods.repository.ReceiveGoodsItemRepository;
import org.mstudio.modules.wms.receive_goods.repository.ReceiveGoodsRepository;
import org.mstudio.modules.wms.stock.service.StockService;
import org.mstudio.modules.wms.ware_position.repository.WarePositionRepository;
import org.mstudio.modules.wms.ware_position.service.WarePositionService;
import org.mstudio.modules.wms.ware_zone.repository.WareZoneRepository;
import org.mstudio.modules.wms.ware_zone.service.WareZoneService;
import org.mstudio.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@RestController
@RequestMapping("api/import")
public class ImportLegacyDataController {

    @Value("${upload.path}")
    private String uploadPath;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    private GoodsTypeService goodsTypeService;

    @Autowired
    private GoodsService goodsService;

    @Autowired
    private GoodsRepository goodsRepository;

    @Autowired
    private WareZoneService wareZoneService;

    @Autowired
    private WareZoneRepository wareZoneRepository;

    @Autowired
    private WarePositionRepository warePositionRepository;

    @Autowired
    private WarePositionService warePositionService;

    @Autowired
    private ReceiveGoodsRepository receiveGoodsRepository;

    @Autowired
    private ReceiveGoodsItemRepository receiveGoodsItemRepository;

    @Autowired
    private StockService stockService;

    @Autowired
    private AddressService addressService;

    @Autowired
    private AddressTypeRepository addressTypeRepository;

    @PostMapping("/customer")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importCustomer(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new CustomerHandler(customerService));
    }

    @PostMapping("/goods")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importGoods(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new GoodsHandler(goodsTypeService, goodsService, customerRepository));
    }

    @PostMapping("/ware_zone")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importWareZone(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new WareZoneHandler(wareZoneService));
    }

    @PostMapping("/ware_position")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importWarePosition(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new WarePositionHandler(warePositionService, wareZoneRepository));
    }

    @PostMapping("/stock")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importStock(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new StockHandler(goodsRepository, customerRepository, warePositionRepository, stockService, receiveGoodsRepository, receiveGoodsItemRepository));
    }

    @PostMapping("/address")
    @PreAuthorize("hasAnyRole('ADMIN')")
    public void importAddress(@RequestParam(value = "file") MultipartFile excelFile) throws Exception {
        WmsUtil.handleExcelFile( FileUtil.getUploadPath(uploadPath) + WmsUtil.uploadExcelFile(uploadPath, excelFile), new AddressHandler(addressService, addressTypeRepository));
    }
}
