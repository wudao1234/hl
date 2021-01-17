import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryStock(params) {
  const {
    payload: {
      exportExcel,
      search,
      pageSize,
      currentPage,
      orderBy,
      wareZoneFilter,
      customerFilter,
      goodsTypeFilter,
      isActiveFilter,
      quantityGuaranteeSearch,
    },
  } = params;

  let queryString = '/api/stocks?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (wareZoneFilter && wareZoneFilter !== '' && wareZoneFilter.length !== 0) {
    queryString += `wareZoneFilter=${wareZoneFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (goodsTypeFilter && goodsTypeFilter !== '' && goodsTypeFilter.length !== 0) {
    queryString += `goodsTypeFilter=${goodsTypeFilter}&`;
  }

  if (isActiveFilter && isActiveFilter !== '' && isActiveFilter.length !== 0) {
    queryString += `isActiveFilter=${isActiveFilter}&`;
  }

  if (quantityGuaranteeSearch && quantityGuaranteeSearch !== '')
    queryString += `quantityGuaranteeSearch=${quantityGuaranteeSearch}&`;
  if (search && search !== '') queryString += `search=${search}&`;
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
        anchor.download = 'stocks.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function addStock(payload) {
  const body = payload;
  delete body.id;
  const { wareZone: wareZoneId, customer: customerId, goodsType: goodsTypeId } = payload;
  return request('/api/stocks', {
    method: 'POST',
    body: {
      ...body,
      wareZoneId: { id: wareZoneId },
      goodsType: { id: goodsTypeId },
      customer: { id: customerId },
    },
  });
}

export async function updateStock(payload) {
  const body = payload;
  const { wareZone: wareZoneId, customer: customerId, goodsType: goodsTypeId } = payload;
  return request('/api/stocks', {
    method: 'PUT',
    body: {
      ...body,
      wareZoneId: { id: wareZoneId },
      goodsType: { id: goodsTypeId },
      customer: { id: customerId },
    },
  });
}

export async function deleteStock(params) {
  return request(`/api/stocks/${params.id}`, {
    method: 'DELETE',
  });
}

export async function activateStock(payload) {
  return request(`/api/stocks/activate`, {
    method: 'POST',
    body: payload,
  });
}

export async function singleOperateStock(payload) {
  return request(`/api/stocks/single_operate`, {
    method: 'POST',
    body: payload,
  });
}

export async function multipleOperateStock(payload) {
  return request(`/api/stocks/multiple_operate`, {
    method: 'POST',
    body: payload,
  });
}
