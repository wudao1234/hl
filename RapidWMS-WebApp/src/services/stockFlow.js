import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryStockFlows(params) {
  const {
    payload: {
      exportExcel,
      search,
      searchWarePositionIn,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      flowOperateTypeFilter,
      customerFilter,
      wareZoneInFilter,
      wareZoneOutFilter,
    },
  } = params;

  let queryString = '/api/stock_flows?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (flowOperateTypeFilter && flowOperateTypeFilter !== '' && flowOperateTypeFilter.length !== 0) {
    queryString += `flowOperateTypeFilter=${flowOperateTypeFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (wareZoneInFilter && wareZoneInFilter !== '' && wareZoneInFilter.length !== 0) {
    queryString += `wareZoneInFilter=${wareZoneInFilter}&`;
  }

  if (wareZoneOutFilter && wareZoneOutFilter !== '' && wareZoneOutFilter.length !== 0) {
    queryString += `wareZoneOutFilter=${wareZoneOutFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
  if (searchWarePositionIn && searchWarePositionIn !== '')
    queryString += `searchWarePositionIn=${searchWarePositionIn}&`;
  if (searchWarePositionOut && searchWarePositionOut !== '')
    queryString += `searchWarePositionOut=${searchWarePositionOut}&`;
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
        anchor.download = 'stockFlows.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function queryStockFlowForOrders(params) {
  const {
    payload: {
      exportExcel,
      search,
      searchWarePositionOut,
      startDate,
      endDate,
      pageSize,
      currentPage,
      orderBy,
      wareZoneOutFilter,
      customerFilter,
    },
  } = params;

  let queryString = '/api/stock_flows/list_for_orders?';

  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (wareZoneOutFilter && wareZoneOutFilter !== '' && wareZoneOutFilter.length !== 0) {
    queryString += `wareZoneOutFilter=${wareZoneOutFilter}&`;
  }

  if (customerFilter && customerFilter !== '' && customerFilter.length !== 0) {
    queryString += `customerFilter=${customerFilter}&`;
  }

  if (search && search !== '') queryString += `search=${search}&`;
  if (searchWarePositionOut && searchWarePositionOut !== '')
    queryString += `searchWarePositionOut=${searchWarePositionOut}&`;
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
        anchor.download = 'stockFlowForOrders.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }

  return request(queryString);
}

export async function queryByOrderId(params) {
  return request(`/api/stock_flows/findByOrderId/${params.payload}`);
}

export async function queryByReceiveGoodsId(params) {
  return request(`/api/stock_flows/findByReceiveGoodsId/${params.payload}`);
}
