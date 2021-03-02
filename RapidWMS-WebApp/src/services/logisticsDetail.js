import request from '@/utils/request';

export async function queryAddressType(params) {
  const {
    payload: { search, startDate, endDate, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/Logistics_detail?';
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

export async function statics(params) {
  const {
    payload: { search, startDate, endDate, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/Logistics_detail/statics?';
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

export async function queryAllAddressType() {
  return request('/api/Logistics_detail/all_list');
}

export async function addAddressType(payload) {
  return request('/api/Logistics_detail', {
    method: 'POST',
    body: payload,
  });
}

export async function updateAddressType(payload) {
  return request('/api/Logistics_detail', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteAddressType(params) {
  return request(`/api/Logistics_detail/${params.id}`, {
    method: 'DELETE',
  });
}
