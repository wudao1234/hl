import request from '@/utils/request';

export async function queryaddressArea(params) {
  const {
    payload: { search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/address_area?';
  if (search && search !== '') queryString += `search=${search}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  return request(queryString);
}

export async function queryAlladdressArea() {
  return request('/api/address_area/all_list');
}

export async function addaddressArea(payload) {
  return request('/api/address_area', {
    method: 'POST',
    body: payload,
  });
}

export async function updateaddressArea(payload) {
  return request('/api/address_area', {
    method: 'PUT',
    body: payload,
  });
}

export async function deleteaddressArea(params) {
  return request(`/api/address_area/${params.id}`, {
    method: 'DELETE',
  });
}
