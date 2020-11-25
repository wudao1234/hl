import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryGoods(params) {
  const {
    payload: {
      exportExcel,
      search,
      pageSize,
      currentPage,
      orderBy,
      goodsTypeFilter,
      goodsCustomerFilter,
    },
  } = params;

  let queryString = '/api/goods?';
  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }
  if (goodsTypeFilter && goodsTypeFilter !== '' && goodsTypeFilter.length !== 0) {
    queryString += `goodsTypeFilter=${goodsTypeFilter}&`;
  }

  if (goodsCustomerFilter && goodsCustomerFilter !== '' && goodsCustomerFilter.length !== 0) {
    queryString += `goodsCustomerFilter=${goodsCustomerFilter}&`;
  }
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
        anchor.download = 'goods.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function addGoods(payload) {
  const body = payload;
  delete body.id;
  const { goodsType: goodsTypeId, customer: customerId } = payload;
  return request('/api/goods', {
    method: 'POST',
    body: { ...body, goodsType: { id: goodsTypeId }, customer: { id: customerId } },
  });
}

export async function updateGoods(payload) {
  const body = payload;
  const { goodsType: goodsTypeId, customer: customerId } = payload;
  return request('/api/goods', {
    method: 'PUT',
    body: { ...body, goodsType: { id: goodsTypeId }, customer: { id: customerId } },
  });
}

export async function deleteGoods(params) {
  return request(`/api/goods/${params.id}`, {
    method: 'DELETE',
  });
}
