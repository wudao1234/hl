import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryPack(params) {
  const {
    payload: {
      exportExcel,
      search,
      searchAddress,
      searchOrderSn,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isPackagedFilter,
      packTypeFilter,
      receiveTypeFilter,
      packStatusFilter,
      customerFilter,
      addressTypeFilter,
    },
  } = params;

  let queryString = '/api/packs?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (isPrintedFilter && isPrintedFilter !== '' && isPrintedFilter.length !== 0) {
    queryString += `isPrintedFilter=${isPrintedFilter}&`;
  }

  if (isPackagedFilter && isPackagedFilter !== '' && isPackagedFilter.length !== 0) {
    queryString += `isPackagedFilter=${isPackagedFilter}&`;
  }

  if (packTypeFilter && packTypeFilter !== '' && packTypeFilter.length !== 0) {
    queryString += `packTypeFilter=${packTypeFilter}&`;
  }

  if (receiveTypeFilter && receiveTypeFilter !== '' && receiveTypeFilter.length !== 0) {
    queryString += `receiveTypeFilter=${receiveTypeFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (addressTypeFilter && addressTypeFilter !== '' && addressTypeFilter.length !== 0) {
    queryString += `addressTypeFilter=${addressTypeFilter}&`;
  }

  if (packStatusFilter && packStatusFilter !== '' && packStatusFilter.length !== 0) {
    queryString += `packStatusFilter=${packStatusFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
  if (searchAddress && searchAddress !== '') queryString += `searchAddress=${searchAddress}&`;
  if (searchOrderSn && searchOrderSn !== '') queryString += `searchOrderSn=${searchOrderSn}&`;
  if (startDate && startDate !== '' && endDate && endDate !== '')
    queryString += `startDate=${startDate}&endDate=${endDate}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);

  if (exportExcel === true) {
    const anchor = document.createElement('a');
    const headers = new Headers();
    headers.append('Authorization', `Bearer ${getToken()}`);
    return fetch(queryString, { headers })
      .then(response => response.blob())
      .then(blobBody => {
        const objectUrl = URL.createObjectURL(blobBody);
        anchor.href = objectUrl;
        anchor.download = 'packs.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

function addOrUpdatePack(path, payload, method) {
  const body = payload;
  const { packId, customer: customerId, address: addressId } = payload;

  if (addressId !== null) {
    body.address = { id: addressId };
  }
  body.customer = { id: customerId };

  return request(path, {
    method,
    body: {
      ...body,
      id: packId,
    },
  });
}

export async function queryPackStockFlows(params) {
  const { id } = params;
  return request(`/api/packs/${id}/stock_flows`);
}

export async function addPack(params) {
  return addOrUpdatePack(`/api/packs`, params, 'POST');
}

export async function updatePack(payload) {
  return addOrUpdatePack('/api/packs', payload, 'PUT');
}

export async function auditPack(payload) {
  return addOrUpdatePack('/api/packs/audit', payload, 'PUT');
}

export async function queryPackDetail(payload) {
  const { id } = payload;
  return request(`/api/packs/${id}`);
}

export async function packagePack(payload) {
  const { id, packItems } = payload;
  return request(`/api/packs/packages`, {
    method: 'POST',
    body: {
      id,
      packItems,
    },
  });
}

export async function deletePack(params) {
  return request(`/api/packs/${params}`, {
    method: 'DELETE',
  });
}

export async function deletePackByIds(ids) {
  return request(`/api/packs/batchDelete`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function cancelPackByIds(params) {
  return request(`/api/packs/batchCancel`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function sendingPackByIds(params) {
  return request(`/api/packs/batchSending`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function sendingPackByMe(ids) {
  return request(`/api/packs/sendingByMe`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function returnPackByIds(ids) {
  return request(`/api/packs/batchReturn`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function signedPackByIds(params) {
  return request(`/api/packs/batchSigned`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function completePackByIds(params) {
  return request(`/api/packs/batchComplete`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function updateCompletePackByIds(params) {
  return request(`/api/packs/batchUpdateComplete`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function printPackByIds(ids) {
  const queryString = `/api/packs/batchPrint?packIds=${ids.join(',')}`;
  const headers = new Headers();
  headers.append('Authorization', `Bearer ${getToken()}`);
  let objectUrl;
  await fetch(queryString, { headers })
    .then(response => response.blob())
    .then(blobBody => {
      objectUrl = URL.createObjectURL(blobBody);
    });
  return objectUrl;
}
