import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryReceiveGoods(params) {
  const {
    payload: {
      exportExcel,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      customerFilter,
      receiveGoodsTypeFilter,
      isAuditedFilter,
    },
  } = params;

  let queryString = '/api/receive_goods?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (
    receiveGoodsTypeFilter &&
    receiveGoodsTypeFilter !== '' &&
    receiveGoodsTypeFilter.length !== 0
  ) {
    queryString += `receiveGoodsTypeFilter=${receiveGoodsTypeFilter}&`;
  }

  if (isAuditedFilter && isAuditedFilter !== '' && isAuditedFilter.length !== 0) {
    queryString += `isAuditedFilter=${isAuditedFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
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
        anchor.download = 'receiveGoods.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }

  return request(queryString);
}

function addOrUpdateReceiveGoods(path, payload, method) {
  const body = payload;
  delete body.id;
  const {
    receiveGoodsId,
    customer: customerId,
    receiveGoodsType,
    description,
    receiveGoodsItems,
  } = payload;

  let newReceiveGoodsItems;
  if (receiveGoodsItems !== null && receiveGoodsItems !== undefined) {
    newReceiveGoodsItems = Object.keys(receiveGoodsItems).map(e => receiveGoodsItems[e]);
    newReceiveGoodsItems = newReceiveGoodsItems.map(item => {
      const newItem = {
        ...item,
        goods: { id: item.id },
        warePosition: { id: item.warePosition[1] },
      };
      delete newItem.id;
      return newItem;
    });
  } else {
    newReceiveGoodsItems = [];
  }

  return request(path, {
    method,
    body: {
      ...body,
      id: receiveGoodsId,
      customer: { id: customerId },
      receiveGoodsType,
      description,
      receiveGoodsItems: newReceiveGoodsItems,
    },
  });
}

export async function putInStorage(payload) {
  const { id } = payload;
  return request(`/api/receive_goods/put_in_storage/${id}`);
}

export async function addReceiveGoods(payload) {
  return addOrUpdateReceiveGoods('/api/receive_goods/unload', payload, 'POST');
}

export async function updateReceiveGoods(payload) {
  return addOrUpdateReceiveGoods('/api/receive_goods', payload, 'PUT');
}

export async function auditReceiveGoods(payload) {
  return addOrUpdateReceiveGoods('/api/receive_goods/audit', payload, 'PUT');
}

export async function cancelAuditReceiveGoods(payload) {
  return addOrUpdateReceiveGoods('/api/receive_goods/cancel_audit', payload, 'PUT');
}

export async function queryReceiveGoodsDetail(payload) {
  const { id } = payload;
  return request(`/api/receive_goods/${id}`);
}

export async function deleteReceiveGoods(params) {
  return request(`/api/receive_goods/${params}`, {
    method: 'DELETE',
  });
}
