import request from '@/utils/request';

export async function queryLogisticsTemplate(params) {
  const {
    payload: { search, pageSize, currentPage, orderBy },
  } = params;

  let queryString = '/api/Logistics_template?';
  if (search && search !== '') queryString += `search=${search}&`;
  if (pageSize && pageSize !== '') queryString += `size=${pageSize}&`;
  if (currentPage && currentPage !== '') queryString += `page=${currentPage - 1}&`;
  if (orderBy && orderBy !== '') queryString += `sort=${orderBy.substring(0, orderBy.length - 3)}`;
  if (queryString.charAt(queryString.length - 1) === '&')
    queryString = queryString.substring(0, queryString.length - 1);
  return request(queryString);
}

export async function queryAllLogisticsTemplate() {
  return request('/api/Logistics_template/all_list');
}

export async function fetchGroupAll() {
  return request('/api/Logistics_template/fetch_group_all');
}

export async function addLogisticsTemplate(payload) {
  return request('/api/Logistics_template', {
    method: 'POST',
    body: { ...payload, addressArea: { id: payload.addressArea } },
  });
}

export async function updateLogisticsTemplate(payload) {
  return request('/api/Logistics_template', {
    method: 'PUT',
    body: { ...payload, addressArea: { id: payload.addressArea } },
  });
}

export async function deleteLogisticsTemplate(params) {
  return request(`/api/Logistics_template/${params.id}`, {
    method: 'DELETE',
  });
}
