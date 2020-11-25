import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryOrder(params) {
  const {
    payload: {
      exportExcel,
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isPrintedFilter,
      isSatisfiedFilter,
      customerFilter,
      orderStatusFilter,
      receiveTypeFilter,
    },
  } = params;

  let queryString = '/api/customer_orders?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (isPrintedFilter && isPrintedFilter !== '' && isPrintedFilter.length !== 0) {
    queryString += `isPrintedFilter=${isPrintedFilter}&`;
  }

  if (isSatisfiedFilter && isSatisfiedFilter !== '' && isSatisfiedFilter.length !== 0) {
    queryString += `isSatisfiedFilter=${isSatisfiedFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (orderStatusFilter && orderStatusFilter !== '' && orderStatusFilter.length !== 0) {
    queryString += `orderStatusFilter=${orderStatusFilter}&`;
  }

  if (receiveTypeFilter && receiveTypeFilter !== '' && receiveTypeFilter.length !== 0) {
    queryString += `receiveTypeFilter=${receiveTypeFilter}&`;
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
        anchor.download = 'orders.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function queryOrderForComplete(params) {
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
      packTypeFilter,
      receiveTypeFilter,
    },
  } = params;

  let queryString = '/api/customer_orders/list_for_complete?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (packTypeFilter && packTypeFilter !== '' && packTypeFilter.length !== 0) {
    queryString += `packTypeFilter=${packTypeFilter}&`;
  }

  if (receiveTypeFilter && receiveTypeFilter !== '' && receiveTypeFilter.length !== 0) {
    queryString += `receiveTypeFilter=${receiveTypeFilter}&`;
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
        anchor.download = 'orders.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function queryOrderForConfirm(params) {
  const {
    payload: {
      search,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      isSatisfiedFilter,
      orderStatusFilter,
      customerFilter,
    },
  } = params;

  let queryString = '/api/customer_orders/list_for_gather_confirm?';

  if (isSatisfiedFilter && isSatisfiedFilter !== '' && isSatisfiedFilter.length !== 0) {
    queryString += `isSatisfiedFilter=${isSatisfiedFilter}&`;
  }

  if (orderStatusFilter && orderStatusFilter !== '' && orderStatusFilter.length !== 0) {
    queryString += `orderStatusFilter=${orderStatusFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
  if (startDate && startDate !== '' && endDate && endDate !== '')
    queryString += `startDate=${startDate}&endDate=${endDate}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);

  return request(queryString);
}

export async function queryOrderForPack(params) {
  const {
    payload: { search, pageSize, currentPage, customerFilter },
  } = params;

  let queryString = '/api/customer_orders/list_for_pack?';

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  return request(queryString);
}

function addOrUpdateOrder(path, payload, method) {
  const body = payload;
  delete body.id;
  const {
    orderId,
    customer: customerId,
    targetWareZones,
    description,
    autoIncreaseSn,
    allItems,
  } = payload;
  let newAllItems;
  const newOrderItems = [];
  const newStockItems = [];
  if (allItems !== null && allItems !== undefined) {
    newAllItems = Object.keys(allItems).map(e => allItems[e]);
    newAllItems.forEach(item => {
      if (item.expireDate === null) {
        newOrderItems.push({
          ...item,
          id: null,
        });
      } else {
        newStockItems.push({
          ...item,
          id: null,
          goods: { id: item.id, sn: item.sn },
          warePosition: { id: item.warePosition[1], wareZone: { id: item.warePosition[0] } },
        });
      }
    });
  }
  delete body.allItems;

  return request(path, {
    method,
    body: {
      ...body,
      id: orderId,
      owner: { id: customerId },
      description,
      autoIncreaseSn,
      targetWareZones: targetWareZones.join(),
      expireDateMin: body.orderExpireDateMin,
      expireDateMax: body.orderExpireDateMax,
      customerOrderItems: newOrderItems,
      customerOrderStocks: newStockItems,
    },
  });
}

export async function addOrder(params) {
  const { useNewAutoIncreaseSn, fetchStocks } = params;
  return addOrUpdateOrder(
    `/api/customer_orders?useNewAutoIncreaseSn=${useNewAutoIncreaseSn}&fetchStocks=${fetchStocks}`,
    params,
    'POST'
  );
}

export async function updateOrder(params) {
  const { useNewAutoIncreaseSn, fetchStocks } = params;
  return addOrUpdateOrder(
    `/api/customer_orders?useNewAutoIncreaseSn=${useNewAutoIncreaseSn}&fetchStocks=${fetchStocks}`,
    params,
    'PUT'
  );
}

export async function auditOrder(payload) {
  return addOrUpdateOrder('/api/customer_orders/audit', payload, 'PUT');
}

export async function queryOrderDetail(payload) {
  const { id } = payload;
  return request(`/api/customer_orders/${id}`);
}

export async function queryOrderDetailForEdit(payload) {
  const { id } = payload;
  return request(`/api/customer_orders/${id}?queryQuantityLeft=true`);
}

export async function deleteOrder(params) {
  return request(`/api/customer_orders/${params}`, {
    method: 'DELETE',
  });
}

export async function fetchStocksByIds(ids) {
  return request(`/api/customer_orders/fetchStocks`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function deleteOrderByIds(ids) {
  return request(`/api/customer_orders/batchDelete`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function cancelOrderByIds(params) {
  return request(`/api/customer_orders/batchCancel`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function returnOrderStocksByIds(ids) {
  return request(`/api/customer_orders/batchReturnStock`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function gatherOrderByIds(ids) {
  return request(`/api/customer_orders/batchGatherGoods`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function unGatherOrderByIds(ids) {
  return request(`/api/customer_orders/batchUnGatherGoods`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function completeGatherOrderByIds(ids) {
  return request(`/api/customer_orders/batchCompleteGatherGoods`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function unCompleteGatherOrderByIds(ids) {
  return request(`/api/customer_orders/batchUnCompleteGatherGoods`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function confirmOrderByIds(ids) {
  return request(`/api/customer_orders/batchConfirm`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function completeOrderByIds(ids) {
  return request(`/api/customer_orders/batchConfirm`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function unConfirmOrderByIds(ids) {
  return request(`/api/customer_orders/batchUnConfirm`, {
    method: 'POST',
    body: {
      ids,
    },
  });
}

export async function completeOrder(params) {
  return request(`/api/customer_orders/complete`, {
    method: 'PUT',
    body: {
      id: params.id,
      completePrice: params.completePrice,
      receiveType: params.receiveType,
      completeDescription: params.completeDescription,
    },
  });
}

export async function updateCompleteOrder(params) {
  return request(`/api/customer_orders/updateComplete`, {
    method: 'PUT',
    body: {
      id: params.id,
      completePrice: params.updateCompletePrice,
      receiveType: params.receiveType,
      completeDescription: params.updateCompleteDescription,
    },
  });
}

export async function printOrderByIds(ids) {
  const queryString = `/api/customer_orders/batchPrint?orderIds=${ids.join(',')}`;
  const headers = new Headers();
  headers.append('Authorization', `Bearer ${getToken()}`);
  let objectUrl = null;
  await fetch(queryString, { headers })
    .then(response => response.blob())
    .then(blobBody => {
      objectUrl = URL.createObjectURL(blobBody);
    });
  return objectUrl;
}

export async function printOriginOrderByIds(ids) {
  const queryString = `/api/customer_orders/batchPrintOrigin?orderIds=${ids.join(',')}`;
  const headers = new Headers();
  headers.append('Authorization', `Bearer ${getToken()}`);
  let objectUrl = null;
  await fetch(queryString, { headers })
    .then(response => response.blob())
    .then(blobBody => {
      objectUrl = URL.createObjectURL(blobBody);
    });
  return objectUrl;
}

export async function importOrderByKingdee(params) {
  return request(`/api/customer_orders/import_kingdee`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function importOrderByKingdee2(params) {
  return request(`/api/customer_orders/import_kingdee2`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function importOrderByHtml(params) {
  return request(`/api/customer_orders/import_html`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}

export async function importOrderByGeneral(params) {
  return request(`/api/customer_orders/import_general`, {
    method: 'POST',
    body: {
      ...params,
    },
  });
}
