import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryStore(params) {
  const {
    payload: { exportExcel, search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/stores?';
  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
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
        anchor.download = 'stores.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function addStore(payload) {
  const body = payload;
  delete body.id;
  return request('/api/stores', {
    method: 'POST',
    body: { ...body, storeType: { id: body.storeType } },
  });
}

export async function updateStore(body) {
  return request('/api/stores', {
    method: 'PUT',
    body: { ...body, storeType: { id: body.storeType } },
  });
}

export async function deleteStore(params) {
  return request(`/api/stores/${params.id}`, {
    method: 'DELETE',
  });
}

export async function queryAllStore() {
  return request('/api/stores/all_list');
}
