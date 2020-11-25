import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryWareZone(params) {
  const {
    payload: { exportExcel, search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/ware_zones?';
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
        anchor.download = 'wareZones.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function queryAllWareZone() {
  return request('/api/ware_zones/all_list');
}

export async function queryTree() {
  return request('/api/ware_zones/tree');
}

export async function addWareZone(payload) {
  const body = payload;
  delete body.id;
  return request('/api/ware_zones', {
    method: 'POST',
    body,
  });
}

export async function updateWareZone(payload) {
  return request('/api/ware_zones', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteWareZone(params) {
  return request(`/api/ware_zones/${params.id}`, {
    method: 'DELETE',
  });
}
