import request from '@/utils/request';
import { getToken } from '../models/login';

export async function queryCustomer(params) {
  const {
    payload: { exportExcel, search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/customers?';
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
        anchor.download = 'customers.xlsx';
        anchor.click();
        URL.revokeObjectURL(objectUrl);
      });
  }
  return request(queryString);
}

export async function queryAllCustomer() {
  return request('/api/customers/all_list');
}

export async function queryMyCustomer() {
  return request('/api/customers/my_list');
}

export async function addCustomer(payload) {
  const body = payload;
  delete body.id;
  const users = [];
  payload.users.forEach(user => users.push({ id: user }));
  return request('/api/customers', {
    method: 'POST',
    body: { ...body, users },
  });
}

export async function updateCustomer(payload) {
  const users = [];
  payload.users.forEach(user => users.push({ id: user }));
  return request('/api/customers', {
    method: 'PUT',
    body: { ...payload, users },
  });
}

export async function deleteCustomer(params) {
  return request(`/api/customers/${params.id}`, {
    method: 'DELETE',
  });
}
