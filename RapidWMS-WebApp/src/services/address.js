import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryAddress(params) {
  const {
    payload: { exportExcel, search, pageSize, currentPage, orderBy, addressTypeFilter },
  } = params;

  let queryString = '/api/address?';
  if (exportExcel && exportExcel !== '') {
    queryString += `exportExcel=${exportExcel}&`;
  }

  if (addressTypeFilter && addressTypeFilter !== '' && addressTypeFilter.length !== 0) {
    queryString += `addressTypeFilter=${addressTypeFilter}&`;
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
        anchor.download = 'address.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function addAddress(payload) {
  const body = payload;
  delete body.id;
  return request('/api/address', {
    method: 'POST',
    body: { ...body, addressType: { id: body.addressType }, addressArea: { id: body.addressArea } },
  });
}

export async function updateAddress(body) {
  return request('/api/address', {
    method: 'PUT',
    body: { ...body, addressType: { id: body.addressType }, addressArea: { id: body.addressArea } },
  });
}

export async function deleteAddress(params) {
  return request(`/api/address/${params.id}`, {
    method: 'DELETE',
  });
}

export async function queryAllAddress() {
  return request('/api/address/all_list');
}
