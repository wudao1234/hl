package org.mstudio.modules.wms.import_legacy_data.handler;

import cn.hutool.poi.excel.sax.handler.RowHandler;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.mstudio.modules.wms.address.domain.Address;
import org.mstudio.modules.wms.address.service.AddressService;
import org.mstudio.modules.wms.address_type.domain.AddressType;
import org.mstudio.modules.wms.address_type.repository.AddressTypeRepository;

import java.util.List;
import java.util.Optional;

/**
 * @author Macrow
 * @date 2019-03-27
 */

@Slf4j
@AllArgsConstructor
public class AddressHandler implements RowHandler {

    private final static int NAME = 5;
    private final static int CONTACT = 1;
    private final static int PHONE = 2;
    private final static int DESCRIPTION_1 = 3;
    private final static int DESCRIPTION_2 = 4;

    private AddressService addressService;
    private AddressTypeRepository addressTypeRepository;

    @Override
    public void handle(int i, int i1, List<Object> list) {
        // log.info("[{}] [{}] {}", i, i1, list);

        if (i1 != 0) {
            Address address = new Address();

            if (list.get(NAME) != null && !list.get(NAME).toString().isEmpty()) {
                address.setName(list.get(NAME).toString());

            }

            if (list.get(CONTACT) != null && !list.get(CONTACT).toString().isEmpty()) {
                address.setContact(list.get(CONTACT).toString());

            }

            if (list.get(PHONE) != null && !list.get(PHONE).toString().isEmpty()) {
                address.setPhone(list.get(PHONE).toString());

            }

            String description = "";
            if (list.get(DESCRIPTION_1) != null && !list.get(DESCRIPTION_1).toString().isEmpty()) {
                description = list.get(DESCRIPTION_1).toString();

            }
            if (list.get(DESCRIPTION_2) != null && !list.get(DESCRIPTION_2).toString().isEmpty()) {
                description += ", " + list.get(DESCRIPTION_2).toString();

            }
            address.setDescription(description);

            String[] nameArray = address.getName().split("--");
            String addressTypeName = "其他";
            if (nameArray.length > 1) {
                addressTypeName = nameArray[0];
            }
            Optional<AddressType> optionalAddressType = addressTypeRepository.findTopByName(addressTypeName);
            AddressType addressType;
            if (optionalAddressType.isPresent()) {
                addressType = optionalAddressType.get();
            } else {
                addressType = new AddressType();
                addressType.setName(addressTypeName);
                addressType = addressTypeRepository.save(addressType);
            }
            address.setAddressType(addressType);
            addressService.create(address);
        }
    }

}
