import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryWarePosition(params) {
  const {
    payload: { exportExcel, search, pageSize, currentPage, orderBy, wareZoneFilter },
  } = params;

  let queryString = '/api/ware_positions?';
  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }
  if (wareZoneFilter && wareZoneFilter !== '' && wareZoneFilter.length !== 0) {
    queryString += `wareZoneFilter=${wareZoneFilter}&`;
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
        anchor.download = 'warePositions.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function addWarePosition(payload) {
  const body = payload;
  delete body.id;
  const { wareZone: wareZoneId } = payload;
  return request('/api/ware_positions', {
    method: 'POST',
    body: { ...body, wareZone: { id: wareZoneId } },
  });
}

export async function updateWarePosition(payload) {
  const body = payload;
  const { wareZone: wareZoneId } = payload;
  return request('/api/ware_positions', {
    method: 'PUT',
    body: { ...body, wareZone: { id: wareZoneId } },
  });
}

export async function deleteWarePosition(params) {
  return request(`/api/ware_positions/${params.id}`, {
    method: 'DELETE',
  });
}
