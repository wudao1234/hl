package org.mstudio.modules.wms.pack.rest;

import org.mstudio.exception.BadRequestException;
import org.mstudio.modules.wms.common.MultiOperateResult;
import org.mstudio.modules.wms.common.WmsUtil;
import org.mstudio.modules.wms.pack.domain.Pack;
import org.mstudio.modules.wms.pack.service.PackService;
import org.mstudio.modules.wms.pack.service.object.PackMultipleOperateDTO;
import org.mstudio.modules.wms.pack.service.object.PackPackageDTO;
import org.mstudio.modules.wms.pack.service.object.PackVO;
import org.mstudio.utils.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.Collections;
import java.util.List;
import java.util.Map;

import static org.mstudio.utils.SecurityContextHolder.getUserDetails;

/**
* @author Macrow
* @date 2019-04-24
*/

@RestController
@RequestMapping("api/packs")
public class PackController {

    @Value("${upload.picture}")
    private String picturePath;

    @Autowired
    private PackService packService;

    @GetMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity list(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "isPrintedFilter", required = false) Boolean isPrintedFilter,
            @RequestParam(value = "isPackagedFilter", required = false) Boolean isPackagedFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "addressTypeFilter", required = false) String addressTypeFilter,
            @RequestParam(value = "packTypeFilter", required = false) String packTypeFilter,
            @RequestParam(value = "receiveTypeFilter", required = false) String receiveTypeFilter,
            @RequestParam(value = "packStatusFilter", required = false) String packStatusFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchAddress", required = false) String searchAddress,
            @RequestParam(value = "searchOrderSn", required = false) String searchOrderSn,
            Pageable pageable) {
        if (exportExcel != null && exportExcel) {
            Map result = packService.queryAll(true, isPrintedFilter, isPackagedFilter, customerFilter, addressTypeFilter, packTypeFilter, receiveTypeFilter, packStatusFilter, null, startDate, endDate, search, searchAddress, searchOrderSn, pageable);
            List<PackVO> packs = (List)result.get("content");
            return new ResponseEntity<>(packService.exportExcelData(packs), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(packService.queryAll(false, isPrintedFilter, isPackagedFilter, customerFilter, addressTypeFilter, packTypeFilter, receiveTypeFilter, packStatusFilter, null, startDate, endDate, search, searchAddress, searchOrderSn, pageable), HttpStatus.OK);
        }
    }

    @GetMapping("/list_my_packs")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity listMyPacks(
            @RequestParam(value = "exportExcel", required = false) Boolean exportExcel,
            @RequestParam(value = "isPrintedFilter", required = false) Boolean isPrintedFilter,
            @RequestParam(value = "isPackagedFilter", required = false) Boolean isPackagedFilter,
            @RequestParam(value = "customerFilter", required = false) String customerFilter,
            @RequestParam(value = "addressTypeFilter", required = false) String addressTypeFilter,
            @RequestParam(value = "packTypeFilter", required = false) String packTypeFilter,
            @RequestParam(value = "receiveTypeFilter", required = false) String receiveTypeFilter,
            @RequestParam(value = "packStatusFilter", required = false) String packStatusFilter,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "endDate", required = false) String endDate,
            @RequestParam(value = "search", required = false) String search,
            @RequestParam(value = "searchAddress", required = false) String searchAddress,
            Pageable pageable) {
        String currentUserName = getUserDetails().getUsername();
        if (exportExcel != null && exportExcel) {
            Map result = packService.queryAll(true, isPrintedFilter, isPackagedFilter, customerFilter, addressTypeFilter, packTypeFilter, receiveTypeFilter, packStatusFilter, currentUserName, startDate, endDate, search, searchAddress, null, pageable);
            List<PackVO> packs = (List)result.get("content");
            return new ResponseEntity<>(packService.exportExcelData(packs), WmsUtil.getExportExcelHeaders(), HttpStatus.OK);
        } else {
            return new ResponseEntity<>(packService.queryAll(false, isPrintedFilter, isPackagedFilter, customerFilter, addressTypeFilter, packTypeFilter, receiveTypeFilter, packStatusFilter, currentUserName, startDate, endDate, search, searchAddress, null, pageable), HttpStatus.OK);
        }
    }

    @PostMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity create(@Validated @RequestBody Pack resource) {
        return new ResponseEntity<>(packService.create(resource), HttpStatus.CREATED);
    }

    @PutMapping("")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity update(@Validated @RequestBody Pack resource) {
        if (resource.getId() == null) {
            throw new BadRequestException("ID不能为空");
        }
        return new ResponseEntity<>(packService.update(resource.getId(), resource), HttpStatus.CREATED);
    }

    @GetMapping("{id}/stock_flows")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity getStockFlows(@PathVariable Long id) {
        return new ResponseEntity<>(packService.getStockFlows(id), HttpStatus.OK);
    }

    @PostMapping("packages")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity packages(@RequestBody PackPackageDTO packPackageDTO) {
        return new ResponseEntity<>(packService.packages(packPackageDTO.getId(), packPackageDTO.getPackItems()), HttpStatus.CREATED);
    }

    @PostMapping("/upload_picture")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public String uploadPicture(@RequestParam(value = "file") MultipartFile imageFile) throws Exception {
        return FileUtil.uploadPictureWithLowCompress(picturePath, imageFile);
    }

    @PostMapping("{id}/changeSignedPhoto")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity changeSignedPhoto(@PathVariable Long id, @RequestParam(value = "file") MultipartFile imageFile) throws Exception {
        packService.changeSignedPhoto(id, FileUtil.uploadPictureWithLowCompress(picturePath, imageFile));
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity get(@PathVariable Long id) {
        return new ResponseEntity<>(packService.findById(id), HttpStatus.OK);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_DELETE')")
    public ResponseEntity delete(@PathVariable Long id) {
        packService.delete(id);
        return new ResponseEntity(HttpStatus.NO_CONTENT);
    }

    @PostMapping("/sending_by_me_and_flow_sn")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity sendingByMeAndFlowSn(@RequestBody String flowSn) {
        packService.sendingByMeAndFlowSn(flowSn);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @GetMapping("/list_sending_packs_group_by_users")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity listSendingPacksGroupByUsers() {
        return new ResponseEntity<>(packService.listSendingPacksGroupByUsers(), HttpStatus.OK);
    }

    @GetMapping("/list_sending_packs_by_user_id/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity listSendingPacksByUserId(@PathVariable Long id) {
        return new ResponseEntity<>(packService.listSendingPacksByUserId(id), HttpStatus.OK);
    }

    @PostMapping("/batchDelete")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_DELETE')")
    public ResponseEntity batchDelete(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.batchDelete(packMultipleOperateDTO);
        return new ResponseEntity(WmsUtil.getResultMessage(result), HttpStatus.OK);
    }

    @PostMapping("/batchCancel")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity batchCancel(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.batchCancel(packMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/cancel/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity cancel(@PathVariable Long id, @RequestParam String description) {
        packService.cancel(id, description);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchSending")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_ASSIGN')")
    public ResponseEntity batchSending(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.batchSending(packMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/sendingByMe")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity sendingByMe(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.sendingByMe(packMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/batchReturn")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity batchReturn(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.batchReturnPack(packMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    @PostMapping("/return/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity returnPack(@PathVariable Long id) {
        packService.returnPack(id);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/signed/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity signed(@PathVariable Long id, @RequestParam(required = false) String uploadFile) {
        packService.signed(id, uploadFile);
        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
    }

    @PostMapping("/batchSigned")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
    public ResponseEntity batchSigned(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
        MultiOperateResult result = packService.batchSigned(packMultipleOperateDTO);
        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
    }

    // 2019.11.09 确认从订单出更新打包的拒收状态，因此取消下面4个接口，Service里面的接口暂时保留
//    @PostMapping("/complete/{id}")
//    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
//    public ResponseEntity complete(@PathVariable Long id, @RequestParam ReceiveType receiveType) {
//        packService.complete(id, receiveType);
//        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
//    }
//
//    @PostMapping("/batchComplete")
//    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
//    public ResponseEntity batchComplete(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
//        MultiOperateResult result = packService.batchComplete(packMultipleOperateDTO);
//        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
//    }
//
//    @PostMapping("/updateComplete/{id}")
//    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
//    public ResponseEntity updateComplete(@PathVariable Long id, @RequestParam ReceiveType receiveType) {
//        packService.updateComplete(id, receiveType);
//        return new ResponseEntity<>(WmsUtil.getSuccessMessage(), HttpStatus.CREATED);
//    }
//
//    @PostMapping("/batchUpdateComplete")
//    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_EDIT')")
//    public ResponseEntity batchUpdateComplete(@RequestBody PackMultipleOperateDTO packMultipleOperateDTO) {
//        MultiOperateResult result = packService.batchUpdateComplete(packMultipleOperateDTO);
//        return new ResponseEntity<>(WmsUtil.getResultMessage(result), HttpStatus.CREATED);
//    }

    @GetMapping("/batchPrint")
    @PreAuthorize("hasAnyRole('ADMIN', 'T_PACK_LIST')")
    public ResponseEntity batchPrint(@RequestParam String packIds) throws IOException {
        HttpHeaders headers = new HttpHeaders();
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Disposition"));
        headers.set("Content-Disposition", "inline; filename=packs.pdf");
        headers.setAccessControlExposeHeaders(Collections.singletonList("Content-Type"));
        headers.set("Content-Type", "application/pdf");
        return new ResponseEntity<>(packService.batchPrint(packIds), headers, HttpStatus.OK);
    }
}
